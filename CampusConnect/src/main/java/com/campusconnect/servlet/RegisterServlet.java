package com.campusconnect.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.campusconnect.dao.UserDAO;
import com.campusconnect.dao.CompanyDAO;
import com.campusconnect.model.User;
import com.campusconnect.model.Company;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        UserDAO userDAO = new UserDAO();

        // Check if email already exists
        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "Email already registered!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Create User object
        User user = new User();

        user.setName(name);
        user.setEmail(email);
        user.setPassword(password);
        user.setRole(role);

        // Register user
        boolean success = userDAO.registerUser(user);

        if (!success) {
            request.setAttribute("error", "Registration failed. Try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        /*
         * COMPANY REGISTRATION
         *
         * After the user is registered, fetch the newly created
         * user so that we get the generated user_id.
         */
        if ("COMPANY".equals(role)) {

            User newUser = userDAO.login(email, password);

            if (newUser != null) {

                Company company = new Company();

                // Link company profile to the newly created user
                company.setUserId(newUser.getUserId());

                // Use registered name as initial company name
                company.setCompanyName(name);

                /*
                 * Other company profile fields are initially empty.
                 * The user can complete them later from Company Profile.
                 */
                company.setIndustry("");
                company.setDescription("");
                company.setLocation("");
                company.setWebsite("");
                company.setCompanyEmail(email);
                company.setContactNumber("");
                company.setLogoPath("");
                company.setFoundedYear(null);
                company.setCompanySize("");
                company.setLinkedinUrl("");

                CompanyDAO companyDAO = new CompanyDAO();

                boolean companyCreated =
                        companyDAO.createCompanyProfile(company);

                if (!companyCreated) {
                    System.out.println(
                        "Warning: Company profile could not be created for user ID: "
                        + newUser.getUserId()
                    );
                }
            }
        }

        // Registration successful
        request.setAttribute(
            "message",
            "Registration successful! Please login."
        );

        request.getRequestDispatcher("login.jsp")
               .forward(request, response);
    }
}