package com.pacelet.controller;

import com.pacelet.data.ProductData;
import com.pacelet.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

@WebServlet("/shop")
public class ShopServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        // =========================
        // GET FILTER PARAMETERS
        // =========================

        String category = request.getParameter("category");

        String sizeParam = request.getParameter("size");

        String maxPriceParam = request.getParameter("maxPrice");

        String sort = request.getParameter("sort");


        // =========================
        // DEFAULT CATEGORY
        // =========================

        if (category == null || category.isBlank()) {
            category = "Running";
        }


        // =========================
        // SIZE
        // =========================

        Integer selectedSize = null;

        if (sizeParam != null && !sizeParam.isBlank()) {

            try {

                selectedSize = Integer.parseInt(sizeParam);

            } catch (NumberFormatException ignored) {

                selectedSize = null;
            }
        }

        // Stitch default size = UK 9

        if (selectedSize == null) {
            selectedSize = 9;
        }


        // =========================
        // MAX PRICE
        // =========================

        double maxPrice = 8000;

        if (maxPriceParam != null && !maxPriceParam.isBlank()) {

            try {

                maxPrice = Double.parseDouble(maxPriceParam);

            } catch (NumberFormatException ignored) {

                maxPrice = 8000;
            }
        }


        // =========================
        // SORT
        // =========================

        if (sort == null || sort.isBlank()) {
            sort = "Recommended";
        }


        // =========================
        // FILTER PRODUCTS
        // =========================

        List<Product> filteredProducts =
                new ArrayList<>();


        for (Product product : ProductData.getAllProducts()) {


            // -------------------------
            // CATEGORY FILTER
            // -------------------------

            if (!category.equalsIgnoreCase("All")
                    && !product.getCategory()
                              .toLowerCase()
                              .contains(category.toLowerCase())) {

                continue;
            }


            // -------------------------
            // SIZE FILTER
            // -------------------------

            if (selectedSize != null
                    && !product.getSizes()
                              .contains(selectedSize)) {

                continue;
            }


            // -------------------------
            // PRICE FILTER
            // -------------------------

            if (product.getPrice() > maxPrice) {

                continue;
            }


            // Product passed all filters

            filteredProducts.add(product);
        }


        // =========================
        // SORTING
        // =========================

        switch (sort) {

            case "Price: Low to High":

                filteredProducts.sort(
                    Comparator.comparingDouble(
                        Product::getPrice
                    )
                );

                break;


            case "Price: High to Low":

                filteredProducts.sort(
                    Comparator.comparingDouble(
                        Product::getPrice
                    ).reversed()
                );

                break;


            case "Top Customer Rated":

                filteredProducts.sort(
                    Comparator.comparingDouble(
                        Product::getRating
                    ).reversed()
                );

                break;


            case "Newest":

                // For now we don't have createdAt
                // in Product.java.
                //
                // So keep ProductData order.

                break;


            case "Recommended":

            default:

                // Keep ProductData order.

                break;
        }


        // =========================
        // SEND DATA TO JSP
        // =========================

        request.setAttribute(
                "products",
                filteredProducts
        );


        request.setAttribute(
                "selectedCategory",
                category
        );


        request.setAttribute(
                "selectedSize",
                selectedSize
        );


        request.setAttribute(
                "selectedSort",
                sort
        );


        request.setAttribute(
                "maxPrice",
                maxPrice
        );


        // =========================
        // FORWARD TO SHOP JSP
        // =========================

        request.getRequestDispatcher(
                "/WEB-INF/views/customer/shop.jsp"
        ).forward(request, response);
    }
}