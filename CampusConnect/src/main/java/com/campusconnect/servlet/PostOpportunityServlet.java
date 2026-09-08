package com.campusconnect.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.campusconnect.dao.CompanyDAO;
import com.campusconnect.dao.OpportunityDAO;
import com.campusconnect.model.Company;
import com.campusconnect.model.Opportunity;
import com.campusconnect.model.User;

@WebServlet("/postOpportunity")
public class PostOpportunityServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        // =====================================================
        // 1. SECURITY CHECK
        // =====================================================

        if (user == null || !"COMPANY".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // =====================================================
        // 2. GET COMPANY PROFILE FROM DATABASE
        // =====================================================

        CompanyDAO companyDAO = new CompanyDAO();

        Company company =
                companyDAO.getCompanyByUserId(user.getUserId());

        // No company profile exists
        if (company == null) {

            session.setAttribute(
                "profileMessage",
                "Please complete your profile to publish an opportunity."
            );

            response.sendRedirect(
                request.getContextPath() + "/companyProfile"
            );

            return;
        }

        if (company.getCompanyName() == null
                || company.getCompanyName().trim().isEmpty()
                || company.getIndustry() == null
                || company.getIndustry().trim().isEmpty()
                || company.getDescription() == null
                || company.getDescription().trim().isEmpty()
                || company.getLocation() == null
                || company.getLocation().trim().isEmpty()
                || company.getCompanyEmail() == null
                || company.getCompanyEmail().trim().isEmpty()
                || company.getContactNumber() == null
                || company.getContactNumber().trim().isEmpty()
                || company.getCompanySize() == null
                || company.getCompanySize().trim().isEmpty()) {

            session.setAttribute(
                "profileMessage",
                "Please complete your profile to publish an opportunity."
            );

            response.sendRedirect(
                request.getContextPath() + "/companyProfile"
            );

            return;
        }

        // =====================================================
        // 3. CHECK WHETHER COMPANY PROFILE IS COMPLETE
        // =====================================================

        boolean profileComplete = true;

        // Company name
        if (company.getCompanyName() == null ||
            company.getCompanyName().trim().isEmpty()) {

            profileComplete = false;
        }

        // Industry
        if (company.getIndustry() == null ||
            company.getIndustry().trim().isEmpty()) {

            profileComplete = false;
        }

        // Description
        if (company.getDescription() == null ||
            company.getDescription().trim().isEmpty()) {

            profileComplete = false;
        }

        // Location
        if (company.getLocation() == null ||
            company.getLocation().trim().isEmpty()) {

            profileComplete = false;
        }

        // Company email
        if (company.getCompanyEmail() == null ||
            company.getCompanyEmail().trim().isEmpty()) {

            profileComplete = false;
        }

        // Contact number
        if (company.getContactNumber() == null ||
            company.getContactNumber().trim().isEmpty()) {

            profileComplete = false;
        }

        // Company size
        if (company.getCompanySize() == null ||
            company.getCompanySize().trim().isEmpty()) {

            profileComplete = false;
        }

        // =====================================================
        // 4. BLOCK POSTING IF PROFILE IS INCOMPLETE
        // =====================================================

        if (!profileComplete) {

            response.sendRedirect(
                request.getContextPath() + "/companyProfile"
            );

            return;
        }

        // =====================================================
        // 5. GET OPPORTUNITY FORM DATA
        // =====================================================

        String title = request.getParameter("title");
        String type = request.getParameter("type");
        String skillRequired = request.getParameter("skillRequired");
        String location = request.getParameter("location");
        String description = request.getParameter("description");

        // =====================================================
        // 6. CREATE OPPORTUNITY
        // =====================================================

        Opportunity opp = new Opportunity();

        opp.setCompanyId(company.getCompanyId());
        opp.setTitle(title);
        opp.setType(type);
        opp.setSkillRequired(skillRequired);
        opp.setLocation(location);
        opp.setDescription(description);

        OpportunityDAO oppDAO = new OpportunityDAO();

        boolean success = oppDAO.addOpportunity(opp);

        // =====================================================
        // 7. RESULT
        // =====================================================

        if (success) {

        	session.setAttribute(
        		    "profileMessage",
        		    "Please complete your profile to publish an opportunity."
        		);

        		response.sendRedirect(
        		    request.getContextPath() + "/companyProfile"
        		);

        		return;

        } else {

            request.setAttribute(
                "error",
                "Failed to post opportunity."
            );

            request.getRequestDispatcher(
                "/postJob.jsp"
            ).forward(request, response);
        }
    }
}