package com.pacelet.data;

import com.pacelet.model.Product;

import java.util.Arrays;
import java.util.List;

public class ProductData {

    public static final List<Product> PRODUCTS = Arrays.asList(

        // 1. AeroStride 01
        new Product(
            "aerostride-01",
            "AeroStride 01",
            "Engineered Daily Trainer",
            4999,
            6499,
            "NEW",
            Arrays.asList(
                "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
                "https://images.unsplash.com/photo-1549298916-b41d501d3772"
            ),
            Arrays.asList(
                "Core Black",
                "Cloud White"
            ),
            Arrays.asList(6, 7, 8, 9, 10, 11),
            4.8,
            124,
            "23% OFF",
            "A lightweight everyday trainer engineered for comfort, movement and effortless daily wear.",
            "Running",
            "Responsive Foam",
            "8mm",
            "Engineered Mesh + Rubber",
            "Ships within 24 hours"
        ),

        // 2. Cloudform Minimal
        new Product(
            "cloudform-minimal",
            "Cloudform Minimal",
            "Minimal Everyday Sneaker",
            6299,
            7999,
            "BESTSELLER",
            Arrays.asList(
    "https://images.unsplash.com/photo-1542291026-7eec264c27ff"

            ),
            Arrays.asList(
                "Cloud White",
                "Stone Grey"
            ),
            Arrays.asList(6, 7, 8, 9, 10, 11),
            4.7,
            98,
            "21% OFF",
            "A clean minimal sneaker designed for everyday movement and understated style.",
            "Lifestyle",
            "Cloud Foam",
            "6mm",
            "Premium Mesh + EVA",
            "Ships within 24 hours"
        ),

        // 3. Phantom Flow
        new Product(
            "phantom-flow",
            "Phantom Flow",
            "Performance Running Shoe",
            5799,
            7499,
            "NEW",
            Arrays.asList(
                "https://images.unsplash.com/photo-1552346154-21d32810aba3",
                "https://images.unsplash.com/photo-1600185365483-26d7a4cc7519"
            ),
            Arrays.asList(
                "Phantom Black",
                "Graphite"
            ),
            Arrays.asList(6, 7, 8, 9, 10, 11),
            4.9,
            156,
            "23% OFF",
            "Built for smooth transitions, responsive movement and high-energy daily training.",
            "Performance Training",
            "Energy Return Foam",
            "8mm",
            "Engineered Knit + Rubber",
            "Ships within 24 hours"
        ),

        // 4. Cloudform Luxe
        new Product(
            "cloudform-luxe",
            "Cloudform Luxe",
            "Premium Lifestyle Sneaker",
            6999,
            8999,
            "BESTSELLER",
            Arrays.asList(
                "https://images.unsplash.com/photo-1542291026-7eec264c27ff",
                "https://images.unsplash.com/photo-1556637640-2c80d3201be8"
            ),
            Arrays.asList(
                "Luxe White",
                "Midnight"
            ),
            Arrays.asList(6, 7, 8, 9, 10, 11),
            4.8,
            203,
            "22% OFF",
            "Premium comfort meets architectural design in this elevated everyday sneaker.",
            "Lifestyle",
            "Cloud Cushioning",
            "6mm",
            "Premium Knit + EVA",
            "Ships within 24 hours"
        ),

        // 5. Phantom Stealth Trainer
        new Product(
            "phantom-stealth-trainer",
            "Phantom Stealth Trainer",
            "Training & Performance",
            6199,
            7999,
            "LIMITED",
            Arrays.asList(
                "https://images.unsplash.com/photo-1600185365483-26d7a4cc7519",
                "https://images.unsplash.com/photo-1552346154-21d32810aba3"
            ),
            Arrays.asList(
                "Stealth Black",
                "Carbon"
            ),
            Arrays.asList(6, 7, 8, 9, 10, 11),
            4.7,
            87,
            "22% OFF",
            "A versatile training sneaker designed for stability, movement and everyday performance.",
            "Performance Training",
            "Responsive Cushioning",
            "7mm",
            "Engineered Mesh + Rubber",
            "Ships within 24 hours"
        )
    );


    /**
     * Get all products
     */
    public static List<Product> getAllProducts() {
        return PRODUCTS;
    }


    /**
     * Find product by ID
     */
    public static Product getProductById(String id) {

        for (Product product : PRODUCTS) {

            if (product.getId().equals(id)) {
                return product;
            }
        }

        return null;
    }
}