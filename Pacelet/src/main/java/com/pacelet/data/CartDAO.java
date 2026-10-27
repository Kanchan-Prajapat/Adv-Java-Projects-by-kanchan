
package com.pacelet.data;

import com.pacelet.model.CartItem;
import com.pacelet.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public List<CartItem> getCartItems(int userId) throws SQLException {

        List<CartItem> cart = new ArrayList<>();

        String sql = """
                SELECT p.slug, p.name, p.subtitle, p.price, p.image,
                       ci.size, ci.quantity
                FROM cart_items ci
                JOIN products p ON p.product_id = ci.product_id
                WHERE ci.user_id = ?
                ORDER BY ci.cart_item_id
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    String slug = rs.getString("slug");
                    Product template = ProductData.getProductById(slug);

                    cart.add(new CartItem(
                            slug,
                            rs.getString("name"),
                            rs.getString("subtitle"),
                            rs.getDouble("price"),
                            rs.getString("image"),
                            template != null ? template.getBadge() : null,
                            rs.getInt("size"),
                            rs.getInt("quantity")
                    ));
                }
            }
        }

        return cart;
    }

    public void addOrUpdateItem(
            int userId,
            String productSlug,
            int size,
            int quantity
    ) throws SQLException {

        if (quantity < 1) {
            throw new SQLException("Quantity must be at least 1.");
        }

        String findProductSql =
                "SELECT product_id, stock FROM products WHERE slug = ?";

        String findCartSql = """
                SELECT quantity FROM cart_items
                WHERE user_id = ? AND product_id = ? AND size = ?
                """;

        String insertSql = """
                INSERT INTO cart_items (user_id, product_id, size, quantity)
                VALUES (?, ?, ?, ?)
                """;

        String updateSql = """
                UPDATE cart_items SET quantity = ?
                WHERE user_id = ? AND product_id = ? AND size = ?
                """;

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try {
                int productDbId;
                int stock;

                try (PreparedStatement ps =
                             con.prepareStatement(findProductSql)) {
                    ps.setString(1, productSlug);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (!rs.next()) {
                            throw new SQLException("Product not found.");
                        }

                        productDbId = rs.getInt("product_id");
                        stock = rs.getInt("stock");
                    }
                }

                int existingQuantity = 0;

                try (PreparedStatement ps =
                             con.prepareStatement(findCartSql)) {
                    ps.setInt(1, userId);
                    ps.setInt(2, productDbId);
                    ps.setInt(3, size);

                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            existingQuantity = rs.getInt("quantity");
                        }
                    }
                }

                int newQuantity = existingQuantity + quantity;

                if (newQuantity > stock) {
                    throw new SQLException(
                            "Only " + stock + " item(s) are available."
                    );
                }

                if (existingQuantity > 0) {
                    try (PreparedStatement ps =
                                 con.prepareStatement(updateSql)) {
                        ps.setInt(1, newQuantity);
                        ps.setInt(2, userId);
                        ps.setInt(3, productDbId);
                        ps.setInt(4, size);
                        ps.executeUpdate();
                    }
                } else {
                    try (PreparedStatement ps =
                                 con.prepareStatement(insertSql)) {
                        ps.setInt(1, userId);
                        ps.setInt(2, productDbId);
                        ps.setInt(3, size);
                        ps.setInt(4, quantity);
                        ps.executeUpdate();
                    }
                }

                con.commit();

            } catch (SQLException | RuntimeException e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }

    public void updateQuantity(
            int userId,
            String productSlug,
            int size,
            int quantity
    ) throws SQLException {

        if (quantity <= 0) {
            removeItem(userId, productSlug, size);
            return;
        }

        String sql = """
                UPDATE cart_items ci
                JOIN products p ON p.product_id = ci.product_id
                SET ci.quantity = ?
                WHERE ci.user_id = ? AND p.slug = ? AND ci.size = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, quantity);
            ps.setInt(2, userId);
            ps.setString(3, productSlug);
            ps.setInt(4, size);

            ps.executeUpdate();
        }
    }

    public void removeItem(
            int userId,
            String productSlug,
            int size
    ) throws SQLException {

        String sql = """
                DELETE ci FROM cart_items ci
                JOIN products p ON p.product_id = ci.product_id
                WHERE ci.user_id = ? AND p.slug = ? AND ci.size = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setString(2, productSlug);
            ps.setInt(3, size);

            ps.executeUpdate();
        }
    }

    
public void clearCart(int userId) throws SQLException {

    String sql = "DELETE FROM cart_items WHERE user_id = ?";

    try (Connection con = DBConnection.getConnection();
         PreparedStatement ps = con.prepareStatement(sql)) {

        ps.setInt(1, userId);
        ps.executeUpdate();
    }
}

}
