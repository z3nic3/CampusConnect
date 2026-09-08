package com.campusconnect.servlet;

import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.campusconnect.dao.ApplicationDAO;
import com.campusconnect.model.User;

@WebServlet("/viewResume")
public class ViewResumeServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        // ==========================================
        // CHECK SESSION
        // ==========================================

        HttpSession session = request.getSession(false);

        if (session == null) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        // ==========================================
        // CHECK COMPANY LOGIN
        // ==========================================

        User user = (User) session.getAttribute("user");

        if (user == null || !"COMPANY".equals(user.getRole())) {
            response.sendRedirect(
                request.getContextPath() + "/login.jsp"
            );
            return;
        }

        // ==========================================
        // GET APPLICATION ID
        // ==========================================

        String appIdParam =
                request.getParameter("appId");

        if (appIdParam == null ||
            appIdParam.trim().isEmpty()) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Application ID is missing."
            );

            return;
        }

        int appId;

        try {

            appId = Integer.parseInt(appIdParam);

        } catch (NumberFormatException e) {

            response.sendError(
                HttpServletResponse.SC_BAD_REQUEST,
                "Invalid application ID."
            );

            return;
        }

        // ==========================================
        // GET RESUME PATH
        // ==========================================

        ApplicationDAO applicationDAO =
                new ApplicationDAO();

        String resumePath =
                applicationDAO.getResumePathForCompany(
                    appId,
                    user.getUserId()
                );

        if (resumePath == null ||
            resumePath.trim().isEmpty()) {

            response.sendError(
                HttpServletResponse.SC_NOT_FOUND,
                "Resume not found."
            );

            return;
        }

        // ==========================================
        // GET REAL FILE PATH
        // ==========================================

        String realPath =
                getServletContext().getRealPath(
                    "/" + resumePath
                );

        if (realPath == null) {

            response.sendError(
                HttpServletResponse.SC_NOT_FOUND,
                "Resume file could not be located."
            );

            return;
        }

        File resumeFile =
                new File(realPath);

        // ==========================================
        // SECURITY CHECK
        // ==========================================

        String uploadDirectory =
                getServletContext().getRealPath(
                    "/uploads/resumes"
                );

        if (uploadDirectory == null) {

            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Resume directory not found."
            );

            return;
        }

        File uploadDir =
                new File(uploadDirectory);

        String canonicalResumePath =
                resumeFile.getCanonicalPath();

        String canonicalUploadPath =
                uploadDir.getCanonicalPath();

        if (!canonicalResumePath.startsWith(
                canonicalUploadPath + File.separator)) {

            response.sendError(
                HttpServletResponse.SC_FORBIDDEN,
                "Access denied."
            );

            return;
        }

        // ==========================================
        // CHECK FILE EXISTS
        // ==========================================

        if (!resumeFile.exists() ||
            !resumeFile.isFile()) {

            response.sendError(
                HttpServletResponse.SC_NOT_FOUND,
                "Resume file not found."
            );

            return;
        }

        // ==========================================
        // SEND PDF TO COMPANY
        // ==========================================

        response.setContentType("application/pdf");

        response.setContentLengthLong(
            resumeFile.length()
        );

        response.setHeader(
            "Content-Disposition",
            "inline; filename=\"" +
            resumeFile.getName() +
            "\""
        );

        try (OutputStream out =
                     response.getOutputStream()) {

            Files.copy(
                resumeFile.toPath(),
                out
            );
        }
    }
}