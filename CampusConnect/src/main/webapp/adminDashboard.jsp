<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.campusconnect.model.User" %>
<%@ page import="com.campusconnect.model.Company" %>
<%@ page import="com.campusconnect.model.Opportunity" %>
<%@ page import="com.campusconnect.model.Application" %>

<%@ page import="com.campusconnect.dao.UserDAO" %>
<%@ page import="com.campusconnect.dao.CompanyDAO" %>
<%@ page import="com.campusconnect.dao.OpportunityDAO" %>
<%@ page import="com.campusconnect.dao.ApplicationDAO" %>

<%@ page import="java.util.List" %>



<%
    // =========================================================
    // ADMIN ACCESS CHECK
    // =========================================================

    User user = (User) session.getAttribute("user");

    if (user == null || !"ADMIN".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }


    // =========================================================
    // LOAD DATABASE DATA
    // =========================================================

    UserDAO userDAO = new UserDAO();
    CompanyDAO companyDAO = new CompanyDAO();
    OpportunityDAO opportunityDAO = new OpportunityDAO();
    ApplicationDAO applicationDAO = new ApplicationDAO();

    List<User> users = userDAO.getAllUsers();
    List<Company> companies = companyDAO.getAllCompanies();
    List<Opportunity> opportunities = opportunityDAO.getAllOpportunities();
    List<Application> applications = applicationDAO.getAllApplications();


    // =========================================================
    // CALCULATE COUNTS
    // =========================================================

    int totalUsers = users.size();
    int totalStudents = 0;
    int totalCompanies = companies.size();

    for (User u : users) {

        if ("STUDENT".equalsIgnoreCase(u.getRole())) {
            totalStudents++;
        }

        if ("COMPANY".equalsIgnoreCase(u.getRole())) {
            totalCompanies++;
        }
    }

    int totalOpportunities = opportunities.size();
    int totalApplications = applications.size();
%>
<%
    String message = request.getParameter("message");
%>

<% if ("deleted".equals(message)) { %>

    <div class="success-message">
        <i class="bi bi-check-circle-fill"></i>
        User deleted successfully.
    </div>

<% } else if ("failed".equals(message)) { %>

    <div class="error-message">
        <i class="bi bi-exclamation-circle-fill"></i>
        Unable to delete the user.
    </div>

<% } else if ("invalid".equals(message)) { %>

    <div class="error-message">
        <i class="bi bi-exclamation-circle-fill"></i>
        Invalid user ID.
    </div>

<% } else if ("opportunityUpdated".equals(message)) { %>

    <div class="success-message">
        <i class="bi bi-check-circle-fill"></i>
        Opportunity updated successfully.
    </div>

<% } else if ("oppNotFound".equals(message)) { %>

    <div class="error-message">
        <i class="bi bi-exclamation-circle-fill"></i>
        Opportunity not found.
    </div>

<% } %>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Admin Dashboard | CampusConnect</title>


    <!-- ================= BOOTSTRAP ================= -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">


    <!-- ================= BOOTSTRAP ICONS ================= -->

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <style>
    .action-buttons {
    display: flex;
    align-items: center;
    gap: 8px;
}

.edit-btn {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 8px 12px;
    color: #c5ccd5;
    border: 1px solid rgba(255,255,255,.15);
    border-radius: 8px;
    background: transparent;
    text-decoration: none;
    font-size: 13px;
    font-weight: 700;
    transition: .3s ease;
}

.edit-btn:hover {
    color: #071426;
    background: #f5f1e8;
    border-color: #f5f1e8;
    transform: translateY(-1px);
}
    .view-btn {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    padding: 8px 12px;
    color: #d6ad52;
    border: 1px solid rgba(214,173,82,.25);
    border-radius: 8px;
    background: transparent;
    text-decoration: none;
    font-size: 13px;
    font-weight: 700;
    transition: .3s ease;
}

.view-btn:hover {
    color: #071426;
    background: #d6ad52;
    border-color: #d6ad52;
    transform: translateY(-1px);
}
/* ================================================= */
/* ================= ADMIN ACTION ================== */
/* ================================================= */

.admin-action {
    display: flex;
    align-items: center;
    gap: 16px;
    padding: 18px 20px;
    border: 1px solid rgba(214,173,82,.18);
    border-radius: 12px;
    background: rgba(214,173,82,.035);
    color: #f5f1e8;
    text-decoration: none;
    transition: .3s ease;
}

.admin-action > i:first-child {
    width: 45px;
    height: 45px;
    border-radius: 11px;
    display: flex;
    align-items: center;
    justify-content: center;
    background: rgba(214,173,82,.10);
    border: 1px solid rgba(214,173,82,.22);
    color: #d6ad52;
    font-size: 20px;
}

.admin-action div {
    flex: 1;
}

.admin-action strong {
    display: block;
    font-size: 15px;
    margin-bottom: 4px;
}

.admin-action span {
    display: block;
    color: #8d98a6;
    font-size: 13px;
}

.admin-action .arrow-icon {
    color: #d6ad52;
    font-size: 17px;
    transition: .3s ease;
}

.admin-action:hover {
    border-color: rgba(214,173,82,.45);
    background: rgba(214,173,82,.07);
    transform: translateY(-2px);
}

.admin-action:hover .arrow-icon {
    transform: translateX(4px);
}
.success-message {
    margin: 20px 0;
    padding: 13px 18px;
    border: 1px solid rgba(214, 173, 82, 0.35);
    border-radius: 10px;
    background: rgba(214, 173, 82, 0.08);
    color: #d6ad52;
    font-size: 14px;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 9px;
}

.success-message i {
    font-size: 17px;
}

.error-message {
    margin: 20px 0;
    padding: 13px 18px;
    border: 1px solid rgba(220, 80, 80, 0.3);
    border-radius: 10px;
    background: rgba(220, 80, 80, 0.08);
    color: #e58b8b;
    font-size: 14px;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 9px;
}
        
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
            gap: 5px;

            color: #d6ad52 !important;

            font-size: 14px;
            font-weight: 700;

            margin-left: 0;
            padding: 10px 14px !important;

            border: 1px solid rgba(214,173,82,.25);
            border-radius: 10px;

            background: transparent;

            cursor: pointer;

            transition: .3s ease;
        }

        .back-btn i {
            margin-right: 5px;
        }

        .back-btn:hover {
            color: #071426 !important;
            background: #d6ad52 !important;

            border-color: #d6ad52;

            box-shadow:
                0 0 10px rgba(214,173,82,.35),
                0 0 25px rgba(214,173,82,.15);

            transform: translateY(-2px);
        }

        .back-btn:hover i {
            color: #071426;
            text-shadow: none;
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

            transition: .3s ease;
        }

        .brand:hover {
            color: #ffffff;

            text-shadow:
                0 0 8px rgba(214,173,82,.35);
        }

        .brand:hover i {
            text-shadow:
                0 0 10px rgba(214,173,82,.65);
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

            transition: .3s ease;

            box-shadow:
                0 0 8px rgba(214,173,82,.15);
        }


        /* ================================================= */
        /* ================= HERO ========================== */
        /* ================================================= */

        .hero {
            padding: 75px 0;

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

        .hero-label {
            color: #d6ad52;

            font-size: 13px;
            font-weight: 700;

            letter-spacing: 2px;

            text-transform: uppercase;
        }

        .hero h1 {
            font-size: 50px;
            font-weight: 800;
            letter-spacing: -2px;
        }

        .hero p {
            color: #8d98a6;

            font-size: 17px;

            max-width: 650px;

            line-height: 1.7;
        }


        /* ================================================= */
        /* ================= DASHBOARD ===================== */
        /* ================================================= */

        .dashboard {
            padding: 70px 0 90px;
        }

        .section-title {
            font-size: 32px;
            font-weight: 750;
        }


        /* ================================================= */
        /* ================= STAT CARDS ==================== */
        /* ================================================= */

        .stat-card {
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

            padding: 28px;

            transition:
                transform .3s ease,
                border-color .3s ease,
                box-shadow .3s ease;
        }

        .stat-card:hover {
            transform: translateY(-6px);

            border-color:
                rgba(214,173,82,.45);

            box-shadow:
                0 0 15px rgba(214,173,82,.10),
                0 20px 45px rgba(0,0,0,.25);
        }

        .stat-icon {
            width: 55px;
            height: 55px;

            border-radius: 14px;

            background:
                rgba(214,173,82,.10);

            border:
                1px solid rgba(214,173,82,.25);

            color: #d6ad52;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 23px;

            margin-bottom: 18px;
        }

        .stat-card h3 {
            font-size: 34px;
            font-weight: 800;

            margin-bottom: 3px;
        }

        .stat-card p {
            color: #8d98a6;

            margin: 0;

            font-size: 14px;
        }


        /* ================================================= */
        /* ================= DATA SECTION ================== */
        /* ================================================= */

        .data-section {
            margin-top: 65px;
        }

        .data-card {
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

            margin-bottom: 35px;
        }

        .data-header {
            padding: 24px 28px;

            border-bottom:
                1px solid rgba(255,255,255,.08);

            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .data-header h3 {
            margin: 0;

            font-size: 21px;
            font-weight: 700;
        }

        .data-header i {
            color: #d6ad52;
            margin-right: 8px;
        }

        .count-badge {
            background:
                rgba(214,173,82,.12);

            color: #d6ad52;

            border:
                1px solid rgba(214,173,82,.25);

            padding: 6px 11px;

            border-radius: 8px;

            font-size: 12px;
            font-weight: 700;
        }


        /* ================================================= */
        /* ================= TABLE ========================= */
        /* ================================================= */

        .table-wrapper {
            overflow-x: auto;
        }

        .admin-table {
            width: 100%;

            margin: 0;

            border-collapse: collapse;
        }

        .admin-table thead th {
            background:
                rgba(214,173,82,.06);

            color: #d6ad52;

            font-size: 12px;

            text-transform: uppercase;

            letter-spacing: .6px;

            font-weight: 700;

            padding: 15px 18px;

            border-bottom:
                1px solid rgba(255,255,255,.08);

            white-space: nowrap;
        }

        .admin-table tbody td {
            color: #c5ccd5;

            padding: 15px 18px;

            font-size: 14px;

            border-bottom:
                1px solid rgba(255,255,255,.05);

            vertical-align: middle;
        }

        .admin-table tbody tr {
            transition: background .2s ease;
        }

        .admin-table tbody tr:hover {
            background:
                rgba(214,173,82,.035);
        }

        .admin-table tbody tr:last-child td {
            border-bottom: none;
        }


        /* ================================================= */
        /* ================= ROLE BADGE ==================== */
        /* ================================================= */

        .role-badge {
            display: inline-block;

            padding: 5px 10px;

            border-radius: 7px;

            background:
                rgba(214,173,82,.10);

            color: #d6ad52;

            border:
                1px solid rgba(214,173,82,.20);

            font-size: 11px;

            font-weight: 700;
        }


        /* ================================================= */
        /* ================= DELETE BUTTON ================= */
        /* ================================================= */

        .delete-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;

            padding: 8px 12px;

            color: #d6ad52;

            border:
                1px solid rgba(214,173,82,.25);

            border-radius: 8px;

            background: transparent;

            text-decoration: none;

            font-size: 13px;

            font-weight: 700;

            transition: .3s ease;
        }

        .delete-btn:hover {
            color: #071426;

            background: #d6ad52;

            border-color: #d6ad52;

            transform: translateY(-1px);
        }

        .delete-btn i {
            margin-right: 2px;
        }

        .admin-protected {
            display: inline-flex;
            align-items: center;
            gap: 5px;

            color: #707b89;

            font-size: 13px;

            font-weight: 600;
        }


        /* ================================================= */
        /* ================= STATUS BADGE ================== */
        /* ================================================= */

        .status-badge {
            display: inline-block;

            padding: 5px 11px;

            border-radius: 7px;

            font-size: 11px;

            font-weight: 700;
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
        /* ================= EMPTY DATA ==================== */
        /* ================================================= */

        .empty-data {
            text-align: center;

            padding: 45px 20px;

            color: #707b89;
        }

        .empty-data i {
            font-size: 35px;

            color: #596574;

            display: block;

            margin-bottom: 12px;
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
                padding: 8px 13px;
            }

            .hero {
                padding: 55px 20px;
            }

            .hero h1 {
                font-size: 38px;
                letter-spacing: -1.5px;
            }

            .hero p {
                font-size: 16px;
            }

            .dashboard {
                padding: 50px 15px 70px;
            }

            .section-title {
                font-size: 28px;
            }

            .data-section {
                margin-top: 45px;
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

            .hero {
                padding: 45px 18px;
            }

            .hero h1 {
                font-size: 34px;
            }

            .hero-label {
                font-size: 11px;
                letter-spacing: 1.5px;
            }

            .dashboard {
                padding: 45px 12px 60px;
            }

            .stat-card {
                padding: 24px;
            }

            .data-header {
                padding: 20px;
            }

            .admin-table thead th,
            .admin-table tbody td {
                padding: 12px 14px;
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

        <!-- ================= LEFT SIDE ================= -->

        <div class="navbar-left">

            <!-- BACK BUTTON -->

            <button
                type="button"
                class="back-btn"
                onclick="history.back();">

                <i class="bi bi-arrow-left"></i>
                <span>Back</span>

            </button>


            <!-- LOGO -->

            <a
                href="adminDashboard.jsp"
                class="brand">

                <i class="bi bi-mortarboard-fill"></i>
                <span>CampusConnect</span>

            </a>

        </div>


        <!-- ================= RIGHT SIDE ================= -->

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
<!-- ================= HERO ========================== -->
<!-- ================================================= -->

<section class="hero">

    <div class="container">

        <div class="hero-label">
            Administration
        </div>


        <h1 class="mt-3">

            Welcome,

            <span style="color:#d6ad52;">
                <%= user.getName() %>.
            </span>

        </h1>


        <p class="mt-3 mb-0">

            Monitor and manage the CampusConnect
            platform from one place.

        </p>

    </div>

</section>



<!-- ================================================= -->
<!-- ================= DASHBOARD ==================== -->
<!-- ================================================= -->

<section class="dashboard">

    <div class="container">


        <h2 class="section-title mb-4">
            Administration overview
        </h2>


        <!-- ================================================= -->
        <!-- ================= STAT CARDS ==================== -->
        <!-- ================================================= -->

        <div class="row g-4">


            <!-- TOTAL USERS -->

            <div class="col-sm-6 col-lg-3">

                <div class="stat-card">

                    <div class="stat-icon">
                        <i class="bi bi-people-fill"></i>
                    </div>

                    <h3>
                        <%= totalUsers %>
                    </h3>

                    <p>
                        Total Users
                    </p>

                </div>

            </div>


            <!-- STUDENTS -->

            <div class="col-sm-6 col-lg-3">

                <div class="stat-card">

                    <div class="stat-icon">
                        <i class="bi bi-mortarboard-fill"></i>
                    </div>

                    <h3>
                        <%= totalStudents %>
                    </h3>

                    <p>
                        Students
                    </p>

                </div>

            </div>


            <!-- COMPANIES -->

            <div class="col-sm-6 col-lg-3">

                <div class="stat-card">

                    <div class="stat-icon">
                        <i class="bi bi-building-fill"></i>
                    </div>

                    <h3>
                        <%= totalCompanies %>
                    </h3>

                    <p>
                        Companies
                    </p>

                </div>

            </div>


            <!-- OPPORTUNITIES -->

            <div class="col-sm-6 col-lg-3">

                <div class="stat-card">

                    <div class="stat-icon">
                        <i class="bi bi-briefcase-fill"></i>
                    </div>

                    <h3>
                        <%= totalOpportunities %>
                    </h3>

                    <p>
                        Opportunities
                    </p>

                </div>

            </div>

        </div>



        <!-- ================================================= -->
        <!-- ================= DATA SECTIONS ================= -->
        <!-- ================================================= -->

        <div class="data-section">


            <!-- ================================================= -->
            <!-- ================= USERS ========================= -->
            <!-- ================================================= -->

            <div class="data-card">

                <div class="data-header">

                    <h3>
                        <i class="bi bi-people-fill"></i>
                        All Users
                    </h3>

                    <span class="count-badge">
                        <%= totalUsers %> Users
                    </span>

                </div>


                <div class="table-wrapper">

                    <% if (users.isEmpty()) { %>

                        <div class="empty-data">

                            <i class="bi bi-people"></i>

                            No users found.

                        </div>

                    <% } else { %>

                        <table class="admin-table">

                            <thead>

                                <tr>

                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Action</th>

                                </tr>

                            </thead>


                            <tbody>

                            <% for (User u : users) { %>

                                <tr>

                                    <td>
                                        <%= u.getUserId() %>
                                    </td>

                                    <td>
                                        <%= u.getName() %>
                                    </td>

                                    <td>
                                        <%= u.getEmail() %>
                                    </td>

                                    <td>

                                        <span class="role-badge">
                                            <%= u.getRole() %>
                                        </span>

                                    </td>

                                    <td>

                                        <% if (!"ADMIN".equalsIgnoreCase(u.getRole())) { %>

                                            <a
                                                href="<%= request.getContextPath() %>/deleteUser?userId=<%= u.getUserId() %>"
                                                class="delete-btn"
                                                onclick="return confirm('Are you sure you want to delete this user?');">

                                                <i class="bi bi-trash3"></i>
                                                Delete

                                            </a>

                                        <% } else { %>

                                            <span class="admin-protected">

                                                <i class="bi bi-shield-check"></i>
                                                Protected

                                            </span>

                                        <% } %>

                                    </td>

                                </tr>

                            <% } %>

                            </tbody>

                        </table>

                    <% } %>

                </div>

            </div>



            <!-- ================================================= -->
            <!-- ================= COMPANIES ===================== -->
            <!-- ================================================= -->

            <div class="data-card">

                <div class="data-header">

                    <h3>

                        <i class="bi bi-building-fill"></i>
                        All Companies

                    </h3>

                    <span class="count-badge">
                        <%= totalCompanies %> Companies
                    </span>

                </div>


                <div class="table-wrapper">

                    <% if (companies.isEmpty()) { %>

                        <div class="empty-data">

                            <i class="bi bi-building"></i>

                            No company profiles found.

                        </div>

                    <% } else { %>

                        <table class="admin-table">

                            <thead>

                                <tr>

                                    <th>ID</th>
                                    <th>Company</th>
                                    <th>Industry</th>
                                    <th>Location</th>
                                    <th>Email</th>
                                    <th>Action</th>

                                </tr>

                            </thead>


                            <tbody>

                            <% for (Company company : companies) { %>

                                <tr>

                                    <td>
                                        <%= company.getCompanyId() %>
                                    </td>

                                    <td>
                                        <%= company.getCompanyName() %>
                                    </td>

                                    <td>
                                        <%= company.getIndustry() %>
                                    </td>

                                    <td>
                                        <%= company.getLocation() %>
                                    </td>

                                    <td>
                                        <%= company.getCompanyEmail() %>
                                    </td>
                                    <td>
    									<a href="viewCompany.jsp?companyId=<%= company.getCompanyId() %>"
											       class="view-btn">
										        <i class="bi bi-eye"></i>
        												View
    									</a>
									</td>
                                </tr>

                            <% } %>

                            </tbody>

                        </table>

                    <% } %>

                </div>

            </div>



            <!-- ================================================= -->
            <!-- ================= OPPORTUNITIES ================= -->
            <!-- ================================================= -->

            <div class="data-card">

                <div class="data-header">

                    <h3>

                        <i class="bi bi-briefcase-fill"></i>
                        All Opportunities

                    </h3>

                    <span class="count-badge">
                        <%= totalOpportunities %> Opportunities
                    </span>

                </div>


                <div class="table-wrapper">

                    <% if (opportunities.isEmpty()) { %>

                        <div class="empty-data">

                            <i class="bi bi-briefcase"></i>

                            No opportunities found.

                        </div>

                    <% } else { %>

                        <table class="admin-table">

                            <thead>

                                <tr>

                                    <th>ID</th>
                                    <th>Title</th>
                                    <th>Company</th>
                                    <th>Type</th>
                                    <th>Location</th>
                                    <th>Posted Date</th>
                                    <th>Action</th>

                                </tr>

                            </thead>


                            <tbody>

                            <% for (Opportunity opportunity : opportunities) { %>

                                <tr>

                                    <td>
                                        <%= opportunity.getOppId() %>
                                    </td>

                                    <td>
                                        <%= opportunity.getTitle() %>
                                    </td>

                                    <td>
                                        <%= opportunity.getCompanyName() %>
                                    </td>

                                    <td>
                                        <%= opportunity.getType() %>
                                    </td>

                                    <td>
                                        <%= opportunity.getLocation() %>
                                    </td>

                                    <td>
                                        <%= opportunity.getPostedDate() %>
                                    </td>
                                    <td>
    <div class="action-buttons">

        <a href="viewOpportunity.jsp?oppId=<%= opportunity.getOppId() %>"
           class="view-btn">
            <i class="bi bi-eye"></i>
            View
        </a>

        <a href="editOpportunity.jsp?oppId=<%= opportunity.getOppId() %>"
           class="edit-btn">
            <i class="bi bi-pencil"></i>
            Edit
        </a>

    </div>
</td>
                                </tr>

                            <% } %>

                            </tbody>

                        </table>

                    <% } %>

                </div>

            </div>



            <!-- ================================================= -->
            <!-- ================= APPLICATIONS ================== -->
            <!-- ================================================= -->

            <div class="data-card">

                <div class="data-header">

                    <h3>

                        <i class="bi bi-file-earmark-check-fill"></i>
                        All Applications

                    </h3>

                    <span class="count-badge">
                        <%= totalApplications %> Applications
                    </span>

                </div>


                <div class="table-wrapper">

                    <% if (applications.isEmpty()) { %>

                        <div class="empty-data">

                            <i class="bi bi-file-earmark"></i>

                            No applications found.

                        </div>

                    <% } else { %>

                        <table class="admin-table">

                            <thead>

                                <tr>

                                    <th>ID</th>
                                    <th>Student</th>
                                    <th>Opportunity</th>
                                    <th>Company</th>
                                    <th>Status</th>
                                    <th>Applied Date</th>
                                    <th>Action</th>
                                </tr>

                            </thead>


                            <tbody>

                            <% for (Application app : applications) {

                                String status = app.getStatus();

                                String statusClass = "status-pending";

                                if ("ACCEPTED".equalsIgnoreCase(status)) {

                                    statusClass = "status-accepted";

                                } else if ("REJECTED".equalsIgnoreCase(status)) {

                                    statusClass = "status-rejected";

                                }

                            %>

                                <tr>

                                    <td>
                                        <%= app.getAppId() %>
                                    </td>

                                    <td>
                                        <%= app.getStudentName() %>
                                    </td>

                                    <td>
                                        <%= app.getOpportunityTitle() %>
                                    </td>

                                    <td>
                                        <%= app.getCompanyName() %>
                                    </td>

                                    <td>

                                        <span class="status-badge <%= statusClass %>">
                                            <%= status %>
                                        </span>

                                    </td>

                                    <td>
                                        <%= app.getAppliedDate() %>
                                    </td>
                                    <td>
    <a href="viewApplication.jsp?appId=<%= app.getAppId() %>"
       class="view-btn">
        <i class="bi bi-eye"></i>
        View
    </a>
</td>

                                </tr>

                            <% } %>

                            </tbody>

                        </table>

                    <% } %>

                </div>

            </div>


        </div>

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
