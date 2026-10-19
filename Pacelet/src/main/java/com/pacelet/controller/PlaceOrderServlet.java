package com.pacelet.controller;

import com.pacelet.model.CartItem;
import com.pacelet.model.Order;
import com.pacelet.data.OrderStore;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/checkout/place-order")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession();


        // ==========================================
        // 1. GET CART
        // ==========================================

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );

            return;
        }


        // ==========================================
        // 2. CALCULATE BAG TOTAL
        // ==========================================

        double bagTotal = 0;

        for (CartItem item : cart) {

            bagTotal +=
                    item.getPrice() * item.getQuantity();
        }


        // ==========================================
        // 3. GET COUPON / DISCOUNT
        // ==========================================

        Double discountObj =
                (Double) session.getAttribute("appliedDiscount");

        double discount =
                discountObj != null
                        ? discountObj
                        : 0;


        String couponCode =
                (String) session.getAttribute("couponCode");


        // Prevent discount from exceeding bag total

        if (discount > bagTotal) {
            discount = bagTotal;
        }


        double total =
                bagTotal - discount;


        // ==========================================
        // 4. PAYMENT METHOD
        // ==========================================

        String paymentMethod =
                (String) session.getAttribute("paymentMethod");

        if (paymentMethod == null ||
            paymentMethod.trim().isEmpty()) {

            paymentMethod = "COD";
        }


        // ==========================================
        // 5. GENERATE ORDER ID
        // ==========================================

        String orderId =
                "PAC-" +
                String.format(
                        "%05d",
                        (int) (Math.random() * 100000)
                );


        // ==========================================
        // 6. COPY CART ITEMS
        // ==========================================
        // Important:
        // Create a new list so the order keeps
        // its own snapshot of the cart.

        List<CartItem> orderItems =
                new ArrayList<>(cart);


        // ==========================================
        // 7. GET SHIPPING INFORMATION
        // ==========================================

        String fullName =
                (String) session.getAttribute(
                        "shippingFullName"
                );

        String phone =
                (String) session.getAttribute(
                        "shippingPhone"
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

        String pincode =
                (String) session.getAttribute(
                        "shippingPincode"
                );


        // ==========================================
        // 8. CREATE COMPLETE ORDER
        // ==========================================

        Order order = new Order(

                orderId,

                bagTotal,

                discount,

                total,

                couponCode,

                paymentMethod,

                "Confirmed",

                orderItems,

                fullName,

                phone,

                addressLine,

                city,

                state,

                pincode
        );


        // ==========================================
        // 9. SAVE ORDER HISTORY
        // ==========================================

OrderStore.addOrder(order);

        // ==========================================
        // 10. SAVE LAST ORDER DATA
        // ==========================================

        session.setAttribute(
                "lastOrderId",
                orderId
        );

        session.setAttribute(
                "lastOrderBagTotal",
                bagTotal
        );

        session.setAttribute(
                "lastOrderDiscount",
                discount
        );

        session.setAttribute(
                "lastOrderTotal",
                total
        );

        session.setAttribute(
                "lastOrderCoupon",
                couponCode
        );

        session.setAttribute(
                "lastOrderPaymentMethod",
                paymentMethod
        );


        // ==========================================
        // 11. SAVE SHIPPING FOR CONFIRMATION
        // ==========================================

        session.setAttribute(
                "lastOrderFullName",
                fullName
        );

        session.setAttribute(
                "lastOrderPhone",
                phone
        );

        session.setAttribute(
                "lastOrderAddress",
                addressLine
        );

        session.setAttribute(
                "lastOrderCity",
                city
        );

        session.setAttribute(
                "lastOrderState",
                state
        );

        session.setAttribute(
                "lastOrderPincode",
                pincode
        );


        // ==========================================
        // 12. CLEAR CART
        // ==========================================

        session.removeAttribute("cart");

        session.removeAttribute("couponCode");

        session.removeAttribute("appliedDiscount");


        // ==========================================
        // 13. GO TO ORDER CONFIRMATION
        // ==========================================

        response.sendRedirect(
                request.getContextPath()
                        + "/order-confirmation"
        );
    }
}