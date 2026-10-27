
package com.pacelet.controller;

import com.pacelet.data.CartDAO;
import com.pacelet.data.ProductDAO;
import com.pacelet.model.CartItem;
import com.pacelet.model.Product;

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

@WebServlet("/cart/add")
public class AddToCartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String productId = request.getParameter("productId");
        String sizeParam = request.getParameter("size");
        String quantityParam = request.getParameter("quantity");

        if (productId == null || productId.isBlank()) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Product ID is required."
            );
            return;
        }

        int size;
        try {
            size = Integer.parseInt(sizeParam);
            if (size <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException | NullPointerException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Please select a valid size."
            );
            return;
        }

        int quantity = 1;
        try {
            quantity = Integer.parseInt(quantityParam);
        } catch (NumberFormatException | NullPointerException ignored) {
            // Use default quantity of 1.
        }

        if (quantity < 1) {
            quantity = 1;
        }

        HttpSession session = request.getSession();

        try {
            Product product = productDAO.getProductBySlug(productId);

            if (product == null) {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found."
                );
                return;
            }

            Object userIdObject = session.getAttribute("userId");

            if (userIdObject instanceof Number) {
                int userId = ((Number) userIdObject).intValue();

                // Save the change to MySQL first.
                cartDAO.addOrUpdateItem(
                        userId, productId, size, quantity
                );

                // Refresh session cart from the database.
                session.setAttribute(
                        "cart", cartDAO.getCartItems(userId)
                );

            } else {
                // Guest users keep a session-only cart.
                @SuppressWarnings("unchecked")
                List<CartItem> cart =
                        (List<CartItem>) session.getAttribute("cart");

                if (cart == null) {
                    cart = new ArrayList<>();
                }

                boolean found = false;

                for (CartItem item : cart) {
                    if (item.getProductId().equals(productId)
                            && item.getSize() == size) {
                        item.setQuantity(item.getQuantity() + quantity);
                        found = true;
                        break;
                    }
                }

                if (!found) {
                    cart.add(new CartItem(
                            product.getId(),
                            product.getName(),
                            product.getSubtitle(),
                            product.getPrice(),
                            product.getImages().get(0),
                            product.getBadge(),
                            size,
                            quantity
                    ));
                }

                session.setAttribute("cart", cart);
            }

            response.sendRedirect(
                    request.getContextPath()
                            + "/product-detail?id="
                            + productId
                            + "&added=true"
            );

        } catch (SQLException e) {
            getServletContext().log("Unable to add product to cart.", e);
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to update your cart. Please try again."
            );
        }
    }
}
