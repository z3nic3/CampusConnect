package com.campusconnect.dao;

import java.sql.*;
import com.campusconnect.model.User;
import com.campusconnect.util.DBConnection;

public class UserDAO {

    // Register a new user (student, company, or admin)
    public boolean registerUser(User user) {
        String sql = "INSERT INTO user (name, email, password, role) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());

            int rows = ps.executeUpdate();
            return rows > 0; 

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Login: check email + password, return matching User or null
    public User login(String email, String password) {
        String sql = "SELECT * FROM user WHERE email = ? AND password = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                return user;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Check if an email is already registered (used during registration)
    public boolean emailExists(String email) {
        String sql = "SELECT user_id FROM user WHERE email = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            return rs.next();

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get user by ID (useful later for profile pages)
    public User getUserById(int userId) {
        String sql = "SELECT * FROM user WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                return user;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public java.util.List<User> getAllUsers() {

        java.util.List<User> users = new java.util.ArrayList<>();

        String sql = "SELECT * FROM user ORDER BY user_id DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                User user = new User();

                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("name"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));

                users.add(user);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }
    public boolean deleteUser(int userId) {

        Connection conn = null;

        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            // -------------------------------------------------
            // 1. Get the user's role
            // -------------------------------------------------
            String role = null;

            String getRoleSQL = "SELECT role FROM user WHERE user_id = ?";

            try (PreparedStatement ps = conn.prepareStatement(getRoleSQL)) {

                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {

                    if (rs.next()) {
                        role = rs.getString("role");
                    } else {
                        conn.rollback();
                        return false;
                    }
                }
            }

            // -------------------------------------------------
            // 2. Never allow ADMIN to be deleted
            // -------------------------------------------------
            if ("ADMIN".equalsIgnoreCase(role)) {
                conn.rollback();
                return false;
            }

            // -------------------------------------------------
            // 3. If user is a STUDENT
            // -------------------------------------------------
            if ("STUDENT".equalsIgnoreCase(role)) {

                // Delete student's applications
                String deleteApplicationsSQL =
                        "DELETE FROM application WHERE student_id = ?";

                try (PreparedStatement ps =
                             conn.prepareStatement(deleteApplicationsSQL)) {

                    ps.setInt(1, userId);
                    ps.executeUpdate();
                }

                // Delete student's profile
                String deleteProfileSQL =
                        "DELETE FROM student_profile WHERE user_id = ?";

                try (PreparedStatement ps =
                             conn.prepareStatement(deleteProfileSQL)) {

                    ps.setInt(1, userId);
                    ps.executeUpdate();
                }
            }

            // -------------------------------------------------
            // 4. If user is a COMPANY
            // -------------------------------------------------
            else if ("COMPANY".equalsIgnoreCase(role)) {

                // First delete applications belonging to
                // opportunities posted by this company
                String deleteApplicationsSQL =
                        "DELETE FROM application " +
                        "WHERE opp_id IN (" +
                        "SELECT opp_id FROM opportunity " +
                        "WHERE company_id IN (" +
                        "SELECT company_id FROM company WHERE user_id = ?" +
                        ")" +
                        ")";

                try (PreparedStatement ps =
                             conn.prepareStatement(deleteApplicationsSQL)) {

                    ps.setInt(1, userId);
                    ps.executeUpdate();
                }

                // Delete company's opportunities
                String deleteOpportunitiesSQL =
                        "DELETE FROM opportunity " +
                        "WHERE company_id IN (" +
                        "SELECT company_id FROM company WHERE user_id = ?)";

                try (PreparedStatement ps =
                             conn.prepareStatement(deleteOpportunitiesSQL)) {

                    ps.setInt(1, userId);
                    ps.executeUpdate();
                }

                // Delete company profile
                String deleteCompanySQL =
                        "DELETE FROM company WHERE user_id = ?";

                try (PreparedStatement ps =
                             conn.prepareStatement(deleteCompanySQL)) {

                    ps.setInt(1, userId);
                    ps.executeUpdate();
                }
            }

            // -------------------------------------------------
            // 5. Finally delete the user
            // -------------------------------------------------
            String deleteUserSQL =
                    "DELETE FROM user WHERE user_id = ? AND role <> 'ADMIN'";

            int rowsDeleted;

            try (PreparedStatement ps =
                         conn.prepareStatement(deleteUserSQL)) {

                ps.setInt(1, userId);
                rowsDeleted = ps.executeUpdate();
            }

            // -------------------------------------------------
            // 6. Commit if successful
            // -------------------------------------------------
            if (rowsDeleted > 0) {
                conn.commit();
                return true;
            } else {
                conn.rollback();
                return false;
            }

        } catch (SQLException e) {

            // If anything fails, undo ALL changes
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (SQLException rollbackException) {
                    rollbackException.printStackTrace();
                }
            }

            e.printStackTrace();
            return false;

        } finally {

            if (conn != null) {
                try {
                    conn.setAutoCommit(true);
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }



    
}