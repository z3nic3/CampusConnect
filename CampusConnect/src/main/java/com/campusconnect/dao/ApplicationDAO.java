package com.campusconnect.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.campusconnect.model.Application;
import com.campusconnect.util.DBConnection;

public class ApplicationDAO {

    // --------------------------------------------------
    // CHECK WHETHER STUDENT ALREADY APPLIED
    // --------------------------------------------------
    public boolean alreadyApplied(int studentId, int oppId) {

        String sql =
                "SELECT app_id FROM application " +
                "WHERE student_id = ? AND opp_id = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, studentId);
            ps.setInt(2, oppId);

            ResultSet rs = ps.executeQuery();

            return rs.next();

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // --------------------------------------------------
    // APPLY FOR OPPORTUNITY
    // --------------------------------------------------
    public boolean apply(int studentId, int oppId) {

        String sql =
                "INSERT INTO application " +
                "(student_id, opp_id, status, applied_date) " +
                "VALUES (?, ?, 'PENDING', CURDATE())";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, studentId);
            ps.setInt(2, oppId);

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }


    // --------------------------------------------------
    // GET ALL APPLICATIONS OF A COMPANY
    // INCLUDING STUDENT PROFILE DETAILS
    // --------------------------------------------------
    public List<Application> getApplicationsByCompany(int userId) {

        List<Application> applications = new ArrayList<>();

        String sql =
                "SELECT a.app_id, "
              + "       a.student_id, "
              + "       a.opp_id, "
              + "       a.status, "
              + "       a.applied_date, "
              + "       u.name AS student_name, "
              + "       sp.skills, "
              + "       sp.education, "
              + "       sp.resume_path "
              + "FROM application a "
              + "JOIN opportunity o "
              + "ON a.opp_id = o.opp_id "
              + "JOIN company c "
              + "ON o.company_id = c.company_id "
              + "JOIN user u "
              + "ON a.student_id = u.user_id "
              + "LEFT JOIN student_profile sp "
              + "ON a.student_id = sp.user_id "
              + "WHERE c.user_id = ? "
              + "ORDER BY a.applied_date DESC";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, userId);

            System.out.println("SQL = " + sql);
            System.out.println("USER ID = " + userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Application application = new Application();

                // Application details
                application.setAppId(
                    rs.getInt("app_id")
                );

                application.setStudentId(
                    rs.getInt("student_id")
                );

                application.setOppId(
                    rs.getInt("opp_id")
                );

                application.setStatus(
                    rs.getString("status")
                );

                application.setAppliedDate(
                    rs.getDate("applied_date")
                );

                // Student name
                application.setStudentName(
                    rs.getString("student_name")
                );

                // Student profile
                application.setSkills(
                    rs.getString("skills")
                );

                application.setEducation(
                    rs.getString("education")
                );

                application.setResumePath(
                    rs.getString("resume_path")
                );

                applications.add(application);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return applications;
    }


    // --------------------------------------------------
    // GET APPLICATIONS OF A STUDENT
    // --------------------------------------------------
    public List<Application> getApplicationsByStudent(int studentId) {

        List<Application> applications = new ArrayList<>();

        String sql =
                "SELECT a.app_id, "
              + "       a.student_id, "
              + "       a.opp_id, "
              + "       a.status, "
              + "       a.applied_date, "
              + "       o.type, "
              + "       o.location "
              + "FROM application a "
              + "JOIN opportunity o "
              + "ON a.opp_id = o.opp_id "
              + "WHERE a.student_id = ? "
              + "ORDER BY a.applied_date DESC";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, studentId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Application app = new Application();

                app.setAppId(
                    rs.getInt("app_id")
                );

                app.setStudentId(
                    rs.getInt("student_id")
                );

                app.setOppId(
                    rs.getInt("opp_id")
                );

                app.setStatus(
                    rs.getString("status")
                );

                app.setAppliedDate(
                    rs.getDate("applied_date")
                );

                applications.add(app);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return applications;
    }


    // --------------------------------------------------
    // UPDATE APPLICATION STATUS
    // ACCEPTED / REJECTED
    // --------------------------------------------------
    public boolean updateApplicationStatus(int appId, String status) {

        String sql =
                "UPDATE application "
              + "SET status = ? "
              + "WHERE app_id = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setString(1, status);
            ps.setInt(2, appId);

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (SQLException e) {

            e.printStackTrace();
            return false;
        }
    }
    public String getResumePathForCompany(int appId, int companyUserId) {

        String sql =
                "SELECT sp.resume_path "
              + "FROM application a "
              + "JOIN opportunity o "
              + "ON a.opp_id = o.opp_id "
              + "JOIN company c "
              + "ON o.company_id = c.company_id "
              + "JOIN student_profile sp "
              + "ON a.student_id = sp.user_id "
              + "WHERE a.app_id = ? "
              + "AND c.user_id = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)
        ) {

            ps.setInt(1, appId);
            ps.setInt(2, companyUserId);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return rs.getString("resume_path");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

 // =========================================================
 // GET ALL APPLICATIONS FOR ADMIN
 // =========================================================

 public List<Application> getAllApplications() {

     List<Application> applications = new ArrayList<>();

     String sql =
             "SELECT a.app_id, "
           + "       a.student_id, "
           + "       a.opp_id, "
           + "       a.status, "
           + "       a.applied_date, "
           + "       u.name AS student_name, "
           + "       o.title AS opportunity_title, "
           + "       c.company_name "
           + "FROM application a "
           + "JOIN user u "
           + "ON a.student_id = u.user_id "
           + "JOIN opportunity o "
           + "ON a.opp_id = o.opp_id "
           + "JOIN company c "
           + "ON o.company_id = c.company_id "
           + "ORDER BY a.applied_date DESC";

     try (Connection conn = DBConnection.getConnection();
          PreparedStatement ps = conn.prepareStatement(sql);
          ResultSet rs = ps.executeQuery()) {

         while (rs.next()) {

             Application application = new Application();

             application.setAppId(rs.getInt("app_id"));
             application.setStudentId(rs.getInt("student_id"));
             application.setOppId(rs.getInt("opp_id"));
             application.setStatus(rs.getString("status"));
             application.setAppliedDate(rs.getDate("applied_date"));

             application.setStudentName(
                     rs.getString("student_name")
             );

             application.setOpportunityTitle(
                     rs.getString("opportunity_title")
             );

             application.setCompanyName(
                     rs.getString("company_name")
             );

             applications.add(application);
         }

     } catch (SQLException e) {
         e.printStackTrace();
     }

     return applications;
 }
//=========================================================
//GET APPLICATION DETAILS BY APPLICATION ID
//=========================================================
public Application getApplicationById(int appId) {

  String sql =
          "SELECT a.app_id, "
        + "       a.student_id, "
        + "       a.opp_id, "
        + "       a.status, "
        + "       a.applied_date, "
        + "       u.name AS student_name, "
        + "       sp.skills, "
        + "       sp.education, "
        + "       sp.resume_path, "
        + "       o.title AS opportunity_title, "
        + "       c.company_name "
        + "FROM application a "
        + "JOIN user u "
        + "ON a.student_id = u.user_id "
        + "JOIN opportunity o "
        + "ON a.opp_id = o.opp_id "
        + "JOIN company c "
        + "ON o.company_id = c.company_id "
        + "LEFT JOIN student_profile sp "
        + "ON a.student_id = sp.user_id "
        + "WHERE a.app_id = ?";

  try (
      Connection conn = DBConnection.getConnection();
      PreparedStatement ps = conn.prepareStatement(sql)
  ) {

      ps.setInt(1, appId);

      ResultSet rs = ps.executeQuery();

      if (rs.next()) {

          Application application = new Application();

          application.setAppId(rs.getInt("app_id"));
          application.setStudentId(rs.getInt("student_id"));
          application.setOppId(rs.getInt("opp_id"));
          application.setStatus(rs.getString("status"));
          application.setAppliedDate(rs.getDate("applied_date"));

          application.setStudentName(
                  rs.getString("student_name")
          );

          application.setSkills(
                  rs.getString("skills")
          );

          application.setEducation(
                  rs.getString("education")
          );

          application.setResumePath(
                  rs.getString("resume_path")
          );

          application.setOpportunityTitle(
                  rs.getString("opportunity_title")
          );

          application.setCompanyName(
                  rs.getString("company_name")
          );

          return application;
      }

  } catch (SQLException e) {
      e.printStackTrace();
  }

  return null;
}

}
