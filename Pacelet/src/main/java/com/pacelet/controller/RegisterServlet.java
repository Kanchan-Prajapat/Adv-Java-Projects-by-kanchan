
package com.pacelet.controller;

import com.pacelet.dao.UserDAO;
import org.mindrot.jbcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/views/customer/register.jsp"
        ).forward(request, response);
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword =
                request.getParameter("confirmPassword");

        if (fullName == null || fullName.isBlank()
                || email == null || email.isBlank()
                || phone == null || phone.isBlank()
                || password == null || password.length() < 8
                || confirmPassword == null) {

            request.setAttribute(
                    "error",
                    "Please fill all fields. Password must be at least 8 characters."
            );

            doGet(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute(
                    "error",
                    "Passwords do not match."
            );

            doGet(request, response);
            return;
        }

        try {
            if (userDAO.emailExists(email.trim())) {
                request.setAttribute(
                        "error",
                        "An account with this email already exists."
                );

                doGet(request, response);
                return;
            }

            String passwordHash = BCrypt.hashpw(
                    password,
                    BCrypt.gensalt(12)
            );

            boolean saved = userDAO.registerUser(
                    fullName.trim(),
                    email.trim().toLowerCase(),
                    phone.trim(),
                    passwordHash
            );

            if (saved) {
                response.sendRedirect(
                        request.getContextPath()
                        + "/login?registered=1"
                );
            } else {
                request.setAttribute(
                        "error",
                        "Registration failed. Please try again."
                );

                doGet(request, response);
            }

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to register user.", e
            );
        }
    }
}
