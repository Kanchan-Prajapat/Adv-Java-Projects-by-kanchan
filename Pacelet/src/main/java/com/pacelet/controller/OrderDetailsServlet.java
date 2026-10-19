
package com.pacelet.controller;

import com.pacelet.data.OrderStore;
import com.pacelet.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

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
        // 2. FIND SELECTED ORDER FROM ORDER STORE
        // ==========================================

        Order selectedOrder =
                OrderStore.getOrder(orderId);


        // ==========================================
        // 3. ORDER NOT FOUND
        // ==========================================

        if (selectedOrder == null) {

            response.sendRedirect(
                    request.getContextPath() + "/profile"
            );

            return;
        }


        // ==========================================
        // 4. SEND COMPLETE ORDER TO JSP
        // ==========================================

        request.setAttribute(
                "order",
                selectedOrder
        );


        // ==========================================
        // 5. OPEN ORDER DETAILS PAGE
        // ==========================================

        request.getRequestDispatcher(
                "/order-details.jsp"
        ).forward(request, response);
    }
}