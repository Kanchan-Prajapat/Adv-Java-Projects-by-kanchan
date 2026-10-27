
package com.pacelet.controller;

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
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private final WishlistDAO wishlistDAO = new WishlistDAO();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || !(session.getAttribute("userId") instanceof Number)) {
            response.sendRedirect(
                    request.getContextPath() + "/login");
            return;
        }

        int userId = ((Number) session.getAttribute("userId")).intValue();

        try {
            List<Product> wishlist = wishlistDAO.getWishlist(userId);
            String productId = request.getParameter("productId");

if (productId != null && !productId.isBlank()) {
    boolean inWishlist =
            wishlistDAO.isInWishlist(userId, productId);

    request.setAttribute("inWishlist", inWishlist);
}
            request.setAttribute("wishlist", wishlist);

            request.getRequestDispatcher(
                    "/WEB-INF/views/customer/wishlist.jsp")
                    .forward(request, response);

        } catch (SQLException e) {
            throw new ServletException("Unable to load wishlist.", e);
        }
    }

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String contextPath = request.getContextPath();

        if (session == null || !(session.getAttribute("userId") instanceof Number)) {
            response.sendRedirect(contextPath + "/login");
            return;
        }

        int userId = ((Number) session.getAttribute("userId")).intValue();

        String action = request.getParameter("action");
        String productId = request.getParameter("productId");

        if (action == null || productId == null || productId.isBlank()) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Missing wishlist action or product ID.");
            return;
        }

        try {
            switch (action) {
                case "add" ->
                    wishlistDAO.addToWishlist(userId, productId);

                case "remove" ->
                    wishlistDAO.removeFromWishlist(userId, productId);

                default -> {
                    response.sendError(
                            HttpServletResponse.SC_BAD_REQUEST,
                            "Invalid wishlist action.");
                    return;
                }
            }

            String referer = request.getHeader("Referer");

            if (referer != null
                    && referer.startsWith(request.getScheme() + "://"
                    + request.getServerName())) {
                response.sendRedirect(referer);
            } else {
                response.sendRedirect(contextPath + "/wishlist");
            }

        } catch (SQLException e) {
            throw new ServletException("Unable to update wishlist.", e);
        }
    }
}
