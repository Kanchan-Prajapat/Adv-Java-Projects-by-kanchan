
package com.pacelet.data;

import com.pacelet.model.CartItem;
import com.pacelet.model.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;

public class OrderDAO {

    public boolean saveOrder(Order order) throws SQLException {

        String orderSql = """
                INSERT INTO orders
                (order_id, bag_total, discount, total, coupon_code,
                 payment_method, status, order_date, full_name,
                 phone, address_line, city, state, pincode)
                VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
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
                // Save order summary
                try (PreparedStatement ps =
                             con.prepareStatement(orderSql)) {

                    ps.setString(1, order.getOrderId());
                    ps.setDouble(2, order.getBagTotal());
                    ps.setDouble(3, order.getDiscount());
                    ps.setDouble(4, order.getTotal());
                    ps.setString(5, order.getCouponCode());
                    ps.setString(6, order.getPaymentMethod());
                    ps.setString(7, order.getStatus());

                    ps.setTimestamp(
                            8,
                            new Timestamp(order.getOrderDate().getTime())
                    );

                    ps.setString(9, order.getFullName());
                    ps.setString(10, order.getPhone());
                    ps.setString(11, order.getAddressLine());
                    ps.setString(12, order.getCity());
                    ps.setString(13, order.getState());
                    ps.setString(14, order.getPincode());

                    ps.executeUpdate();
                }

                // Save individual order items
                try (PreparedStatement ps =
                             con.prepareStatement(itemSql)) {

                    for (CartItem item : order.getItems()) {

                        ps.setString(1, order.getOrderId());

                        // Your screenshot shows product_id is INT.
                        ps.setInt(
                                2,
                                Integer.parseInt(item.getProductId())
                        );

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
}
