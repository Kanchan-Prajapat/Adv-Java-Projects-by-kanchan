
package com.pacelet.controller;

import com.pacelet.dao.UserDAO;
import com.pacelet.dao.UserDAO.UserProfileData;
import com.pacelet.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/checkout/review")
public class ReviewServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    // =========================================
    // SHOW REVIEW PAGE
    // =========================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Require login for checkout
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // =========================================
        // CART
        // =========================================

        @SuppressWarnings("unchecked")
        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        // =========================================
        // BAG TOTAL
        // =========================================

        double bagTotal = 0;

        for (CartItem item : cart) {
            bagTotal += item.getPrice() * item.getQuantity();
        }

        // =========================================
        // COUPON
        // =========================================

        String couponCode =
                (String) session.getAttribute("couponCode");

        Double discountObj =
                (Double) session.getAttribute("appliedDiscount");

        double appliedDiscount =
                discountObj != null ? discountObj : 0;

        appliedDiscount = Math.max(
                0,
                Math.min(appliedDiscount, bagTotal)
        );

        // =========================================
        // FINAL PAYABLE
        // =========================================

        double totalPayable = bagTotal - appliedDiscount;

        // =========================================
        // SHIPPING ADDRESS FROM DATABASE
        // =========================================

        int userId = (Integer) session.getAttribute("userId");

        try {
            UserProfileData profile = userDAO.findProfileById(userId);

            if (profile == null) {
                session.invalidate();
                response.sendRedirect(
                        request.getContextPath() + "/login"
                );
                return;
            }

            String fullName = profile.getFullName();
            String phone = profile.getPhone();
            String pincode = profile.getPincode();
            String addressLine = profile.getAddressLine();
            String city = profile.getCity();
            String state = profile.getState();

            // Keep existing session attributes in sync
            session.setAttribute("shippingFullName", fullName);
            session.setAttribute("shippingPhone", phone);
            session.setAttribute("shippingPincode", pincode);
            session.setAttribute("shippingAddressLine", addressLine);
            session.setAttribute("shippingCity", city);
            session.setAttribute("shippingState", state);

            // =========================================
            // PAYMENT
            // =========================================

            String paymentMethod =
                    (String) session.getAttribute("paymentMethod");

            String upiId =
                    (String) session.getAttribute("upiId");

            // =========================================
            // SEND DATA TO JSP
            // =========================================

            request.setAttribute("cart", cart);
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

            request.setAttribute("paymentMethod", paymentMethod);
            request.setAttribute("upiId", upiId);

            // =========================================
            // SHOW REVIEW PAGE
            // =========================================

            request.getRequestDispatcher("/review.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to load checkout details.", e
            );
        }
    }
}
