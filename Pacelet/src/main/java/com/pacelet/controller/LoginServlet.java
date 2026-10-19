
package com.pacelet.controller;

import com.pacelet.dao.UserDAO;
import com.pacelet.dao.UserDAO.UserLoginData;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

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

            response.sendRedirect(
                    request.getContextPath() + "/"
            );

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to log in.", e
            );
        }
    }
}
