package com.pacelet.controller;

import com.pacelet.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/orders")
public class OrderHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Get all orders from session
        @SuppressWarnings("unchecked")
        List<Order> orders =
                (List<Order>) session.getAttribute("orders");

        // If no orders exist, create empty list
        if (orders == null) {
            orders = new ArrayList<>();
        }

        // Send orders to JSP
        request.setAttribute(
                "orders",
                orders
        );

        // Open orders page
        request.getRequestDispatcher(
                "/orders.jsp"
        ).forward(
                request,
                response
        );
    }
}