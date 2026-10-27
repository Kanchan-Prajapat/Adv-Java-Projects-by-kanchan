
package com.pacelet.data;

import com.pacelet.model.CartItem;
import com.pacelet.model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public boolean saveOrder(Order order, int userId) throws SQLException {

        String orderSql = """
                INSERT INTO orders
                (order_id, user_id, bag_total, discount, total, coupon_code,
                 payment_method, status, order_date, full_name,
                 phone, address_line, city, state, pincode)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
                """;

        String itemSql = """
                INSERT INTO order_items
                (order_id, product_id, product_name, price,
                 size, quantity, image)
                VALUES (?, ?, ?, ?, ?, ?, ?)
                """;

        try (Connection con = DBConnection.getConnection()) {
            con.setAutoCommit(false);

            try {
                try (PreparedStatement ps = con.prepareStatement(orderSql)) {
                    ps.setString(1, order.getOrderId());
                    ps.setInt(2, userId);
                    ps.setDouble(3, order.getBagTotal());
                    ps.setDouble(4, order.getDiscount());
                    ps.setDouble(5, order.getTotal());
                    ps.setString(6, order.getCouponCode());
                    ps.setString(7, order.getPaymentMethod());
                    ps.setString(8, order.getStatus());
                    ps.setTimestamp(9, new Timestamp(order.getOrderDate().getTime()));
                    ps.setString(10, order.getFullName());
                    ps.setString(11, order.getPhone());
                    ps.setString(12, order.getAddressLine());
                    ps.setString(13, order.getCity());
                    ps.setString(14, order.getState());
                    ps.setString(15, order.getPincode());
                    ps.executeUpdate();
                }

                try (PreparedStatement ps = con.prepareStatement(itemSql)) {
                    for (CartItem item : order.getItems()) {
                        ps.setString(1, order.getOrderId());

                        // order_items.product_id is INT.
                        // Resolve the product slug to the database ID.
                        int productDbId = getProductDbId(con, item.getProductId());
                        ps.setInt(2, productDbId);

                        ps.setString(3, item.getName());
                        ps.setDouble(4, item.getPrice());
                        ps.setString(5, String.valueOf(item.getSize()));
                        ps.setInt(6, item.getQuantity());
                        ps.setString(7, item.getImage());
                        ps.addBatch();
                    }
                    ps.executeBatch();
                }

                con.commit();
                return true;

            } catch (SQLException | RuntimeException e) {
                con.rollback();
                throw e;
            } finally {
                con.setAutoCommit(true);
            }
        }
    }

    private int getProductDbId(Connection con, String productSlug)
            throws SQLException {

        String sql = "SELECT product_id FROM products WHERE slug = ?";

        try (PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, productSlug);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("product_id");
                }
            }
        }

        throw new SQLException("Product not found: " + productSlug);
    }

    public List<Order> getOrdersByUserId(int userId) throws SQLException {

        List<Order> orders = new ArrayList<>();

        String orderSql = """
                SELECT order_id, bag_total, discount, total, coupon_code,
                       payment_method, status, order_date, full_name,
                       phone, address_line, city, state, pincode
                FROM orders
                WHERE user_id = ?
                ORDER BY order_date DESC
                """;

        String itemsSql = """
                SELECT oi.product_name, oi.price, oi.size, oi.quantity,
                       oi.image, p.slug
                FROM order_items oi
                LEFT JOIN products p ON p.product_id = oi.product_id
                WHERE oi.order_id = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(orderSql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order(
                            rs.getString("order_id"),
                            rs.getDouble("bag_total"),
                            rs.getDouble("discount"),
                            rs.getDouble("total"),
                            rs.getString("coupon_code"),
                            rs.getString("payment_method"),
                            rs.getString("status")
                    );

                    Timestamp timestamp = rs.getTimestamp("order_date");
                    if (timestamp != null) {
                        order.setOrderDate(
                                new java.util.Date(timestamp.getTime())
                        );
                    }

                    order.setFullName(rs.getString("full_name"));
                    order.setPhone(rs.getString("phone"));
                    order.setAddressLine(rs.getString("address_line"));
                    order.setCity(rs.getString("city"));
                    order.setState(rs.getString("state"));
                    order.setPincode(rs.getString("pincode"));

                    List<CartItem> items = new ArrayList<>();

                    try (PreparedStatement itemPs = con.prepareStatement(itemsSql)) {
                        itemPs.setString(1, order.getOrderId());

                        try (ResultSet itemRs = itemPs.executeQuery()) {
                            while (itemRs.next()) {
                                String productSlug = itemRs.getString("slug");
                                if (productSlug == null) {
                                    productSlug = String.valueOf(
                                            itemRs.getString("product_name")
                                    );
                                }

                                String sizeText = itemRs.getString("size");
                                int size;
                                try {
                                    size = Integer.parseInt(sizeText);
                                } catch (NumberFormatException e) {
                                    size = 0;
                                }

                                items.add(new CartItem(
                                        productSlug,
                                        itemRs.getString("product_name"),
                                        "",
                                        itemRs.getDouble("price"),
                                        itemRs.getString("image"),
                                        null,
                                        size,
                                        itemRs.getInt("quantity")
                                ));
                            }
                        }
                    }

                    order.setItems(items);
                    orders.add(order);
                }
            }
        }

        return orders;
    }
}
