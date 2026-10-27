
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
import java.util.Iterator;
import java.util.List;

@WebServlet("/cart/remove")
public class RemoveCartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String productId = request.getParameter("productId");
        String sizeParam = request.getParameter("size");

        if (productId == null || productId.isBlank()
                || sizeParam == null) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid cart request."
            );
            return;
        }

        int size;

        try {
            size = Integer.parseInt(sizeParam);

            if (size <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product size."
            );
            return;
        }

        HttpSession session = request.getSession();
        Object userIdObject = session.getAttribute("userId");

        try {
            if (userIdObject instanceof Number) {
                // Logged-in user: remove from the database.
                int userId = ((Number) userIdObject).intValue();

                cartDAO.removeItem(userId, productId, size);

                // Refresh the session cart from MySQL.
                session.setAttribute(
                        "cart",
                        cartDAO.getCartItems(userId)
                );

            } else {
                // Guest user: remove from the session cart.
                @SuppressWarnings("unchecked")
                List<CartItem> cart =
                        (List<CartItem>) session.getAttribute("cart");

                if (cart == null) {
                    cart = new ArrayList<>();
                }

                Iterator<CartItem> iterator = cart.iterator();

                while (iterator.hasNext()) {
                    CartItem item = iterator.next();

                    if (item.getProductId().equals(productId)
                            && item.getSize() == size) {
                        iterator.remove();
                        break;
                    }
                }

                session.setAttribute("cart", cart);
            }

            response.sendRedirect(
                    request.getContextPath() + "/cart"
            );

        } catch (SQLException e) {
            getServletContext().log(
                    "Unable to remove item from cart.", e
            );

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to remove this item. Please try again."
            );
        }
    }
}
