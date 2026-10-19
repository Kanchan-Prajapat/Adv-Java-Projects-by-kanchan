package com.pacelet.data;

import com.pacelet.model.Order;

import java.util.ArrayList;
import java.util.List;

public class OrderStore {

    // Shared order list for the whole application
    private static final List<Order> orders =
            new ArrayList<>();

    // =========================================
    // ADD ORDER
    // =========================================

    public static synchronized void addOrder(Order order) {

        if (order != null) {
            orders.add(0, order);
        }
    }

    // =========================================
    // GET ALL ORDERS
    // =========================================

    public static synchronized List<Order> getOrders() {

        return new ArrayList<>(orders);
    }

    // =========================================
    // FIND ORDER
    // =========================================

    public static synchronized Order getOrder(
            String orderId
    ) {

        if (orderId == null) {
            return null;
        }

        for (Order order : orders) {

            if (orderId.equals(order.getOrderId())) {
                return order;
            }
        }

        return null;
    }

    // =========================================
    // UPDATE STATUS
    // =========================================

    public static synchronized boolean updateStatus(
            String orderId,
            String status
    ) {

        Order order = getOrder(orderId);

        if (order == null) {
            return false;
        }

        order.setStatus(status);

        return true;
    }
}