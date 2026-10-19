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

@WebServlet("/profile/order")
public class OrderDetailsServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        // ==========================================
        // 1. GET ORDER ID FROM URL
        // ==========================================

        String orderId =
                request.getParameter("orderId");

        if (orderId == null || orderId.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/profile"
            );

            return;
        }


        // ==========================================
        // 2. GET SESSION
        // ==========================================

        HttpSession session =
                request.getSession();


        // ==========================================
        // 3. GET ORDER HISTORY
        // ==========================================

        List<Order> orders =
                (List<Order>) session.getAttribute("orders");


        // ==========================================
        // 4. FIND SELECTED ORDER
        // ==========================================

        Order selectedOrder = null;

        if (orders != null) {

            for (Order order : orders) {

                if (order.getOrderId().equals(orderId)) {

                    selectedOrder = order;

                    break;
                }
            }
        }


        // ==========================================
        // 5. ORDER NOT FOUND
        // ==========================================

        if (selectedOrder == null) {

            response.sendRedirect(
                    request.getContextPath() + "/profile"
            );

            return;
        }


        // ==========================================
        // 6. SEND COMPLETE ORDER TO JSP
        // ==========================================

        request.setAttribute(
                "order",
                selectedOrder
        );


        // ==========================================
        // 7. OPEN ORDER DETAILS PAGE
        // ==========================================

        request.getRequestDispatcher(
                "/order-details.jsp"
        ).forward(request, response);
    }
}