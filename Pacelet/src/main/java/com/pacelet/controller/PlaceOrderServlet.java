
package com.pacelet.controller;

import com.pacelet.data.OrderDAO;
import com.pacelet.model.CartItem;
import com.pacelet.model.Order;
import com.pacelet.data.CartDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebServlet("/checkout/place-order")
public class PlaceOrderServlet extends HttpServlet {

    private final OrderDAO orderDAO = new OrderDAO();
    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Require login before placing an order.
        if (session == null
                || !(session.getAttribute("userId") instanceof Number)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        int userId = ((Number) session.getAttribute("userId")).intValue();

        @SuppressWarnings("unchecked")
        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }

        double bagTotal = 0;
        for (CartItem item : cart) {
            bagTotal += item.getPrice() * item.getQuantity();
        }

        String couponCode = (String) session.getAttribute("couponCode");

        Object discountObject = session.getAttribute("appliedDiscount");
        double discount = discountObject instanceof Number
                ? ((Number) discountObject).doubleValue()
                : 0;

        discount = Math.max(0, Math.min(discount, bagTotal));
        double total = bagTotal - discount;

        String paymentMethod = (String) session.getAttribute("paymentMethod");
        if (paymentMethod == null || paymentMethod.isBlank()) {
            paymentMethod = "COD";
        }

        String fullName = (String) session.getAttribute("shippingFullName");
        String phone = (String) session.getAttribute("shippingPhone");
        String addressLine = (String) session.getAttribute("shippingAddressLine");
        String city = (String) session.getAttribute("shippingCity");
        String state = (String) session.getAttribute("shippingState");
        String pincode = (String) session.getAttribute("shippingPincode");

        if (isBlank(fullName) || isBlank(phone) || isBlank(addressLine)
                || isBlank(city) || isBlank(state) || isBlank(pincode)) {
            response.sendRedirect(
                    request.getContextPath() + "/checkout/address"
            );
            return;
        }

        String orderId = "PAC-" + UUID.randomUUID()
                .toString().substring(0, 8).toUpperCase();

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

        try {
            // Save to the database for the logged-in user.
            orderDAO.saveOrder(order, userId);

        } catch (SQLException e) {
            getServletContext().log("Failed to save Pacelet order.", e);
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Your order could not be saved. Your cart has been kept. Please try again."
            );
            return;
        }

        // Keep order details for the confirmation page.
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

        // Clear the persistent cart after the order is saved.
        try {
            cartDAO.clearCart(userId);
        } catch (SQLException e) {
            getServletContext().log(
                    "Order saved, but persistent cart could not be cleared.",
                    e
            );

            // Order is already saved; don't report the order as failed.
        }

        // Clear the session cart after successful order saving.
        cart.clear();

        session.removeAttribute("couponCode");
        session.removeAttribute("appliedDiscount");


        response.sendRedirect(
                request.getContextPath() + "/order-confirmation"
        );
    }

    private boolean isBlank(String value) {
        return value == null || value.isBlank();
    }
}
