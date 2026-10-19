package com.pacelet.controller;

import com.pacelet.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new java.util.ArrayList<>();
        }

        double bagTotal = 0;

for (CartItem item : cart) {

    bagTotal +=
            item.getPrice() * item.getQuantity();
}


// Coupon

Double discountObj =
        (Double) session.getAttribute("appliedDiscount");

double appliedDiscount =
        discountObj != null ? discountObj : 0;


// Prevent discount from exceeding bag total

if (appliedDiscount > bagTotal) {

    appliedDiscount = bagTotal;
}


// Final payable amount

double totalPayable =
        bagTotal - appliedDiscount;


request.setAttribute(
        "cart",
        cart
);

request.setAttribute(
        "bagTotal",
        bagTotal
);

request.setAttribute(
        "appliedDiscount",
        appliedDiscount
);

request.setAttribute(
        "totalPayable",
        totalPayable
);

request.setAttribute(
        "couponCode",
        session.getAttribute("couponCode")
);

request.setAttribute(
        "couponError",
        session.getAttribute("couponError")
);

        request.getRequestDispatcher(
                "/WEB-INF/views/customer/cart.jsp"
        ).forward(request, response);
    }
}