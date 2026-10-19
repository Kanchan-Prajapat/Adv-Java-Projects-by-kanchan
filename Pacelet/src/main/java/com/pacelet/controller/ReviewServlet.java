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

@WebServlet("/checkout/review")
public class ReviewServlet extends HttpServlet {

    // =========================================
    // SHOW REVIEW PAGE
    // =========================================

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession();

        // =========================================
        // CART
        // =========================================

        @SuppressWarnings("unchecked")
        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if (cart == null) {
            cart = new ArrayList<>();
        }

        // =========================================
        // BAG TOTAL
        // =========================================

        double bagTotal = 0;

        for (CartItem item : cart) {
            bagTotal +=
                    item.getPrice() * item.getQuantity();
        }

        // =========================================
        // COUPON
        // =========================================

        String couponCode =
                (String) session.getAttribute("couponCode");

        Double discountObj =
                (Double) session.getAttribute("appliedDiscount");

        double appliedDiscount =
                discountObj != null
                        ? discountObj
                        : 0;

        if (appliedDiscount > bagTotal) {
            appliedDiscount = bagTotal;
        }

        // =========================================
        // FINAL PAYABLE
        // =========================================

        double totalPayable =
                bagTotal - appliedDiscount;

        if (totalPayable < 0) {
            totalPayable = 0;
        }

        // =========================================
        // SHIPPING ADDRESS
        // =========================================

        String fullName =
                (String) session.getAttribute(
                        "shippingFullName"
                );

        String phone =
                (String) session.getAttribute(
                        "shippingPhone"
                );

        String pincode =
                (String) session.getAttribute(
                        "shippingPincode"
                );

        String addressLine =
                (String) session.getAttribute(
                        "shippingAddressLine"
                );

        String city =
                (String) session.getAttribute(
                        "shippingCity"
                );

        String state =
                (String) session.getAttribute(
                        "shippingState"
                );

        // =========================================
        // PAYMENT
        // =========================================

        String paymentMethod =
                (String) session.getAttribute(
                        "paymentMethod"
                );

        String upiId =
                (String) session.getAttribute(
                        "upiId"
                );

        // =========================================
        // SEND DATA TO JSP
        // =========================================

        request.setAttribute(
                "cart",
                cart
        );

        request.setAttribute(
                "bagTotal",
                bagTotal
        );

        request.setAttribute(
                "couponCode",
                couponCode
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
                "fullName",
                fullName
        );

        request.setAttribute(
                "phone",
                phone
        );

        request.setAttribute(
                "pincode",
                pincode
        );

        request.setAttribute(
                "addressLine",
                addressLine
        );

        request.setAttribute(
                "city",
                city
        );

        request.setAttribute(
                "state",
                state
        );

        request.setAttribute(
                "paymentMethod",
                paymentMethod
        );

        request.setAttribute(
                "upiId",
                upiId
        );

        // =========================================
        // SHOW REVIEW PAGE
        // =========================================

        request.getRequestDispatcher(
                "/review.jsp"
        ).forward(
                request,
                response
        );
    }
}