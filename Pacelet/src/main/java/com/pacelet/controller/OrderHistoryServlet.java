
package com.pacelet.controller;

import com.pacelet.data.OrderStore;
import com.pacelet.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/orders")
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        // ==========================================
        // 1. GET ALL ORDERS
        // ==========================================

        List<Order> orders = OrderStore.getOrders();


        // ==========================================
        // 2. SEND ORDERS TO JSP
        // ==========================================

        request.setAttribute("orders", orders);


        // ==========================================
        // 3. OPEN ORDER HISTORY PAGE
        // ==========================================

        request.getRequestDispatcher(
                "/orders.jsp"
        ).forward(request, response);
    }
}
