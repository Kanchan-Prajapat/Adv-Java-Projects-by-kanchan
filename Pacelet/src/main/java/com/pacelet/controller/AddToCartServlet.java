package com.pacelet.controller;

import com.pacelet.data.ProductData;
import com.pacelet.model.CartItem;
import com.pacelet.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart/add")
public class AddToCartServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {


        String productId =
                request.getParameter("productId");

        String sizeParam =
                request.getParameter("size");

        String quantityParam =
                request.getParameter("quantity");


        // Validate product ID

        if (productId == null || productId.isBlank()) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Product ID is required"
            );

            return;
        }


        // Validate size

        int size = 0;

        try {

            size = Integer.parseInt(sizeParam);

        } catch (Exception e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Please select a valid size"
            );

            return;
        }


        // Quantity

        int quantity = 1;

        try {

            quantity =
                    Integer.parseInt(quantityParam);

        } catch (Exception ignored) {
        }


        if (quantity < 1) {
            quantity = 1;
        }


        // Find product

        Product product = null;

        for (Product p : ProductData.getAllProducts()) {

            if (p.getId().equals(productId)) {

                product = p;
                break;
            }
        }


        if (product == null) {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Product not found"
            );

            return;
        }


        // Get session

        HttpSession session =
                request.getSession();


        // Get existing cart

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");


        if (cart == null) {

            cart =
                    new ArrayList<>();

        }


        // Check if same product + same size already exists

        boolean found = false;

        for (CartItem item : cart) {

            if (
                item.getProductId().equals(productId)
                && item.getSize() == size
            ) {

                item.setQuantity(
                        item.getQuantity() + quantity
                );

                found = true;

                break;
            }
        }


        // Add new item

        if (!found) {

            CartItem cartItem =
                    new CartItem(
                            product.getId(),
                            product.getName(),
                            product.getSubtitle(),
                            product.getPrice(),
                            product.getImages().get(0),
                            product.getBadge(),
                            size,
                            quantity
                    );

            cart.add(cartItem);
        }


        // Save cart in session

        session.setAttribute(
                "cart",
                cart
        );


        // Return to product page

        response.sendRedirect(
                request.getContextPath()
                + "/product-detail?id="
                + productId
                + "&added=true"
        );
    }
}