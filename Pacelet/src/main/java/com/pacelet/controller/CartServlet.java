
package com.pacelet.controller;

import com.pacelet.data.CartDAO;
import com.pacelet.model.CartItem;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        HttpSession session = request.getSession();

        List<CartItem> cart =
                (List<CartItem>) session.getAttribute("cart");

        Object userIdObject = session.getAttribute("userId");

        // Load the saved cart from the database for logged-in users.
        if (userIdObject instanceof Number) {
            int userId = ((Number) userIdObject).intValue();

            try {
                cart = cartDAO.getCartItems(userId);
                session.setAttribute("cart", cart);
                session.removeAttribute("cartLoadError");

            } catch (SQLException e) {
                getServletContext().log(
                        "Unable to load cart from database.", e
                );

                if (cart == null) {
                    cart = new ArrayList<>();
                }

                session.setAttribute(
                        "cartLoadError",
                        "Unable to load your saved cart. Please try again."
                );
            }
        }

        if (cart == null) {
            cart = new ArrayList<>();
        }

        double bagTotal = 0;

        for (CartItem item : cart) {
            bagTotal += item.getPrice() * item.getQuantity();
        }

        Object discountObj = session.getAttribute("appliedDiscount");

        double appliedDiscount = discountObj instanceof Number
                ? ((Number) discountObj).doubleValue()
                : 0;

        appliedDiscount = Math.max(
                0,
                Math.min(appliedDiscount, bagTotal)
        );

        double totalPayable = bagTotal - appliedDiscount;

        request.setAttribute("cart", cart);
        request.setAttribute("bagTotal", bagTotal);
        request.setAttribute("appliedDiscount", appliedDiscount);
        request.setAttribute("totalPayable", totalPayable);
        request.setAttribute(
                "couponCode",
                session.getAttribute("couponCode")
        );
        request.setAttribute(
                "couponError",
                session.getAttribute("couponError")
        );

        request.getRequestDispatcher(
                "/WEB-INF/views/customer/cart.jsp"
        ).forward(request, response);
    }
}
