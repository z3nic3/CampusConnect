package com.campusconnect.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.campusconnect.dao.UserDAO;
import com.campusconnect.model.User;

@WebServlet("/deleteUser")
public class DeleteUserServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check if an admin is logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User loggedInUser = (User) session.getAttribute("user");

        // Only ADMIN can delete users
        if (!"ADMIN".equals(loggedInUser.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String userIdParam = request.getParameter("userId");

        if (userIdParam == null || userIdParam.trim().isEmpty()) {
            response.sendRedirect("adminDashboard.jsp");
            return;
        }

        try {
            int userId = Integer.parseInt(userIdParam);

            UserDAO userDAO = new UserDAO();

            boolean deleted = userDAO.deleteUser(userId);

            if (deleted) {
                response.sendRedirect("adminDashboard.jsp?message=deleted");
            } else {
                response.sendRedirect("adminDashboard.jsp?message=failed");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("adminDashboard.jsp?message=invalid");
        }
    }
}
