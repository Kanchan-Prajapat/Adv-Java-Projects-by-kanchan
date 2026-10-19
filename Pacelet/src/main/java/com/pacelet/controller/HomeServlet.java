package com.pacelet.controller;

import com.pacelet.data.ProductData;
import com.pacelet.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        List<Product> products = ProductData.getAllProducts();

        Product aeroStride =
                ProductData.getProductById("aerostride-01");

        Product phantomFlow =
                ProductData.getProductById("phantom-flow");

        Product cloudformLuxe =
                ProductData.getProductById("cloudform-luxe");

        request.setAttribute("products", products);
        request.setAttribute("aeroStride", aeroStride);
        request.setAttribute("phantomFlow", phantomFlow);
        request.setAttribute("cloudformLuxe", cloudformLuxe);

        request.getRequestDispatcher(
                "/WEB-INF/views/customer/home.jsp"
        ).forward(request, response);
    }
}