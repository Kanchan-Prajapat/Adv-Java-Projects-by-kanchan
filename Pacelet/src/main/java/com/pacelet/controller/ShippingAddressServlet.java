package com.pacelet.controller;

import java.io.IOException;
import java.util.List;

import com.pacelet.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/checkout/address")
public class ShippingAddressServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        /*
         * ==============================
         * CART
         * ==============================
         */

        @SuppressWarnings("unchecked")
        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        double bagTotal = 0;

        if (cart != null) {

            for (CartItem item : cart) {

                bagTotal +=
                        item.getPrice() * item.getQuantity();
            }
        }


        /*
         * ==============================
         * COUPON
         * ==============================
         */

        String couponCode =
                (String) session.getAttribute("couponCode");

        Double discountObj =
                (Double) session.getAttribute("appliedDiscount");

        double appliedDiscount =
                discountObj != null
                        ? discountObj
                        : 0;


        /*
         * ==============================
         * TOTAL
         * ==============================
         */

        double totalPayable =
                Math.max(
                        0,
                        bagTotal - appliedDiscount
                );


        /*
         * ==============================
         * SEND DATA TO JSP
         * ==============================
         */

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


        /*
         * ==============================
         * FORWARD
         * ==============================
         */

        request.getRequestDispatcher(
                "/shipping-address.jsp"
        ).forward(request, response);
    }


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");


        /*
         * ==============================
         * READ FORM DATA
         * ==============================
         */

        String fullName =
                request.getParameter("fullName");

        String phone =
                request.getParameter("phone");

        String pincode =
                request.getParameter("pincode");

        String addressLine =
                request.getParameter("addressLine");

        String city =
                request.getParameter("city");

        String state =
                request.getParameter("state");


        /*
         * ==============================
         * VALIDATION
         * ==============================
         */

        if (fullName == null || fullName.isBlank()
                || phone == null || phone.isBlank()
                || pincode == null || pincode.isBlank()
                || addressLine == null || addressLine.isBlank()
                || city == null || city.isBlank()
                || state == null || state.isBlank()) {

            request.setAttribute(
                    "error",
                    "Please fill all required fields."
            );

            doGet(request, response);

            return;
        }


        /*
         * ==============================
         * SAVE ADDRESS
         * ==============================
         */

        HttpSession session =
                request.getSession();

        session.setAttribute(
                "shippingFullName",
                fullName
        );

        session.setAttribute(
                "shippingPhone",
                phone
        );

        session.setAttribute(
                "shippingPincode",
                pincode
        );

        session.setAttribute(
                "shippingAddressLine",
                addressLine
        );

        session.setAttribute(
                "shippingCity",
                city
        );

        session.setAttribute(
                "shippingState",
                state
        );


        /*
         * ==============================
         * CONTINUE TO PAYMENT
         * ==============================
         */

        response.sendRedirect(
                request.getContextPath()
                        + "/checkout/payment"
        );
    }
}