package com.campusconnect.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.campusconnect.dao.CompanyDAO;
import com.campusconnect.model.Company;
import com.campusconnect.model.User;

@WebServlet("/companyProfile")
public class CompanyProfileServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;


    // =========================================================
    // GET - SHOW PROFILE
    // =========================================================

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null || !"COMPANY".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        CompanyDAO companyDAO = new CompanyDAO();

        Company company =
                companyDAO.getCompanyByUserId(user.getUserId());

        request.setAttribute("company", company);

        request.getRequestDispatcher("/companyProfile.jsp")
               .forward(request, response);
    }


    // =========================================================
    // POST - SAVE / UPDATE PROFILE
    // =========================================================

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (user == null || !"COMPANY".equals(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }


        String companyName =
                request.getParameter("companyName");

        String industry =
                request.getParameter("industry");

        String description =
                request.getParameter("description");

        String location =
                request.getParameter("location");

        String website =
                request.getParameter("website");

        String companyEmail =
                request.getParameter("companyEmail");

        String contactNumber =
                request.getParameter("contactNumber");

        String companySize =
                request.getParameter("companySize");

        String linkedinUrl =
                request.getParameter("linkedinUrl");

        String foundedYearParam =
                request.getParameter("foundedYear");


        // =====================================================
        // BASIC VALIDATION
        // =====================================================

        if (companyName == null || companyName.trim().isEmpty()
                || industry == null || industry.trim().isEmpty()
                || description == null || description.trim().isEmpty()
                || location == null || location.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "Please fill all required company information."
            );

            request.setAttribute(
                    "company",
                    new Company()
            );

            request.getRequestDispatcher("/companyProfile.jsp")
                   .forward(request, response);

            return;
        }


        Integer foundedYear = null;

        if (foundedYearParam != null
                && !foundedYearParam.trim().isEmpty()) {

            try {

                foundedYear =
                        Integer.parseInt(foundedYearParam);

            } catch (NumberFormatException e) {

                request.setAttribute(
                        "error",
                        "Invalid founded year."
                );

                request.getRequestDispatcher("/companyProfile.jsp")
                       .forward(request, response);

                return;
            }
        }


        CompanyDAO companyDAO = new CompanyDAO();

        Company existingCompany =
                companyDAO.getCompanyByUserId(user.getUserId());


        Company company = new Company();

        company.setUserId(user.getUserId());
        company.setCompanyName(companyName.trim());
        company.setIndustry(industry.trim());
        company.setDescription(description.trim());
        company.setLocation(location.trim());
        company.setWebsite(website);
        company.setCompanyEmail(companyEmail);
        company.setContactNumber(contactNumber);
        company.setCompanySize(companySize);
        company.setLinkedinUrl(linkedinUrl);
        company.setFoundedYear(foundedYear);


        boolean success;


        // =====================================================
        // CREATE OR UPDATE
        // =====================================================

        if (existingCompany == null) {

            success =
                    companyDAO.createCompanyProfile(company);

        } else {

            company.setCompanyId(
                    existingCompany.getCompanyId()
            );

            company.setLogoPath(
                    existingCompany.getLogoPath()
            );

            success =
                    companyDAO.updateCompanyProfile(company);
        }


        if (success) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/companyDashboard"
            );

        } else {

            request.setAttribute(
                    "error",
                    "Unable to save company profile."
            );

            request.setAttribute(
                    "company",
                    company
            );

            request.getRequestDispatcher(
                    "/companyProfile.jsp"
            ).forward(request, response);
        }
    }
}