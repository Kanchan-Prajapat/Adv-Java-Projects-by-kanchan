package com.pacelet.controller;

import com.pacelet.data.ProductData;
import com.pacelet.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String productId = request.getParameter("id");

        Product product = null;

        if (productId != null && !productId.isBlank()) {

            for (Product p : ProductData.getAllProducts()) {

                if (p.getId().equals(productId)) {
                    product = p;
                    break;
                }
            }
        }


        // If no product was found
        if (product == null) {

            response.sendError(
                HttpServletResponse.SC_NOT_FOUND,
                "Product not found"
            );

            return;
        }


        // Send product to JSP
        request.setAttribute(
            "product",
            product
        );


        // Open product detail page
        request.getRequestDispatcher(
            "/WEB-INF/views/customer/product-detail.jsp"
        ).forward(request, response);
    }
}