package com.pacelet.controller;

import com.pacelet.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/order/status")
public class OrderStatusServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String orderId =
                request.getParameter("orderId");

        String status =
                request.getParameter("status");

        // Validate input
        if (orderId == null ||
            orderId.trim().isEmpty() ||
            status == null ||
            status.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/profile"
            );

            return;
        }

        // Allowed statuses
        if (!status.equals("Confirmed") &&
            !status.equals("Processing") &&
            !status.equals("Shipped") &&
            !status.equals("Delivered")) {

            response.sendRedirect(
                    request.getContextPath() + "/profile"
            );

            return;
        }

        HttpSession session =
                request.getSession();

        @SuppressWarnings("unchecked")
        List<Order> orders =
                (List<Order>) session.getAttribute("orders");

        if (orders != null) {

            for (Order order : orders) {

                if (order.getOrderId().equals(orderId)) {

                    order.setStatus(status);

                    break;
                }
            }

            session.setAttribute(
                    "orders",
                    orders
            );
        }

        // Return to order details
        response.sendRedirect(
                request.getContextPath()
                        + "/profile/order?orderId="
                        + orderId
        );
    }
}