<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.campusconnect.model.User" %>
<%@ page import="com.campusconnect.model.Application" %>
<%@ page import="com.campusconnect.dao.ApplicationDAO" %>

<%
    // =========================================================
    // ADMIN ACCESS CHECK
    // =========================================================

    User user = (User) session.getAttribute("user");

    if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // =========================================================
    // GET APPLICATION ID
    // =========================================================

    String appIdParam = request.getParameter("appId");

    if (appIdParam == null || appIdParam.trim().isEmpty()) {
        response.sendRedirect("adminDashboard.jsp");
        return;
    }

    int appId;

    try {
        appId = Integer.parseInt(appIdParam);
    } catch (NumberFormatException e) {
        response.sendRedirect("adminDashboard.jsp");
        return;
    }

    // =========================================================
    // LOAD APPLICATION
    // =========================================================

    ApplicationDAO applicationDAO = new ApplicationDAO();

    Application app = applicationDAO.getApplicationById(appId);

    if (application == null) {
        response.sendRedirect("adminDashboard.jsp");
        return;
    }

    // =========================================================
    // STATUS STYLE
    // =========================================================

    String status = app.getStatus();

    String statusClass = "status-pending";

    if ("ACCEPTED".equalsIgnoreCase(status)) {
        statusClass = "status-accepted";
    } else if ("REJECTED".equalsIgnoreCase(status)) {
        statusClass = "status-rejected";
    }

    // =========================================================
    // RESUME
    // =========================================================

    String resumePath = app.getResumePath();

%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Application Details | CampusConnect</title>


    <!-- ================= BOOTSTRAP ================= -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <!-- ================= BOOTSTRAP ICONS ================= -->

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <style>

        /* ================================================= */
        /* ================= GENERAL ======================= */
        /* ================================================= */

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #071426;
            color: #f5f1e8;
            font-family: "Segoe UI", Arial, sans-serif;
        }


        /* ================================================= */
        /* ================= NAVBAR ======================== */
        /* ================================================= */

        .navbar-custom {
            background: #071426;
            border-bottom: 1px solid rgba(214,173,82,.18);
            padding: 20px 0;
        }

        .navbar-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;

            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .navbar-left {
            display: flex;
            align-items: center;
            gap: 18px;
        }


        /* ================================================= */
        /* ================= BACK BUTTON =================== */
        /* ================================================= */

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;

            color: #d6ad52 !important;

            font-size: 14px;
            font-weight: 700;

            padding: 10px 14px;

            border: 1px solid rgba(214,173,82,.25);
            border-radius: 10px;

            background: transparent;

            text-decoration: none;

            transition: .3s ease;
        }

        .back-btn:hover {
            color: #071426 !important;

            background: #d6ad52;

            border-color: #d6ad52;

            transform: translateY(-2px);

            box-shadow:
                0 0 10px rgba(214,173,82,.35),
                0 0 25px rgba(214,173,82,.15);
        }


        /* ================================================= */
        /* ================= LOGO ========================== */
        /* ================================================= */

        .brand {
            color: #f5f1e8;

            text-decoration: none;

            font-size: 24px;
            font-weight: 750;

            transition: .3s ease;
        }

        .brand i {
            color: #d6ad52;
            margin-right: 8px;
        }

        .brand:hover {
            color: #ffffff;

            text-shadow:
                0 0 8px rgba(214,173,82,.35);
        }


        /* ================================================= */
        /* ================= RIGHT SIDE ==================== */
        /* ================================================= */

        .navbar-right {
            display: flex;
            align-items: center;
        }

        .admin-name {
            color: #b8c0cb;

            font-weight: 600;

            display: flex;
            align-items: center;
        }

        .admin-icon {
            width: 40px;
            height: 40px;

            border-radius: 50%;

            background: rgba(214,173,82,.10);

            border: 1px solid rgba(214,173,82,.25);

            color: #d6ad52;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            margin-right: 8px;

            box-shadow:
                0 0 8px rgba(214,173,82,.15);
        }


        /* ================================================= */
        /* ================= PAGE HEADER =================== */
        /* ================================================= */

        .page-header {
            padding: 65px 0 45px;

            background:
                radial-gradient(
                    circle at 85% 20%,
                    rgba(214,173,82,.12),
                    transparent 30%
                ),
                #0a1a2e;

            border-bottom:
                1px solid rgba(214,173,82,.10);
        }

        .page-label {
            color: #d6ad52;

            font-size: 13px;

            font-weight: 700;

            letter-spacing: 2px;

            text-transform: uppercase;
        }

        .page-header h1 {
            font-size: 44px;

            font-weight: 800;

            letter-spacing: -1.5px;

            margin-top: 12px;
            margin-bottom: 10px;
        }

        .page-header p {
            color: #8d98a6;

            font-size: 16px;

            margin: 0;

            line-height: 1.7;
        }


        /* ================================================= */
        /* ================= MAIN CONTENT ================== */
        /* ================================================= */

        .application-container {
            max-width: 1200px;

            margin: 0 auto;

            padding: 60px 20px 90px;
        }


        /* ================================================= */
        /* ================= DETAIL CARDS ================== */
        /* ================================================= */

        .detail-card {

            height: 100%;

            background:
                linear-gradient(
                    145deg,
                    rgba(255,255,255,.045),
                    rgba(255,255,255,.015)
                );

            border:
                1px solid rgba(255,255,255,.09);

            border-radius: 18px;

            overflow: hidden;

            transition:
                transform .3s ease,
                border-color .3s ease,
                box-shadow .3s ease;
        }

        .detail-card:hover {

            transform: translateY(-4px);

            border-color:
                rgba(214,173,82,.35);

            box-shadow:
                0 0 15px rgba(214,173,82,.08),
                0 20px 45px rgba(0,0,0,.20);
        }


        /* ================================================= */
        /* ================= CARD HEADER =================== */
        /* ================================================= */

        .detail-header {

            padding: 22px 25px;

            border-bottom:
                1px solid rgba(255,255,255,.08);

            display: flex;

            align-items: center;

            justify-content: space-between;
        }

        .detail-header h3 {

            margin: 0;

            font-size: 20px;

            font-weight: 700;
        }

        .detail-header h3 i {

            color: #d6ad52;

            margin-right: 8px;
        }


        /* ================================================= */
        /* ================= CARD BODY ===================== */
        /* ================================================= */

        .detail-body {

            padding: 25px;
        }


        /* ================================================= */
        /* ================= INFO ITEM ===================== */
        /* ================================================= */

        .info-item {

            margin-bottom: 22px;
        }

        .info-item:last-child {

            margin-bottom: 0;
        }

        .info-label {

            display: block;

            color: #707b89;

            font-size: 11px;

            font-weight: 700;

            text-transform: uppercase;

            letter-spacing: .8px;

            margin-bottom: 7px;
        }

        .info-value {

            color: #f5f1e8;

            font-size: 15px;

            font-weight: 600;

            word-break: break-word;
        }

        .info-value.muted {

            color: #aeb6c1;

            font-weight: 500;

            line-height: 1.6;
        }


        /* ================================================= */
        /* ================= ICON BOX ====================== */
        /* ================================================= */

        .application-icon {

            width: 48px;

            height: 48px;

            border-radius: 12px;

            background:
                rgba(214,173,82,.10);

            border:
                1px solid rgba(214,173,82,.22);

            color: #d6ad52;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 20px;

            margin-bottom: 18px;
        }


        /* ================================================= */
        /* ================= STATUS ======================== */
        /* ================================================= */

        .status-badge {

            display: inline-block;

            padding: 6px 12px;

            border-radius: 7px;

            font-size: 11px;

            font-weight: 700;

            text-transform: uppercase;
        }

        .status-pending {

            background:
                rgba(214,173,82,.12);

            color: #d6ad52;

            border:
                1px solid rgba(214,173,82,.25);
        }

        .status-accepted {

            background:
                rgba(72,180,120,.12);

            color: #72d19b;

            border:
                1px solid rgba(72,180,120,.25);
        }

        .status-rejected {

            background:
                rgba(220,80,80,.12);

            color: #e98585;

            border:
                1px solid rgba(220,80,80,.25);
        }


        /* ================================================= */
        /* ================= APPLICATION ID ================= */
        /* ================================================= */

        .application-id {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            padding: 6px 10px;

            border-radius: 7px;

            background:
                rgba(214,173,82,.08);

            border:
                1px solid rgba(214,173,82,.18);

            color: #d6ad52;

            font-size: 13px;

            font-weight: 700;
        }


        /* ================================================= */
        /* ================= SKILLS ========================= */
        /* ================================================= */

        .skills-box {

            background:
                rgba(255,255,255,.025);

            border:
                1px solid rgba(255,255,255,.06);

            border-radius: 10px;

            padding: 14px 16px;

            color: #b8c0cb;

            font-size: 14px;

            line-height: 1.7;
        }


        /* ================================================= */
        /* ================= RESUME ========================= */
        /* ================================================= */

        .resume-box {

            display: flex;

            align-items: center;

            justify-content: space-between;

            gap: 15px;

            padding: 18px;

            border-radius: 12px;

            background:
                rgba(214,173,82,.035);

            border:
                1px solid rgba(214,173,82,.15);
        }

        .resume-info {

            display: flex;

            align-items: center;

            gap: 13px;

            min-width: 0;
        }

        .resume-icon {

            width: 43px;

            height: 43px;

            flex-shrink: 0;

            border-radius: 10px;

            background:
                rgba(214,173,82,.10);

            border:
                1px solid rgba(214,173,82,.20);

            color: #d6ad52;

            display: flex;

            align-items: center;

            justify-content: center;

            font-size: 19px;
        }

        .resume-text {

            min-width: 0;
        }

        .resume-text strong {

            display: block;

            color: #f5f1e8;

            font-size: 14px;

            margin-bottom: 3px;
        }

        .resume-text span {

            display: block;

            color: #707b89;

            font-size: 12px;

            overflow: hidden;

            text-overflow: ellipsis;

            white-space: nowrap;

            max-width: 450px;
        }


        /* ================================================= */
        /* ================= RESUME BUTTON ================= */
        /* ================================================= */

        .resume-btn {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            padding: 9px 13px;

            color: #d6ad52;

            border:
                1px solid rgba(214,173,82,.25);

            border-radius: 8px;

            background: transparent;

            text-decoration: none;

            font-size: 13px;

            font-weight: 700;

            white-space: nowrap;

            transition: .3s ease;
        }

        .resume-btn:hover {

            color: #071426;

            background: #d6ad52;

            border-color: #d6ad52;

            transform: translateY(-1px);
        }


        /* ================================================= */
        /* ================= EMPTY RESUME ================== */
        /* ================================================= */

        .no-resume {

            padding: 18px;

            border-radius: 12px;

            background:
                rgba(255,255,255,.025);

            border:
                1px solid rgba(255,255,255,.06);

            color: #707b89;

            font-size: 14px;
        }


        /* ================================================= */
        /* ================= BACK DASHBOARD ================= */
        /* ================================================= */

        .dashboard-btn {

            display: inline-flex;

            align-items: center;

            gap: 7px;

            margin-top: 35px;

            padding: 11px 17px;

            color: #d6ad52;

            border:
                1px solid rgba(214,173,82,.25);

            border-radius: 9px;

            background: transparent;

            text-decoration: none;

            font-size: 14px;

            font-weight: 700;

            transition: .3s ease;
        }

        .dashboard-btn:hover {

            color: #071426;

            background: #d6ad52;

            border-color: #d6ad52;

            transform: translateY(-2px);
        }


        /* ================================================= */
        /* ================= FOOTER ======================== */
        /* ================================================= */

        footer {

            background: #050f1c;

            border-top:
                1px solid rgba(255,255,255,.06);

            padding: 28px 0;

            color: #707b89;
        }


        /* ================================================= */
        /* ================= RESPONSIVE ==================== */
        /* ================================================= */

        @media (max-width: 768px) {

            .navbar-custom {

                padding: 16px 0;
            }

            .navbar-container {

                padding: 0 15px;
            }

            .navbar-left {

                gap: 10px;
            }

            .brand {

                font-size: 21px;
            }

            .admin-name {

                font-size: 14px;
            }

            .admin-icon {

                width: 35px;

                height: 35px;
            }

            .back-btn {

                padding: 8px 12px;
            }

            .page-header {

                padding: 50px 20px 40px;
            }

            .page-header h1 {

                font-size: 36px;
            }

            .application-container {

                padding: 45px 15px 70px;
            }

            .resume-box {

                align-items: flex-start;

                flex-direction: column;
            }

            .resume-btn {

                width: 100%;

                justify-content: center;
            }
        }


        @media (max-width: 480px) {

            .navbar-container {

                padding: 0 12px;
            }

            .navbar-left {

                gap: 7px;
            }

            .brand {

                font-size: 19px;
            }

            .brand i {

                margin-right: 5px;
            }

            .admin-name {

                font-size: 13px;
            }

            .admin-icon {

                width: 32px;

                height: 32px;

                margin-right: 5px;
            }

            .back-btn {

                padding: 7px 10px;

                font-size: 13px;
            }

            .page-header {

                padding: 45px 18px 35px;
            }

            .page-header h1 {

                font-size: 32px;
            }

            .application-container {

                padding: 40px 12px 60px;
            }

            .detail-header {

                padding: 20px;
            }

            .detail-body {

                padding: 20px;
            }

            .detail-header h3 {

                font-size: 18px;
            }
        }

    </style>

</head>


<body>


<!-- ================================================= -->
<!-- ================= NAVBAR ======================== -->
<!-- ================================================= -->

<nav class="navbar-custom">

    <div class="navbar-container">

        <div class="navbar-left">

            <!-- BACK -->

            <a href="adminDashboard.jsp"
               class="back-btn">

                <i class="bi bi-arrow-left"></i>

                <span>Back</span>

            </a>


            <!-- LOGO -->

            <a href="adminDashboard.jsp"
               class="brand">

                <i class="bi bi-mortarboard-fill"></i>

                <span>CampusConnect</span>

            </a>

        </div>


        <!-- ADMIN -->

        <div class="navbar-right">

            <div class="admin-name">

                <span class="admin-icon">

                    <i class="bi bi-shield-check"></i>

                </span>

                <span>
                    <%= user.getName() %>
                </span>

            </div>

        </div>

    </div>

</nav>


<!-- ================================================= -->
<!-- ================= PAGE HEADER =================== -->
<!-- ================================================= -->

<section class="page-header">

    <div class="container">

        <div class="page-label">
            Administration
        </div>

        <h1>
            Application Details
        </h1>

        <p>
            Review the complete information submitted for this application.
        </p>

    </div>

</section>


<!-- ================================================= -->
<!-- ================= APPLICATION =================== -->
<!-- ================================================= -->

<section>

    <div class="application-container">


        <!-- ================================================= -->
        <!-- APPLICATION INFORMATION -->
        <!-- ================================================= -->

        <div class="row g-4">


            <!-- APPLICATION CARD -->

            <div class="col-lg-6">

                <div class="detail-card">

                    <div class="detail-header">

                        <h3>

                            <i class="bi bi-file-earmark-check-fill"></i>

                            Application Information

                        </h3>

                    </div>


                    <div class="detail-body">

                        <div class="application-icon">

                            <i class="bi bi-file-earmark-text-fill"></i>

                        </div>


                        <div class="info-item">

                            <span class="info-label">
                                Application ID
                            </span>

                            <span class="application-id">

                                <i class="bi bi-hash"></i>

                                <%= app.getAppId() %>

                            </span>

                        </div>


                        <div class="info-item">

                            <span class="info-label">
                                Applied Date
                            </span>

                            <div class="info-value">

                                <i class="bi bi-calendar3"
                                   style="color:#d6ad52;margin-right:6px;"></i>

                                <%= app.getAppliedDate() %>

                            </div>

                        </div>


                        <div class="info-item">

                            <span class="info-label">
                                Application Status
                            </span>

                            <span class="status-badge <%= statusClass %>">

                                <%= status %>

                            </span>

                        </div>


                        <div class="info-item">

                            <span class="info-label">
                                Student ID
                            </span>

                            <div class="info-value">

                                <%= app.getStudentId() %>

                            </div>

                        </div>

                    </div>

                </div>

            </div>


            <!-- OPPORTUNITY CARD -->

            <div class="col-lg-6">

                <div class="detail-card">

                    <div class="detail-header">

                        <h3>

                            <i class="bi bi-briefcase-fill"></i>

                            Opportunity Information

                        </h3>

                    </div>


                    <div class="detail-body">

                        <div class="application-icon">

                            <i class="bi bi-briefcase-fill"></i>

                        </div>


                        <div class="info-item">

                            <span class="info-label">
                                Opportunity Title
                            </span>

                            <div class="info-value">

                                <%= app.getOpportunityTitle() %>

                            </div>

                        </div>


                        <div class="info-item">

                            <span class="info-label">
                                Opportunity ID
                            </span>

                            <div class="info-value">

                                <%= app.getOppId() %>

                            </div>

                        </div>


                        <div class="info-item">

                            <span class="info-label">
                                Company
                            </span>

                            <div class="info-value">

                                <i class="bi bi-building"
                                   style="color:#d6ad52;margin-right:6px;"></i>

                                <%= app.getCompanyName() %>

                            </div>

                        </div>

                    </div>

                </div>

            </div>


            <!-- ================================================= -->
            <!-- STUDENT INFORMATION -->
            <!-- ================================================= -->

            <div class="col-12">

                <div class="detail-card">

                    <div class="detail-header">

                        <h3>

                            <i class="bi bi-person-fill"></i>

                            Student Information

                        </h3>

                    </div>


                    <div class="detail-body">

                        <div class="row g-4">


                            <div class="col-md-6">

                                <div class="info-item">

                                    <span class="info-label">
                                        Student Name
                                    </span>

                                    <div class="info-value">

                                        <%=app.getStudentName() %>

                                    </div>

                                </div>

                            </div>


                            <div class="col-md-6">

                                <div class="info-item">

                                    <span class="info-label">
                                        Student ID
                                    </span>

                                    <div class="info-value">

                                        <%= app.getStudentId() %>

                                    </div>

                                </div>

                            </div>


                            <div class="col-md-6">

                                <div class="info-item">

                                    <span class="info-label">
                                        Education
                                    </span>

                                    <div class="info-value muted">

                                        <%
                                            String education =
                                                app.getEducation();

                                            if (education != null
                                                && !education.trim().isEmpty()) {
                                        %>

                                            <%= education %>

                                        <%
                                            } else {
                                        %>

                                            Not provided

                                        <%
                                            }
                                        %>

                                    </div>

                                </div>

                            </div>


                            <div class="col-md-6">

                                <div class="info-item">

                                    <span class="info-label">
                                        Skills
                                    </span>

                                    <div class="skills-box">

                                        <%
                                            String skills =
                                                app.getSkills();

                                            if (skills != null
                                                && !skills.trim().isEmpty()) {
                                        %>

                                            <%= skills %>

                                        <%
                                            } else {
                                        %>

                                            No skills provided

                                        <%
                                            }
                                        %>

                                    </div>

                                </div>

                            </div>

                        </div>

                    </div>

                </div>

            </div>


            <!-- ================================================= -->
            <!-- RESUME -->
            <!-- ================================================= -->

            <div class="col-12">

                <div class="detail-card">

                    <div class="detail-header">

                        <h3>

                            <i class="bi bi-file-earmark-pdf-fill"></i>

                            Resume

                        </h3>

                    </div>


                    <div class="detail-body">

                        <%
                            if (resumePath != null
                                && !resumePath.trim().isEmpty()) {
                        %>

                            <div class="resume-box">

                                <div class="resume-info">

                                    <div class="resume-icon">

                                        <i class="bi bi-file-earmark-pdf-fill"></i>

                                    </div>

                                    <div class="resume-text">

                                        <strong>
                                            Student Resume
                                        </strong>

                                        <span>
                                            <%= resumePath %>
                                        </span>

                                    </div>

                                </div>


                                <a
                                    href="<%= request.getContextPath() %>/<%= resumePath %>"
                                    target="_blank"
                                    class="resume-btn">

                                    <i class="bi bi-box-arrow-up-right"></i>

                                    View Resume

                                </a>

                            </div>

                        <%
                            } else {
                        %>

                            <div class="no-resume">

                                <i class="bi bi-file-earmark-x"
                                   style="margin-right:7px;"></i>

                                No resume has been uploaded for this application.

                            </div>

                        <%
                            }
                        %>

                    </div>

                </div>

            </div>


        </div>


        <!-- ================================================= -->
        <!-- BACK BUTTON -->
        <!-- ================================================= -->

        <a href="adminDashboard.jsp"
           class="dashboard-btn">

            <i class="bi bi-arrow-left"></i>

            Back to Applications

        </a>


    </div>

</section>


<!-- ================================================= -->
<!-- ================= FOOTER ======================== -->
<!-- ================================================= -->

<footer>

    <div class="container text-center">

        <small>

            © 2026 CampusConnect · Administration

        </small>

    </div>

</footer>


</body>

</html>