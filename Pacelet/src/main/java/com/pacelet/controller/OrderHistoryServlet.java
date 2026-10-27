
package com.pacelet.controller;

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

@WebServlet("/orders")
public class OrderHistoryServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // User must be logged in
        if (session == null || !(session.getAttribute("userId") instanceof Number)) {
            response.sendRedirect(
                    request.getContextPath() + "/login"
            );
            return;
        }

        int userId = ((Number) session.getAttribute("userId")).intValue();

        try {
            // Fetch orders belonging to the logged-in user
            List<Order> orders = orderDAO.getOrdersByUserId(userId);

            request.setAttribute("orders", orders);

            request.getRequestDispatcher("/orders.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException(
                    "Unable to load order history from database.", e
            );
        }
    }
}
