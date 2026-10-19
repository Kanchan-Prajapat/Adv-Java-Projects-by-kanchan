
package com.pacelet.controller;

import com.pacelet.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout/payment")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession();

        // =========================================
        // GET CART
        // =========================================

        @SuppressWarnings("unchecked")
        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );
            return;
        }

        // =========================================
        // CALCULATE BAG TOTAL
        // =========================================

        double bagTotal = 0;

        for (CartItem item : cart) {
            bagTotal += item.getPrice() * item.getQuantity();
        }

        // =========================================
        // COUPON
        // =========================================

        Double discountObj =
                (Double) session.getAttribute("appliedDiscount");

        double appliedDiscount =
                discountObj != null ? discountObj : 0;

        String couponCode =
                (String) session.getAttribute("couponCode");

        // =========================================
        // PREVENT INVALID DISCOUNT
        // =========================================

        appliedDiscount = Math.max(
                0,
                Math.min(appliedDiscount, bagTotal)
        );

        // =========================================
        // FINAL PAYABLE
        // =========================================

        double totalPayable = bagTotal - appliedDiscount;

        // =========================================
        // PREVIOUS PAYMENT DETAILS
        // =========================================

        String paymentMethod =
                (String) session.getAttribute("paymentMethod");

        String upiId =
                (String) session.getAttribute("upiId");

        // =========================================
        // SEND DATA TO JSP
        // =========================================

        request.setAttribute("cart", cart);
        request.setAttribute("bagTotal", bagTotal);
        request.setAttribute("appliedDiscount", appliedDiscount);
        request.setAttribute("couponCode", couponCode);
        request.setAttribute("totalPayable", totalPayable);
        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("upiId", upiId);

        // =========================================
        // PAYMENT PAGE
        // =========================================

        request.getRequestDispatcher(
                "/payment.jsp"
        ).forward(request, response);
    }

    // =========================================
    // POST
    // =========================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // =========================================
        // PAYMENT METHOD
        // =========================================

        String paymentMethod =
                request.getParameter("paymentMethod");

        String upiId =
                request.getParameter("upiId");

        // =========================================
        // VALIDATE PAYMENT METHOD
        // =========================================
// =========================================
// VALIDATE PAYMENT METHOD
// =========================================

if (paymentMethod == null
        || paymentMethod.isBlank()
        || (!"UPI".equals(paymentMethod)
        && !"Cards".equals(paymentMethod)
        && !"Netbanking".equals(paymentMethod)
        && !"COD".equals(paymentMethod))) {

    request.setAttribute(
            "paymentError",
            "Please select a valid payment method."
    );

    doGet(request, response);
    return;
}

        // =========================================
        // UPI VALIDATION
        // =========================================

        if ("UPI".equals(paymentMethod)) {

            if (upiId == null || upiId.isBlank()) {

                request.setAttribute(
                        "paymentError",
                        "Please enter your UPI ID."
                );

                doGet(request, response);
                return;
            }

            upiId = upiId.trim();
        }

        // =========================================
        // SESSION
        // =========================================

        HttpSession session = request.getSession();

        // =========================================
        // SAVE PAYMENT METHOD
        // =========================================

        session.setAttribute("paymentMethod", paymentMethod);

        // =========================================
        // SAVE / REMOVE UPI
        // =========================================

        if ("UPI".equals(paymentMethod)) {
            session.setAttribute("upiId", upiId);
        } else {
            session.removeAttribute("upiId");
        }

        // =========================================
        // GO TO REVIEW
        // =========================================

        response.sendRedirect(
                request.getContextPath() + "/checkout/review"
        );
    }
}
