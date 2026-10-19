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

@WebServlet("/admin/orders")
public class AdminOrdersServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        @SuppressWarnings("unchecked")
        List<Order> orders =
                (List<Order>) session.getAttribute(
                        "orders"
                );

        if (orders == null) {
            orders = new ArrayList<>();
        }

        request.setAttribute(
                "orders",
                orders
        );

        request.getRequestDispatcher(
                "/admin-orders.jsp"
        ).forward(
                request,
                response
        );
    }
}