package com.pacelet.model;

public class CartItem {

    private String productId;
    private String name;
    private String subtitle;
    private double price;
    private String image;
    private String badge;
    private int size;
    private int quantity;


    public CartItem(
            String productId,
            String name,
            String subtitle,
            double price,
            String image,
            String badge,
            int size,
            int quantity
    ) {

        this.productId = productId;
        this.name = name;
        this.subtitle = subtitle;
        this.price = price;
        this.image = image;
        this.badge = badge;
        this.size = size;
        this.quantity = quantity;
    }


    public String getProductId() {
        return productId;
    }

    public String getName() {
        return name;
    }

    public String getSubtitle() {
        return subtitle;
    }

    public double getPrice() {
        return price;
    }

    public String getImage() {
        return image;
    }

    public String getBadge() {
        return badge;
    }

    public int getSize() {
        return size;
    }

    public int getQuantity() {
        return quantity;
    }


    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}