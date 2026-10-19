
package com.pacelet.controller;

import com.pacelet.dao.UserDAO;
import com.pacelet.dao.UserDAO.UserProfileData;
import com.pacelet.data.OrderStore;
import com.pacelet.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Require login
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        try {
            // Load profile from database
            UserProfileData profile = userDAO.findProfileById(userId);

            if (profile == null) {
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Refresh session name for navbar
            session.setAttribute("userName", profile.getFullName());

            request.setAttribute("fullName", profile.getFullName());
            request.setAttribute("email", profile.getEmail());
            request.setAttribute("phone", profile.getPhone());
            request.setAttribute("address", profile.getAddressLine());
            request.setAttribute("city", profile.getCity());
            request.setAttribute("state", profile.getState());
            request.setAttribute("pincode", profile.getPincode());

            // Latest order details (existing in-memory functionality)
            String orderId = (String) session.getAttribute("lastOrderId");

            Double totalObj =
                    (Double) session.getAttribute("lastOrderTotal");

            double total = totalObj != null ? totalObj : 0;

            String paymentMethod = (String) session.getAttribute(
                    "lastOrderPaymentMethod"
            );

            Order latestOrder = null;

            List<Order> orders = OrderStore.getOrders();

            // Only show an order belonging to the logged-in user.
            // OrderStore currently does not associate orders with user IDs,
            // so do not assume its first order belongs to this user.

            if (orderId != null) {
                latestOrder = OrderStore.getOrder(orderId);
            }

            if (latestOrder != null) {
                total = latestOrder.getTotal();
                paymentMethod = latestOrder.getPaymentMethod();

                request.setAttribute("latestOrder", latestOrder);
            }

            request.setAttribute("orderId", orderId);
            request.setAttribute("total", total);
            request.setAttribute("paymentMethod", paymentMethod);

            request.getRequestDispatcher("/profile.jsp")
                    .forward(request, response);

        } catch (java.sql.SQLException e) {
            throw new ServletException("Unable to load profile.", e);
        }
    }
}
