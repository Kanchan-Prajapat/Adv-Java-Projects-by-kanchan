
package com.pacelet.dao;

import com.pacelet.data.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // =========================================
    // REGISTER USER
    // =========================================
    public boolean registerUser(
            String fullName,
            String email,
            String phone,
            String passwordHash
    ) throws SQLException {

        String sql = """
                INSERT INTO users
                (full_name, email, phone, password_hash)
                VALUES (?, ?, ?, ?)
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, passwordHash);

            return ps.executeUpdate() == 1;
        }
    }

    // =========================================
    // CHECK EMAIL
    // =========================================
    public boolean emailExists(String email) throws SQLException {

        String sql = "SELECT user_id FROM users WHERE email = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        }
    }

    // =========================================
    // FIND USER FOR LOGIN
    // =========================================
    public UserLoginData findUserByEmail(String email)
            throws SQLException {

        String sql = """
                SELECT user_id, full_name, email, password_hash
                FROM users
                WHERE email = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, email);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return new UserLoginData(
                            rs.getInt("user_id"),
                            rs.getString("full_name"),
                            rs.getString("email"),
                            rs.getString("password_hash")
                    );
                }
            }
        }

        return null;
    }

    // =========================================
    // GET PROFILE BY USER ID
    // =========================================
    public UserProfileData findProfileById(int userId)
            throws SQLException {

        String sql = """
                SELECT user_id, full_name, email, phone,
                       address_line, city, state, pincode
                FROM users
                WHERE user_id = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return new UserProfileData(
                            rs.getInt("user_id"),
                            rs.getString("full_name"),
                            rs.getString("email"),
                            rs.getString("phone"),
                            rs.getString("address_line"),
                            rs.getString("city"),
                            rs.getString("state"),
                            rs.getString("pincode")
                    );
                }
            }
        }

        return null;
    }

    // =========================================
    // UPDATE PROFILE AND ADDRESS
    // =========================================
    public boolean updateProfile(
            int userId,
            String fullName,
            String phone,
            String addressLine,
            String city,
            String state,
            String pincode
    ) throws SQLException {

        String sql = """
                UPDATE users
                SET full_name = ?,
                    phone = ?,
                    address_line = ?,
                    city = ?,
                    state = ?,
                    pincode = ?
                WHERE user_id = ?
                """;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, fullName);
            ps.setString(2, phone);
            ps.setString(3, addressLine);
            ps.setString(4, city);
            ps.setString(5, state);
            ps.setString(6, pincode);
            ps.setInt(7, userId);

            return ps.executeUpdate() == 1;
        }
    }

    // =========================================
    // LOGIN DATA
    // =========================================
    public static class UserLoginData {

        private final int userId;
        private final String fullName;
        private final String email;
        private final String passwordHash;

        public UserLoginData(
                int userId,
                String fullName,
                String email,
                String passwordHash
        ) {
            this.userId = userId;
            this.fullName = fullName;
            this.email = email;
            this.passwordHash = passwordHash;
        }

        public int getUserId() {
            return userId;
        }

        public String getFullName() {
            return fullName;
        }

        public String getEmail() {
            return email;
        }

        public String getPasswordHash() {
            return passwordHash;
        }
    }

    // =========================================
    // PROFILE DATA
    // =========================================
    public static class UserProfileData {

        private final int userId;
        private final String fullName;
        private final String email;
        private final String phone;
        private final String addressLine;
        private final String city;
        private final String state;
        private final String pincode;

        public UserProfileData(
                int userId,
                String fullName,
                String email,
                String phone,
                String addressLine,
                String city,
                String state,
                String pincode
        ) {
            this.userId = userId;
            this.fullName = fullName;
            this.email = email;
            this.phone = phone;
            this.addressLine = addressLine;
            this.city = city;
            this.state = state;
            this.pincode = pincode;
        }

        public int getUserId() {
            return userId;
        }

        public String getFullName() {
            return fullName;
        }

        public String getEmail() {
            return email;
        }

        public String getPhone() {
            return phone;
        }

        public String getAddressLine() {
            return addressLine;
        }

        public String getCity() {
            return city;
        }

        public String getState() {
            return state;
        }

        public String getPincode() {
            return pincode;
        }
    }
}
