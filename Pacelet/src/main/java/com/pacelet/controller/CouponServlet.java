package com.pacelet.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cart/coupon")
public class CouponServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String couponCode =
                request.getParameter("couponCode");

        HttpSession session =
                request.getSession();

        if (couponCode == null || couponCode.isBlank()) {

            session.setAttribute(
                    "couponError",
                    "Please enter a promotion code."
            );

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );

            return;
        }

        couponCode =
                couponCode.trim().toUpperCase();


        double discount = 0;


        /*
         * Confirmed existing Pacelet logic:
         * PACE10 = ₹500
         */

        if (couponCode.equals("PACE10")) {

            discount = 500;

        } else {

            session.setAttribute(
                    "couponError",
                    "Invalid promotion code."
            );

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );

            return;
        }


        session.setAttribute(
                "couponCode",
                couponCode
        );

        session.setAttribute(
                "appliedDiscount",
                discount
        );

        session.removeAttribute("couponError");


        response.sendRedirect(
                request.getContextPath() + "/cart"
        );
    }
}