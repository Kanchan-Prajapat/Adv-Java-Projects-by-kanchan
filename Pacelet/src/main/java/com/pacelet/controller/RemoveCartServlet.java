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

@WebServlet("/cart/remove")
public class RemoveCartServlet extends HttpServlet {

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String productId =
                request.getParameter("productId");

        String sizeParam =
                request.getParameter("size");

        int size =
                Integer.parseInt(sizeParam);

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

                    iterator.remove();

                    break;
                }
            }
        }

        response.sendRedirect(
                request.getContextPath() + "/cart"
        );
    }
}