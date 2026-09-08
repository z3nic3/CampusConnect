package com.campusconnect.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.campusconnect.model.Opportunity;
import com.campusconnect.util.DBConnection;

public class OpportunityDAO {

    // Add a new opportunity (posted by a company)
    public boolean addOpportunity(Opportunity opp) {
        String sql = "INSERT INTO opportunity (company_id, title, type, skill_required, location, description, posted_date) "
                   + "VALUES (?, ?, ?, ?, ?, ?, CURDATE())";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, opp.getCompanyId());
            ps.setString(2, opp.getTitle());
            ps.setString(3, opp.getType());
            ps.setString(4, opp.getSkillRequired());
            ps.setString(5, opp.getLocation());
            ps.setString(6, opp.getDescription());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
 // Update an existing opportunity
    public boolean updateOpportunity(Opportunity opp) {

        String sql = "UPDATE opportunity SET " +
                     "title = ?, " +
                     "type = ?, " +
                     "skill_required = ?, " +
                     "location = ?, " +
                     "description = ? " +
                     "WHERE opp_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, opp.getTitle());
            ps.setString(2, opp.getType());
            ps.setString(3, opp.getSkillRequired());
            ps.setString(4, opp.getLocation());
            ps.setString(5, opp.getDescription());
            ps.setInt(6, opp.getOppId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    // Get all opportunities posted by a specific company
    public List<Opportunity> getOpportunitiesByCompany(int companyId) {
        List<Opportunity> list = new ArrayList<>();
        String sql = "SELECT o.*, c.company_name\r\n"
        		+ "FROM opportunity o\r\n"
        		+ "JOIN company c\r\n"
        		+ "ON o.company_id = c.company_id\r\n"
        		+ "WHERE o.company_id = ?\r\n"
        		+ "ORDER BY o.posted_date DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, companyId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get all opportunities (for student browsing later)
    public List<Opportunity> getAllOpportunities() {
        List<Opportunity> list = new ArrayList<>();
        String sql =
        	    "SELECT o.*, c.company_name " +
        	    "FROM opportunity o " +
        	    "JOIN company c ON o.company_id = c.company_id " +
        	    "ORDER BY o.posted_date DESC";
        try (Connection conn = DBConnection.getConnection();
             Statement st = conn.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Helper to map a ResultSet row to an Opportunity object (avoids repeating this in every method)
    private Opportunity mapRow(ResultSet rs) throws SQLException {
        Opportunity opp = new Opportunity();
        opp.setOppId(rs.getInt("opp_id"));
        opp.setCompanyId(rs.getInt("company_id"));
        opp.setTitle(rs.getString("title"));
        opp.setType(rs.getString("type"));
        opp.setSkillRequired(rs.getString("skill_required"));
        opp.setLocation(rs.getString("location"));
        opp.setDescription(rs.getString("description"));
        opp.setPostedDate(rs.getDate("posted_date"));
        opp.setCompanyName(
        	    rs.getString("company_name")
        	);
        return opp;
    }
}
