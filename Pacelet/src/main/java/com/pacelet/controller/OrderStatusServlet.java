
package com.pacelet.controller;

import com.pacelet.data.OrderStore;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;

@WebServlet("/order/status")
public class OrderStatusServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        // ==========================================
        // 1. GET ORDER ID AND NEW STATUS
        // ==========================================

        String orderId = request.getParameter("orderId");
        String status = request.getParameter("status");


        // ==========================================
        // 2. VALIDATE STATUS
        // ==========================================

        boolean validStatus =
                "Confirmed".equals(status)
                || "Processing".equals(status)
                || "Shipped".equals(status)
                || "Delivered".equals(status);

        if (orderId == null || orderId.trim().isEmpty()
                || !validStatus) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid order ID or status."
            );

            return;
        }


        // ==========================================
        // 3. UPDATE ORDER STATUS
        // ==========================================

        boolean updated =
                OrderStore.updateStatus(orderId, status);

        if (!updated) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Order not found."
            );

            return;
        }


        // ==========================================
        // 4. REDIRECT TO ORDER DETAILS
        // ==========================================

        String encodedOrderId = URLEncoder.encode(
                orderId,
                StandardCharsets.UTF_8
        );

        response.sendRedirect(
                request.getContextPath()
                + "/profile/order?orderId="
                + encodedOrderId
        );
    }
}
