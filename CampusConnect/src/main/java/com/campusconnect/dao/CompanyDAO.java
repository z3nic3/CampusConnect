package com.campusconnect.dao;

import java.sql.*;

import com.campusconnect.model.Company;
import com.campusconnect.util.DBConnection;

public class CompanyDAO {

    // =========================================================
    // CREATE COMPANY PROFILE
    // =========================================================

    public boolean createCompanyProfile(Company company) {

        String sql = "INSERT INTO company " +
                     "(user_id, company_name, industry, description, location, " +
                     "website, company_email, contact_number, logo_path, " +
                     "founded_year, company_size, linkedin_url) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, company.getUserId());
            ps.setString(2, company.getCompanyName());
            ps.setString(3, company.getIndustry());
            ps.setString(4, company.getDescription());
            ps.setString(5, company.getLocation());
            ps.setString(6, company.getWebsite());
            ps.setString(7, company.getCompanyEmail());
            ps.setString(8, company.getContactNumber());
            ps.setString(9, company.getLogoPath());

            if (company.getFoundedYear() != null) {
                ps.setInt(10, company.getFoundedYear());
            } else {
                ps.setNull(10, Types.INTEGER);
            }

            ps.setString(11, company.getCompanySize());
            ps.setString(12, company.getLinkedinUrl());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // =========================================================
    // GET COMPANY BY USER ID
    // =========================================================

    public Company getCompanyByUserId(int userId) {

        String sql = "SELECT * FROM company WHERE user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapCompany(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // GET COMPANY BY COMPANY ID
    // =========================================================

    public Company getCompanyById(int companyId) {

        String sql = "SELECT * FROM company WHERE company_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, companyId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return mapCompany(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }


    // =========================================================
    // UPDATE COMPANY PROFILE
    // =========================================================

    public boolean updateCompanyProfile(Company company) {

        String sql = "UPDATE company SET " +
                     "company_name = ?, " +
                     "industry = ?, " +
                     "description = ?, " +
                     "location = ?, " +
                     "website = ?, " +
                     "company_email = ?, " +
                     "contact_number = ?, " +
                     "logo_path = ?, " +
                     "founded_year = ?, " +
                     "company_size = ?, " +
                     "linkedin_url = ? " +
                     "WHERE company_id = ? AND user_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, company.getCompanyName());
            ps.setString(2, company.getIndustry());
            ps.setString(3, company.getDescription());
            ps.setString(4, company.getLocation());
            ps.setString(5, company.getWebsite());
            ps.setString(6, company.getCompanyEmail());
            ps.setString(7, company.getContactNumber());
            ps.setString(8, company.getLogoPath());

            if (company.getFoundedYear() != null) {
                ps.setInt(9, company.getFoundedYear());
            } else {
                ps.setNull(9, Types.INTEGER);
            }

            ps.setString(10, company.getCompanySize());
            ps.setString(11, company.getLinkedinUrl());

            ps.setInt(12, company.getCompanyId());
            ps.setInt(13, company.getUserId());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
 // =========================================================
 // GET ALL COMPANIES FOR ADMIN
 // =========================================================

 public java.util.List<Company> getAllCompanies() {

     java.util.List<Company> companies = new java.util.ArrayList<>();

     String sql = "SELECT * FROM company ORDER BY company_id DESC";

     try (Connection conn = DBConnection.getConnection();
          PreparedStatement ps = conn.prepareStatement(sql);
          ResultSet rs = ps.executeQuery()) {

         while (rs.next()) {
             companies.add(mapCompany(rs));
         }

     } catch (SQLException e) {
         e.printStackTrace();
     }

     return companies;
 }


    // =========================================================
    // MAP DATABASE ROW TO COMPANY OBJECT
    // =========================================================

    private Company mapCompany(ResultSet rs) throws SQLException {

        Company company = new Company();

        company.setCompanyId(rs.getInt("company_id"));
        company.setUserId(rs.getInt("user_id"));

        company.setCompanyName(rs.getString("company_name"));
        company.setIndustry(rs.getString("industry"));
        company.setDescription(rs.getString("description"));
        company.setLocation(rs.getString("location"));
        company.setWebsite(rs.getString("website"));
        company.setCompanyEmail(rs.getString("company_email"));
        company.setContactNumber(rs.getString("contact_number"));
        company.setLogoPath(rs.getString("logo_path"));

        int year = rs.getInt("founded_year");

        if (rs.wasNull()) {
            company.setFoundedYear(null);
        } else {
            company.setFoundedYear(year);
        }

        company.setCompanySize(rs.getString("company_size"));
        company.setLinkedinUrl(rs.getString("linkedin_url"));

        return company;
    }
}