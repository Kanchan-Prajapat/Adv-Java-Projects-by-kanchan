package com.pacelet.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/cart/coupon/remove")
public class RemoveCouponServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session =
                request.getSession();

        session.removeAttribute("couponCode");
        session.removeAttribute("appliedDiscount");
        session.removeAttribute("couponError");

        response.sendRedirect(
                request.getContextPath() + "/cart"
        );
    }
}