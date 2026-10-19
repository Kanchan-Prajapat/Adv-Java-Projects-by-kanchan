package com.pacelet.controller;

import com.pacelet.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Iterator;
import java.util.List;

@WebServlet("/cart/update")
public class UpdateCartServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String productId =
                request.getParameter("productId");

        String sizeParam =
                request.getParameter("size");

        String changeParam =
                request.getParameter("change");


        // Validate parameters

        if (productId == null
                || sizeParam == null
                || changeParam == null) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid cart request"
            );

            return;
        }


        int size;

        int change;


        try {

            size = Integer.parseInt(sizeParam);

            change = Integer.parseInt(changeParam);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid quantity update"
            );

            return;
        }


        HttpSession session =
                request.getSession();


        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");


        if (cart != null) {

            Iterator<CartItem> iterator =
                    cart.iterator();


            while (iterator.hasNext()) {

                CartItem item =
                        iterator.next();


                if (
                    item.getProductId().equals(productId)
                    && item.getSize() == size
                ) {


                    int newQuantity =
                            item.getQuantity() + change;


                    // Remove item if quantity becomes 0

                    if (newQuantity <= 0) {

                        iterator.remove();

                    } else {

                        item.setQuantity(newQuantity);
                    }


                    break;
                }
            }
        }


        // Return to cart

        response.sendRedirect(
                request.getContextPath() + "/cart"
        );
    }
}