package com.pacelet.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class Order implements Serializable {

    private static final long serialVersionUID = 1L;

    // =========================
    // ORDER SUMMARY
    // =========================

    private String orderId;

    private double bagTotal;

    private double discount;

    private double total;

    private String couponCode;

    private String paymentMethod;

    private String status;

    private Date orderDate;


    // =========================
    // ORDER ITEMS
    // =========================

    private List<CartItem> items;


    // =========================
    // SHIPPING DETAILS
    // =========================

    private String fullName;

    private String phone;

    private String addressLine;

    private String city;

    private String state;

    private String pincode;


    // =========================
    // EXISTING CONSTRUCTOR
    // =========================
    // Keep this constructor so
    // existing code does not break.

    public Order(
            String orderId,
            double bagTotal,
            double discount,
            double total,
            String couponCode,
            String paymentMethod,
            String status
    ) {

        this.orderId = orderId;
        this.bagTotal = bagTotal;
        this.discount = discount;
        this.total = total;
        this.couponCode = couponCode;
        this.paymentMethod = paymentMethod;
        this.status = status;

        this.orderDate = new Date();

        this.items = new ArrayList<>();
    }


    // =========================
    // NEW FULL CONSTRUCTOR
    // =========================

    public Order(
            String orderId,
            double bagTotal,
            double discount,
            double total,
            String couponCode,
            String paymentMethod,
            String status,
            List<CartItem> items,
            String fullName,
            String phone,
            String addressLine,
            String city,
            String state,
            String pincode
    ) {

        this.orderId = orderId;

        this.bagTotal = bagTotal;

        this.discount = discount;

        this.total = total;

        this.couponCode = couponCode;

        this.paymentMethod = paymentMethod;

        this.status = status;

        this.orderDate = new Date();


        // Create a separate list so that
        // future cart changes don't affect
        // this order.

        this.items = items != null
                ? new ArrayList<>(items)
                : new ArrayList<>();


        this.fullName = fullName;

        this.phone = phone;

        this.addressLine = addressLine;

        this.city = city;

        this.state = state;

        this.pincode = pincode;
    }


    // =========================
    // ORDER GETTERS
    // =========================

    public String getOrderId() {
        return orderId;
    }

    public double getBagTotal() {
        return bagTotal;
    }

    public double getDiscount() {
        return discount;
    }

    public double getTotal() {
        return total;
    }

    public String getCouponCode() {
        return couponCode;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
    this.status = status;
}

    public Date getOrderDate() {
        return orderDate;
    }


    // =========================
    // ORDER ITEMS
    // =========================

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {

        this.items = items != null
                ? new ArrayList<>(items)
                : new ArrayList<>();
    }


    // =========================
    // SHIPPING GETTERS
    // =========================

    public String getFullName() {
        return fullName;
    }

    public String getPhone() {
        return phone;
    }

    public String getAddressLine() {
        return addressLine;
    }

    public String getCity() {
        return city;
    }

    public String getState() {
        return state;
    }

    public String getPincode() {
        return pincode;
    }
}