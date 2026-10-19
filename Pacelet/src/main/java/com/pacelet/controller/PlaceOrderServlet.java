
package com.pacelet.controller;

import com.pacelet.data.OrderStore;
import com.pacelet.model.CartItem;
import com.pacelet.model.Order;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@WebServlet("/checkout/place-order")
public class PlaceOrderServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        // ==========================================
        // 1. GET SESSION
        // ==========================================

        HttpSession session = request.getSession();


        // ==========================================
        // 2. GET CART ITEMS
        // ==========================================

        @SuppressWarnings("unchecked")
        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );
            return;
        }


        // ==========================================
        // 3. CALCULATE BAG TOTAL
        // ==========================================

        double bagTotal = 0;

        for (CartItem item : cart) {
            bagTotal += item.getPrice() * item.getQuantity();
        }


        // ==========================================
        // 4. GET COUPON AND DISCOUNT
        // ==========================================

        String couponCode =
                (String) session.getAttribute("couponCode");

        Object discountObject =
                session.getAttribute("appliedDiscount");

        double discount = 0;

        if (discountObject instanceof Number) {
            discount = ((Number) discountObject).doubleValue();
        }

        discount = Math.max(0, Math.min(discount, bagTotal));

        double total = bagTotal - discount;


        // ==========================================
        // 5. GET PAYMENT METHOD
        // ==========================================

        String paymentMethod =
                (String) session.getAttribute("paymentMethod");

     if (paymentMethod == null || paymentMethod.isBlank()) {
    paymentMethod = "COD";
}

        // ==========================================
        // 6. GENERATE ORDER ID
        // ==========================================

        String orderId = "PAC-"
                + UUID.randomUUID()
                        .toString()
                        .substring(0, 8)
                        .toUpperCase();


        // ==========================================
        // 7. GET SHIPPING DETAILS
        // ==========================================

        String fullName =
                (String) session.getAttribute("shippingFullName");

        String phone =
                (String) session.getAttribute("shippingPhone");

        String addressLine =
                (String) session.getAttribute("shippingAddressLine");

        String city =
                (String) session.getAttribute("shippingCity");

        String state =
                (String) session.getAttribute("shippingState");

        String pincode =
                (String) session.getAttribute("shippingPincode");


        // ==========================================
        // 8. VALIDATE SHIPPING DETAILS
        // ==========================================

        if (fullName == null || fullName.isBlank()
                || phone == null || phone.isBlank()
                || addressLine == null || addressLine.isBlank()
                || city == null || city.isBlank()
                || state == null || state.isBlank()
                || pincode == null || pincode.isBlank()) {

            response.sendRedirect(
                    request.getContextPath() + "/checkout/address"
            );
            return;
        }


// ==========================================
// 9. CREATE ORDER
// ==========================================

Order order = new Order(
        orderId,
        bagTotal,
        discount,
        total,
        couponCode,
        paymentMethod,
        "Confirmed",
        new ArrayList<>(cart),
        fullName,
        phone,
        addressLine,
        city,
        state,
        pincode
);

        // ==========================================
        // 10. SAVE ORDER IN SHARED ORDER STORE
        // ==========================================

        OrderStore.addOrder(order);


        // ==========================================
        // 11. SAVE LAST ORDER DETAILS IN SESSION
        // ==========================================

        session.setAttribute("lastOrderId", order.getOrderId());
        session.setAttribute("lastOrderBagTotal", order.getBagTotal());
        session.setAttribute("lastOrderDiscount", order.getDiscount());
        session.setAttribute("lastOrderTotal", order.getTotal());
        session.setAttribute("lastOrderCoupon", order.getCouponCode());
        session.setAttribute("lastOrderStatus", order.getStatus());
        session.setAttribute("lastOrderDate", order.getOrderDate());
        session.setAttribute("lastOrderPaymentMethod", order.getPaymentMethod());

        session.setAttribute("lastOrderFullName", order.getFullName());
        session.setAttribute("lastOrderPhone", order.getPhone());
        session.setAttribute("lastOrderAddress", order.getAddressLine());
        session.setAttribute("lastOrderAddressLine", order.getAddressLine());
        session.setAttribute("lastOrderCity", order.getCity());
        session.setAttribute("lastOrderState", order.getState());
        session.setAttribute("lastOrderPincode", order.getPincode());


        // ==========================================
        // 12. CLEAR CART AND COUPON
        // ==========================================

        cart.clear();

        session.removeAttribute("couponCode");
        session.removeAttribute("appliedDiscount");


        // ==========================================
        // 13. REDIRECT TO ORDER CONFIRMATION
        // ==========================================

        response.sendRedirect(
                request.getContextPath() + "/order-confirmation"
        );
    }
}
