
package com.pacelet.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.pacelet.dao.UserDAO;
import com.pacelet.dao.UserDAO.UserProfileData;
import com.pacelet.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout/address")
public class ShippingAddressServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Login required
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        /*
         * ==============================
         * CART
         * ==============================
         */

        @SuppressWarnings("unchecked")
        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        double bagTotal = 0;

        for (CartItem item : cart) {
            bagTotal += item.getPrice() * item.getQuantity();
        }

        /*
         * ==============================
         * COUPON
         * ==============================
         */

        String couponCode =
                (String) session.getAttribute("couponCode");

        Double discountObj =
                (Double) session.getAttribute("appliedDiscount");

        double appliedDiscount = discountObj != null ? discountObj : 0;

        appliedDiscount = Math.max(0, Math.min(appliedDiscount, bagTotal));

        double totalPayable = Math.max(0, bagTotal - appliedDiscount);

        /*
         * ==============================
         * LOAD SAVED USER DETAILS
         * ==============================
         */

        int userId = (Integer) session.getAttribute("userId");

        try {
            UserProfileData profile = userDAO.findProfileById(userId);

            if (profile == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Saved database details
            String fullName = profile.getFullName();
            String phone = profile.getPhone();
            String pincode = profile.getPincode();
            String addressLine = profile.getAddressLine();
            String city = profile.getCity();
            String state = profile.getState();

            /*
             * Keep existing session values synchronized.
             */
            session.setAttribute("shippingFullName", fullName);
            session.setAttribute("shippingPhone", phone);
            session.setAttribute("shippingPincode", pincode);
            session.setAttribute("shippingAddressLine", addressLine);
            session.setAttribute("shippingCity", city);
            session.setAttribute("shippingState", state);

            /*
             * ==============================
             * SEND DATA TO JSP
             * ==============================
             */

            request.setAttribute("bagTotal", bagTotal);
            request.setAttribute("couponCode", couponCode);
            request.setAttribute("appliedDiscount", appliedDiscount);
            request.setAttribute("totalPayable", totalPayable);

            request.setAttribute("fullName", fullName);
            request.setAttribute("phone", phone);
            request.setAttribute("pincode", pincode);
            request.setAttribute("addressLine", addressLine);
            request.setAttribute("city", city);
            request.setAttribute("state", state);

            request.getRequestDispatcher("/shipping-address.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to load saved shipping details.", e);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        /*
         * ==============================
         * READ FORM DATA
         * ==============================
         */

        String fullName = trim(request.getParameter("fullName"));
        String phone = trim(request.getParameter("phone"));
        String pincode = trim(request.getParameter("pincode"));
        String addressLine = trim(request.getParameter("addressLine"));
        String city = trim(request.getParameter("city"));
        String state = trim(request.getParameter("state"));

        /*
         * ==============================
         * VALIDATION
         * ==============================
         */

        if (fullName.isEmpty()
                || phone.isEmpty()
                || pincode.isEmpty()
                || addressLine.isEmpty()
                || city.isEmpty()
                || state.isEmpty()) {

            request.setAttribute("error",
                    "Please fill all required fields.");

            doGet(request, response);
            return;
        }

        if (!phone.matches("\\d{10}")) {
            request.setAttribute("error",
                    "Please enter a valid 10-digit phone number.");
            doGet(request, response);
            return;
        }

        if (!pincode.matches("\\d{6}")) {
            request.setAttribute("error",
                    "Please enter a valid 6-digit pincode.");
            doGet(request, response);
            return;
        }

        /*
         * ==============================
         * SAVE ADDRESS TO DATABASE
         * ==============================
         */

        int userId = (Integer) session.getAttribute("userId");

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
                request.setAttribute("error",
                        "Could not save your address. Please try again.");
                doGet(request, response);
                return;
            }

            // Keep session data in sync
            session.setAttribute("userName", fullName);
            session.setAttribute("shippingFullName", fullName);
            session.setAttribute("shippingPhone", phone);
            session.setAttribute("shippingPincode", pincode);
            session.setAttribute("shippingAddressLine", addressLine);
            session.setAttribute("shippingCity", city);
            session.setAttribute("shippingState", state);

            /*
             * ==============================
             * CONTINUE TO PAYMENT
             * ==============================
             */

            response.sendRedirect(
                    request.getContextPath() + "/checkout/payment");

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to save shipping details.", e);
        }
    }

    private String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
