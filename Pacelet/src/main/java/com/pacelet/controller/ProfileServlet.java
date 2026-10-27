
package com.pacelet.controller;

import com.pacelet.dao.UserDAO;
import com.pacelet.dao.UserDAO.UserProfileData;
import com.pacelet.data.OrderDAO;
import com.pacelet.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null
                || !(session.getAttribute("userId") instanceof Number)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = ((Number) session.getAttribute("userId")).intValue();

        try {
            UserProfileData profile = userDAO.findProfileById(userId);

            if (profile == null) {
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            session.setAttribute("userName", profile.getFullName());

            request.setAttribute("fullName", profile.getFullName());
            request.setAttribute("email", profile.getEmail());
            request.setAttribute("phone", profile.getPhone());
            request.setAttribute("address", profile.getAddressLine());
            request.setAttribute("city", profile.getCity());
            request.setAttribute("state", profile.getState());
            request.setAttribute("pincode", profile.getPincode());

            // Fetch this user's orders from MySQL.
            List<Order> orders = orderDAO.getOrdersByUserId(userId);

            request.setAttribute("orders", orders);

            // Keep the latest-order summary attributes for existing JSP UI.
            Order latestOrder = orders.isEmpty() ? null : orders.get(0);

            if (latestOrder != null) {
                request.setAttribute("latestOrder", latestOrder);
                request.setAttribute("orderId", latestOrder.getOrderId());
                request.setAttribute("total", latestOrder.getTotal());
                request.setAttribute(
                        "paymentMethod",
                        latestOrder.getPaymentMethod()
                );
            } else {
                request.setAttribute("latestOrder", null);
                request.setAttribute("orderId", null);
                request.setAttribute("total", 0.0);
                request.setAttribute("paymentMethod", null);
            }

            request.getRequestDispatcher("/profile.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            getServletContext().log("Unable to load profile or orders.", e);
            throw new ServletException("Unable to load profile.", e);
        }
    }
}
