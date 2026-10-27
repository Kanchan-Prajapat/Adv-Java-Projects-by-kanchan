
package com.pacelet.controller;

import com.pacelet.data.ProductData;
import com.pacelet.data.WishlistDAO;
import com.pacelet.model.Product;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/product-detail")
public class ProductDetailServlet extends HttpServlet {

    private final WishlistDAO wishlistDAO = new WishlistDAO();

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

        if (product == null) {
            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Product not found"
            );
            return;
        }

        request.setAttribute("product", product);

        // Default: product is not saved
        boolean inWishlist = false;

        HttpSession session = request.getSession(false);

        if (session != null
                && session.getAttribute("userId") instanceof Number) {

            int userId =
                    ((Number) session.getAttribute("userId")).intValue();

            try {
                inWishlist =
                        wishlistDAO.isInWishlist(userId, product.getId());

            } catch (SQLException e) {
                throw new ServletException(
                        "Unable to check wishlist status.", e);
            }
        }

        request.setAttribute("inWishlist", inWishlist);

        request.getRequestDispatcher(
                "/WEB-INF/views/customer/product-detail.jsp"
        ).forward(request, response);
    }
}
