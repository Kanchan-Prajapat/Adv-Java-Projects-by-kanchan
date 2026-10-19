package com.pacelet.model;

import java.util.List;

public class Product {

    private String id;
    private String name;
    private String subtitle;

    private double price;
    private double originalPrice;

    private String badge;

    private List<String> images;
    private List<String> colorways;
    private List<Integer> sizes;

    private double rating;
    private int reviewsCount;

    private String discountBadge;
    private String description;
    private String category;

    // Specifications
    private String cushioning;
    private String drop;
    private String materials;
    private String dispatch;


    // Constructor
    public Product(
            String id,
            String name,
            String subtitle,
            double price,
            double originalPrice,
            String badge,
            List<String> images,
            List<String> colorways,
            List<Integer> sizes,
            double rating,
            int reviewsCount,
            String discountBadge,
            String description,
            String category,
            String cushioning,
            String drop,
            String materials,
            String dispatch
    ) {
        this.id = id;
        this.name = name;
        this.subtitle = subtitle;
        this.price = price;
        this.originalPrice = originalPrice;
        this.badge = badge;
        this.images = images;
        this.colorways = colorways;
        this.sizes = sizes;
        this.rating = rating;
        this.reviewsCount = reviewsCount;
        this.discountBadge = discountBadge;
        this.description = description;
        this.category = category;
        this.cushioning = cushioning;
        this.drop = drop;
        this.materials = materials;
        this.dispatch = dispatch;
    }


    // Getters

    public String getId() {
        return id;
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

    public double getOriginalPrice() {
        return originalPrice;
    }

    public String getBadge() {
        return badge;
    }

    public List<String> getImages() {
        return images;
    }

    public List<String> getColorways() {
        return colorways;
    }

    public List<Integer> getSizes() {
        return sizes;
    }

    public double getRating() {
        return rating;
    }

    public int getReviewsCount() {
        return reviewsCount;
    }

    public String getDiscountBadge() {
        return discountBadge;
    }

    public String getDescription() {
        return description;
    }

    public String getCategory() {
        return category;
    }

    public String getCushioning() {
        return cushioning;
    }

    public String getDrop() {
        return drop;
    }

    public String getMaterials() {
        return materials;
    }

    public String getDispatch() {
        return dispatch;
    }


    // Setters

    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public void setOriginalPrice(double originalPrice) {
        this.originalPrice = originalPrice;
    }

    public void setBadge(String badge) {
        this.badge = badge;
    }

    public void setImages(List<String> images) {
        this.images = images;
    }

    public void setColorways(List<String> colorways) {
        this.colorways = colorways;
    }

    public void setSizes(List<Integer> sizes) {
        this.sizes = sizes;
    }

    public void setRating(double rating) {
        this.rating = rating;
    }

    public void setReviewsCount(int reviewsCount) {
        this.reviewsCount = reviewsCount;
    }

    public void setDiscountBadge(String discountBadge) {
        this.discountBadge = discountBadge;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public void setCushioning(String cushioning) {
        this.cushioning = cushioning;
    }

    public void setDrop(String drop) {
        this.drop = drop;
    }

    public void setMaterials(String materials) {
        this.materials = materials;
    }

    public void setDispatch(String dispatch) {
        this.dispatch = dispatch;
    }
}