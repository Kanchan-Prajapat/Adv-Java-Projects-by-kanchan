
package com.pacelet.controller;

import com.pacelet.dao.UserDAO;
import com.pacelet.dao.UserDAO.UserLoginData;
import com.pacelet.data.CartDAO;
import com.pacelet.model.CartItem;

import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/customer/login.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.isBlank()
                || password == null || password.isEmpty()) {

            request.setAttribute(
                    "error",
                    "Please enter your email and password."
            );
            doGet(request, response);
            return;
        }

        try {
            UserLoginData user =
                    userDAO.findUserByEmail(email.trim().toLowerCase());

            if (user == null
                    || !BCrypt.checkpw(
                            password,
                            user.getPasswordHash()
                    )) {

                request.setAttribute(
                        "error",
                        "Invalid email or password."
                );
                doGet(request, response);
                return;
            }

            HttpSession oldSession = request.getSession(false);

            if (oldSession != null) {
                oldSession.invalidate();
            }

            HttpSession session = request.getSession(true);

            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", user.getFullName());
            session.setAttribute("userEmail", user.getEmail());
            session.setMaxInactiveInterval(30 * 60);

            // Restore this user's saved cart from MySQL.
            try {
                List<CartItem> savedCart =
                        cartDAO.getCartItems(user.getUserId());

                session.setAttribute("cart", savedCart);

            } catch (SQLException e) {
                getServletContext().log(
                        "Unable to restore saved cart after login.", e
                );

                session.setAttribute("cart", new ArrayList<CartItem>());
                session.setAttribute(
                        "cartLoadError",
                        "Your saved cart could not be loaded."
                );
            }

            response.sendRedirect(
                    request.getContextPath() + "/"
            );

        } catch (SQLException e) {
            throw new ServletException("Unable to log in.", e);
        }
    }
}
