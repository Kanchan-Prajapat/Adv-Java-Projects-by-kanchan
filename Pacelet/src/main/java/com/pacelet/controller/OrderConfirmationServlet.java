package com.pacelet.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/order-confirmation")
public class OrderConfirmationServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session =
                request.getSession();


        // =========================================
        // ORDER DETAILS
        // =========================================

        String orderId =
                (String) session.getAttribute(
                        "lastOrderId"
                );

        Double bagTotalObj =
                (Double) session.getAttribute(
                        "lastOrderBagTotal"
                );

        Double discountObj =
                (Double) session.getAttribute(
                        "lastOrderDiscount"
                );

        Double totalObj =
                (Double) session.getAttribute(
                        "lastOrderTotal"
                );


        double bagTotal =
                bagTotalObj != null
                        ? bagTotalObj
                        : 0;

        double discount =
                discountObj != null
                        ? discountObj
                        : 0;

        double total =
                totalObj != null
                        ? totalObj
                        : 0;


        String couponCode =
                (String) session.getAttribute(
                        "lastOrderCoupon"
                );

        String paymentMethod =
                (String) session.getAttribute(
                        "lastOrderPaymentMethod"
                );


        // =========================================
        // SHIPPING DETAILS
        // =========================================

        String fullName =
                (String) session.getAttribute(
                        "lastOrderFullName"
                );

        String phone =
                (String) session.getAttribute(
                        "lastOrderPhone"
                );

        String address =
                (String) session.getAttribute(
                        "lastOrderAddress"
                );

        String city =
                (String) session.getAttribute(
                        "lastOrderCity"
                );

        String state =
                (String) session.getAttribute(
                        "lastOrderState"
                );

        String pincode =
                (String) session.getAttribute(
                        "lastOrderPincode"
                );


        // =========================================
        // SEND TO JSP
        // =========================================

        request.setAttribute(
                "orderId",
                orderId
        );

        request.setAttribute(
                "bagTotal",
                bagTotal
        );

        request.setAttribute(
                "discount",
                discount
        );

        request.setAttribute(
                "total",
                total
        );

        request.setAttribute(
                "couponCode",
                couponCode
        );

        request.setAttribute(
                "paymentMethod",
                paymentMethod
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
                "address",
                address
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
                "pincode",
                pincode
        );


        // =========================================
        // SHOW CONFIRMATION PAGE
        // =========================================

        request.getRequestDispatcher(
                "/order-confirmation.jsp"
        ).forward(
                request,
                response
        );
    }
}