
package com.pacelet.data;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.pacelet.model.Product;
import com.pacelet.model.CartItem;

public class WishlistDAO {

    public List<Product> getWishlist(int userId) throws SQLException {
        List<Product> wishlist = new ArrayList<>();

        String sql = """
                SELECT p.slug
                FROM wishlist_items w
                JOIN products p ON w.product_id = p.product_id
                WHERE w.user_id = ?
                ORDER BY w.created_at DESC
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String slug = rs.getString("slug");
                    Product product = ProductData.getProductById(slug);

                    if (product != null) {
                        wishlist.add(product);
                    }
                }
            }
        }

        return wishlist;
    }

    public boolean addToWishlist(int userId, String productSlug)
            throws SQLException {

        String sql = """
                INSERT INTO wishlist_items (user_id, product_id)
                SELECT ?, product_id
                FROM products
                WHERE slug = ?
                ON DUPLICATE KEY UPDATE
                    created_at = wishlist_items.created_at
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, productSlug);

            return ps.executeUpdate() > 0;
        }
    }

    public boolean removeFromWishlist(int userId, String productSlug)
            throws SQLException {

        String sql = """
                DELETE w
                FROM wishlist_items w
                JOIN products p ON w.product_id = p.product_id
                WHERE w.user_id = ? AND p.slug = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, productSlug);

            return ps.executeUpdate() > 0;
        }
    }

    public boolean isInWishlist(int userId, String productSlug)
            throws SQLException {

        String sql = """
                SELECT 1
                FROM wishlist_items w
                JOIN products p ON w.product_id = p.product_id
                WHERE w.user_id = ? AND p.slug = ?
                LIMIT 1
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, productSlug);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }
}
