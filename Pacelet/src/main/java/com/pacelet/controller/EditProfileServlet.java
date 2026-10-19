
package com.pacelet.controller;

import com.pacelet.dao.UserDAO;
import com.pacelet.dao.UserDAO.UserProfileData;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/profile/edit")
public class EditProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        try {
            UserProfileData profile = userDAO.findProfileById(userId);

            if (profile == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            request.setAttribute("fullName", profile.getFullName());
            request.setAttribute("phone", profile.getPhone());
            request.setAttribute("pincode", profile.getPincode());
            request.setAttribute("addressLine", profile.getAddressLine());
            request.setAttribute("city", profile.getCity());
            request.setAttribute("state", profile.getState());

            request.getRequestDispatcher("/edit-profile.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Unable to load profile for editing.", e);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String fullName = trim(request.getParameter("fullName"));
        String phone = trim(request.getParameter("phone"));
        String pincode = trim(request.getParameter("pincode"));
        String addressLine = trim(request.getParameter("addressLine"));
        String city = trim(request.getParameter("city"));
        String state = trim(request.getParameter("state"));

        // Required-field validation
        if (fullName.isEmpty()
                || phone.isEmpty()
                || pincode.isEmpty()
                || addressLine.isEmpty()
                || city.isEmpty()
                || state.isEmpty()) {

            showError(request, response,
                    "Please fill all required fields.",
                    fullName, phone, pincode, addressLine, city, state);
            return;
        }

        // Phone validation
        if (!phone.matches("\\d{10}")) {
            showError(request, response,
                    "Please enter a valid 10-digit phone number.",
                    fullName, phone, pincode, addressLine, city, state);
            return;
        }

        // Pincode validation
        if (!pincode.matches("\\d{6}")) {
            showError(request, response,
                    "Please enter a valid 6-digit pincode.",
                    fullName, phone, pincode, addressLine, city, state);
            return;
        }

        try {
            boolean updated = userDAO.updateProfile(
                    userId,
                    fullName,
                    phone,
                    addressLine,
                    city,
                    state,
                    pincode
            );

            if (!updated) {
                showError(request, response,
                        "Profile could not be updated. Please log in again.",
                        fullName, phone, pincode, addressLine, city, state);
                return;
            }

            // Keep session data in sync for checkout/navbar compatibility
            session.setAttribute("userName", fullName);
            session.setAttribute("shippingFullName", fullName);
            session.setAttribute("shippingPhone", phone);
            session.setAttribute("shippingPincode", pincode);
            session.setAttribute("shippingAddressLine", addressLine);
            session.setAttribute("shippingCity", city);
            session.setAttribute("shippingState", state);

            response.sendRedirect(request.getContextPath() + "/profile");

        } catch (SQLException e) {
            throw new ServletException("Unable to update profile.", e);
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }

    private void showError(
            HttpServletRequest request,
            HttpServletResponse response,
            String message,
            String fullName,
            String phone,
            String pincode,
            String addressLine,
            String city,
            String state
    ) throws ServletException, IOException {

        request.setAttribute("error", message);
        request.setAttribute("fullName", fullName);
        request.setAttribute("phone", phone);
        request.setAttribute("pincode", pincode);
        request.setAttribute("addressLine", addressLine);
        request.setAttribute("city", city);
        request.setAttribute("state", state);

        request.getRequestDispatcher("/edit-profile.jsp")
                .forward(request, response);
    }
}
