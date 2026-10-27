
package com.pacelet.controller;

import com.pacelet.data.CartDAO;
import com.pacelet.data.ProductDAO;
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

@WebServlet("/cart/update")
public class UpdateCartServlet extends HttpServlet {

    private final CartDAO cartDAO = new CartDAO();
    private final ProductDAO productDAO = new ProductDAO();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response
    ) throws ServletException, IOException {

        String productId = request.getParameter("productId");
        String sizeParam = request.getParameter("size");
        String changeParam = request.getParameter("change");

        if (productId == null || productId.isBlank()
                || sizeParam == null || changeParam == null) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid cart request."
            );
            return;
        }

        int size;
        int change;

        try {
            size = Integer.parseInt(sizeParam);
            change = Integer.parseInt(changeParam);

            if (size <= 0 || (change != 1 && change != -1)) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid size or quantity change."
            );
            return;
        }

        HttpSession session = request.getSession();
        Object userIdObject = session.getAttribute("userId");

        try {
            if (userIdObject instanceof Number) {
                int userId = ((Number) userIdObject).intValue();

                List<CartItem> cart = cartDAO.getCartItems(userId);

                CartItem matchingItem = null;

                for (CartItem item : cart) {
                    if (item.getProductId().equals(productId)
                            && item.getSize() == size) {
                        matchingItem = item;
                        break;
                    }
                }

                if (matchingItem != null) {
                    int newQuantity = matchingItem.getQuantity() + change;

                    if (newQuantity <= 0) {
                        cartDAO.removeItem(userId, productId, size);
                    } else {
                        int stock = productDAO.getStockBySlug(productId);

                        if (newQuantity > stock) {
                            session.setAttribute(
                                    "cartError",
                                    "Only " + stock + " item(s) are available."
                            );
                        } else {
                            cartDAO.updateQuantity(
                                    userId, productId, size, newQuantity
                            );
                            session.removeAttribute("cartError");
                        }
                    }
                }

                session.setAttribute("cart", cartDAO.getCartItems(userId));

            } else {
                // Guest cart stays in the session.
                @SuppressWarnings("unchecked")
                List<CartItem> cart =
                        (List<CartItem>) session.getAttribute("cart");

                if (cart == null) {
                    cart = new ArrayList<>();
                }

                for (int i = 0; i < cart.size(); i++) {
                    CartItem item = cart.get(i);

                    if (item.getProductId().equals(productId)
                            && item.getSize() == size) {

                        int newQuantity = item.getQuantity() + change;

                        if (newQuantity <= 0) {
                            cart.remove(i);
                        } else {
                            item.setQuantity(newQuantity);
                        }

                        break;
                    }
                }

                session.setAttribute("cart", cart);
            }

            response.sendRedirect(request.getContextPath() + "/cart");

        } catch (SQLException e) {
            getServletContext().log("Unable to update cart.", e);
            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to update your cart. Please try again."
            );
        }
    }
}
