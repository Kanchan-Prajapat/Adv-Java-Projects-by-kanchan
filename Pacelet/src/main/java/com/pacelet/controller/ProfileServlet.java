package com.pacelet.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession();

        // =========================================
        // USER / PROFILE DETAILS
        // =========================================

        String fullName =
                (String) session.getAttribute("shippingFullName");

        String phone =
                (String) session.getAttribute("shippingPhone");

        String address =
                (String) session.getAttribute("shippingAddressLine");

        String city =
                (String) session.getAttribute("shippingCity");

        String state =
                (String) session.getAttribute("shippingState");

        String pincode =
                (String) session.getAttribute("shippingPincode");


        // =========================================
        // LAST ORDER DETAILS
        // =========================================

        String orderId =
                (String) session.getAttribute("lastOrderId");

        Double totalObj =
                (Double) session.getAttribute("lastOrderTotal");

        double total =
                totalObj != null ? totalObj : 0;


        String paymentMethod =
                (String) session.getAttribute(
                        "lastOrderPaymentMethod"
                );


        // =========================================
        // SEND DATA TO JSP
        // =========================================

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


        request.setAttribute(
                "orderId",
                orderId
        );

        request.setAttribute(
                "total",
                total
        );

        request.setAttribute(
                "paymentMethod",
                paymentMethod
        );


        // =========================================
        // OPEN PROFILE PAGE
        // =========================================

        request.getRequestDispatcher(
                "/profile.jsp"
        ).forward(
                request,
                response
        );
    }
}