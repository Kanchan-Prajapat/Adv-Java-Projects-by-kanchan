
package com.pacelet.data;

import com.pacelet.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductDAO {

    public Product getProductBySlug(String slug) throws SQLException {

        String sql = """
                SELECT slug, name, subtitle, price, image, category, stock
                FROM products
                WHERE slug = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, slug);

            try (ResultSet rs = ps.executeQuery()) {

                if (!rs.next()) {
                    return null;
                }

                // ProductData provides the existing product-detail template.
                Product product = ProductData.getProductById(
                        rs.getString("slug")
                );

                if (product == null) {
                    throw new SQLException(
                            "No product detail template found for slug: "
                                    + slug
                    );
                }

                return product;
            }
        }
    }

    public int getStockBySlug(String slug) throws SQLException {

        String sql = "SELECT stock FROM products WHERE slug = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, slug);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("stock");
                }
            }
        }

        return 0;
    }
}
