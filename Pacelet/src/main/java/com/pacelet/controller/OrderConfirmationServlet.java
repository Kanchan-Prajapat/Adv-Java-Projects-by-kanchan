
package com.pacelet.controller;

import com.pacelet.data.OrderStore;
import com.pacelet.model.Order;

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

        HttpSession session = request.getSession();


        // =========================================
        // ORDER DETAILS
        // =========================================

        String orderId =
                (String) session.getAttribute("lastOrderId");

        Order order = OrderStore.getOrder(orderId);

        if (order == null) {
            response.sendRedirect(
                    request.getContextPath() + "/shop"
            );
            return;
        }

        double bagTotal = order.getBagTotal();
        double discount = order.getDiscount();
        double total = order.getTotal();

        String couponCode = order.getCouponCode();

        String paymentMethod = order.getPaymentMethod();


        // =========================================
        // SHIPPING DETAILS
        // =========================================

        String fullName = order.getFullName();
        String phone = order.getPhone();

        String address = order.getAddressLine();
        String city = order.getCity();
        String state = order.getState();
        String pincode = order.getPincode();


        // =========================================
        // SEND TO JSP
        // =========================================

        request.setAttribute("orderId", orderId);
        request.setAttribute("bagTotal", bagTotal);
        request.setAttribute("discount", discount);
        request.setAttribute("total", total);
        request.setAttribute("couponCode", couponCode);
        request.setAttribute("paymentMethod", paymentMethod);

        request.setAttribute("fullName", fullName);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);
        request.setAttribute("city", city);
        request.setAttribute("state", state);
        request.setAttribute("pincode", pincode);


        // =========================================
        // SHOW CONFIRMATION PAGE
        // =========================================

        request.getRequestDispatcher(
                "/order-confirmation.jsp"
        ).forward(request, response);
    }
}
