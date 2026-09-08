<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.campusconnect.model.User" %>
<%@ page import="com.campusconnect.model.Company" %>
<%@ page import="com.campusconnect.dao.CompanyDAO" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    String companyIdParam = request.getParameter("companyId");

    if (companyIdParam == null || companyIdParam.trim().isEmpty()) {
        response.sendRedirect("adminDashboard.jsp");
        return;
    }

    int companyId;

    try {
        companyId = Integer.parseInt(companyIdParam);
    } catch (NumberFormatException e) {
        response.sendRedirect("adminDashboard.jsp");
        return;
    }

    CompanyDAO companyDAO = new CompanyDAO();
    Company company = companyDAO.getCompanyById(companyId);
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        <%= company != null ? company.getCompanyName() : "Company Not Found" %>
        | CampusConnect
    </title>

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #071426;
            color: #f5f1e8;
            font-family: "Segoe UI", Arial, sans-serif;
        }

        .navbar-custom {
            background: #071426;
            border-bottom: 1px solid rgba(214,173,82,.18);
            padding: 20px 0;
        }

        .navbar-container {
            max-width: 1200px;
            margin: auto;
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

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #d6ad52;
            padding: 10px 14px;
            border: 1px solid rgba(214,173,82,.25);
            border-radius: 10px;
            background: transparent;
            cursor: pointer;
            font-weight: 700;
            text-decoration: none;
            transition: .3s ease;
        }

        .back-btn:hover {
            color: #071426;
            background: #d6ad52;
            border-color: #d6ad52;
        }

        .brand {
            color: #f5f1e8;
            text-decoration: none;
            font-size: 24px;
            font-weight: 750;
        }

        .brand i {
            color: #d6ad52;
            margin-right: 8px;
        }

        .navbar-right {
            color: #b8c0cb;
            font-weight: 600;
        }

        .page {
            padding: 70px 20px 90px;
        }

        .page-container {
            max-width: 1000px;
            margin: auto;
        }

        .page-label {
            color: #d6ad52;
            font-size: 13px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .page-title {
            font-size: 42px;
            font-weight: 800;
            margin-top: 12px;
        }

        .company-card {
            margin-top: 40px;
            background: linear-gradient(
                145deg,
                rgba(255,255,255,.045),
                rgba(255,255,255,.015)
            );
            border: 1px solid rgba(255,255,255,.09);
            border-radius: 18px;
            overflow: hidden;
        }

        .company-header {
            padding: 30px;
            border-bottom: 1px solid rgba(255,255,255,.08);
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .company-icon {
            width: 65px;
            height: 65px;
            border-radius: 15px;
            background: rgba(214,173,82,.10);
            border: 1px solid rgba(214,173,82,.25);
            color: #d6ad52;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }

        .company-header h2 {
            margin: 0;
            font-size: 27px;
            font-weight: 750;
        }

        .company-header p {
            margin: 5px 0 0;
            color: #8d98a6;
            font-size: 14px;
        }

        .details {
            padding: 30px;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 22px;
        }

        .detail-item {
            padding: 18px;
            border: 1px solid rgba(255,255,255,.07);
            border-radius: 12px;
            background: rgba(255,255,255,.018);
        }

        .detail-item.full {
            grid-column: 1 / -1;
        }

        .detail-label {
            color: #8d98a6;
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: .7px;
            font-weight: 700;
            margin-bottom: 7px;
        }

        .detail-value {
            color: #f5f1e8;
            font-size: 15px;
            line-height: 1.6;
            word-break: break-word;
        }

        .detail-value a {
            color: #d6ad52;
            text-decoration: none;
        }

        .detail-value a:hover {
            text-decoration: underline;
        }

        .empty-value {
            color: #707b89;
        }

        .not-found {
            max-width: 600px;
            margin: 120px auto;
            text-align: center;
            padding: 20px;
        }

        .not-found i {
            font-size: 60px;
            color: #d6ad52;
        }

        .not-found h2 {
            margin-top: 20px;
        }

        .not-found p {
            color: #8d98a6;
        }

        footer {
            background: #050f1c;
            border-top: 1px solid rgba(255,255,255,.06);
            padding: 28px 0;
            color: #707b89;
        }

        @media (max-width: 700px) {

            .navbar-left {
                gap: 10px;
            }

            .brand {
                font-size: 20px;
            }

            .page-title {
                font-size: 34px;
            }

            .details {
                grid-template-columns: 1fr;
            }

            .detail-item.full {
                grid-column: auto;
            }

        }

    </style>

</head>

<body>

<nav class="navbar-custom">

    <div class="navbar-container">

        <div class="navbar-left">

            <button
                type="button"
                class="back-btn"
                onclick="history.back();">

                <i class="bi bi-arrow-left"></i>
                Back

            </button>

            <a href="<%= request.getContextPath() %>/adminDashboard.jsp"
               class="brand">

                <i class="bi bi-mortarboard-fill"></i>
                CampusConnect

            </a>

        </div>

        <div class="navbar-right">

            <i class="bi bi-shield-check"></i>

            <%= user.getName() %>

        </div>

    </div>

</nav>


<% if (company == null) { %>

    <div class="not-found">

        <i class="bi bi-building-x"></i>

        <h2>Company Not Found</h2>

        <p>
            The requested company profile could not be found.
        </p>

        <a
            href="<%= request.getContextPath() %>/adminDashboard.jsp"
            class="back-btn">

            <i class="bi bi-arrow-left"></i>
            Back to Dashboard

        </a>

    </div>

<% } else { %>


<section class="page">

    <div class="page-container">

        <div class="page-label">
            Administration
        </div>

        <h1 class="page-title">
            Company Details
        </h1>


        <div class="company-card">

            <div class="company-header">

                <div class="company-icon">

                    <i class="bi bi-building-fill"></i>

                </div>

                <div>

                    <h2>
                        <%= company.getCompanyName() %>
                    </h2>

                    <p>
                        Company ID:
                        <%= company.getCompanyId() %>
                    </p>

                </div>

            </div>


            <div class="details">


                <div class="detail-item">

                    <div class="detail-label">
                        Industry
                    </div>

                    <div class="detail-value">

                        <% if (company.getIndustry() != null &&
                               !company.getIndustry().trim().isEmpty()) { %>

                            <%= company.getIndustry() %>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>


                <div class="detail-item">

                    <div class="detail-label">
                        Location
                    </div>

                    <div class="detail-value">

                        <% if (company.getLocation() != null &&
                               !company.getLocation().trim().isEmpty()) { %>

                            <%= company.getLocation() %>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>


                <div class="detail-item">

                    <div class="detail-label">
                        Company Email
                    </div>

                    <div class="detail-value">

                        <% if (company.getCompanyEmail() != null &&
                               !company.getCompanyEmail().trim().isEmpty()) { %>

                            <%= company.getCompanyEmail() %>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>


                <div class="detail-item">

                    <div class="detail-label">
                        Contact Number
                    </div>

                    <div class="detail-value">

                        <% if (company.getContactNumber() != null &&
                               !company.getContactNumber().trim().isEmpty()) { %>

                            <%= company.getContactNumber() %>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>


                <div class="detail-item">

                    <div class="detail-label">
                        Website
                    </div>

                    <div class="detail-value">

                        <% if (company.getWebsite() != null &&
                               !company.getWebsite().trim().isEmpty()) { %>

                            <a href="<%= company.getWebsite() %>"
                               target="_blank">

                                <%= company.getWebsite() %>

                            </a>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>


                <div class="detail-item">

                    <div class="detail-label">
                        LinkedIn
                    </div>

                    <div class="detail-value">

                        <% if (company.getLinkedinUrl() != null &&
                               !company.getLinkedinUrl().trim().isEmpty()) { %>

                            <a href="<%= company.getLinkedinUrl() %>"
                               target="_blank">

                                View LinkedIn Profile

                            </a>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>


                <div class="detail-item">

                    <div class="detail-label">
                        Founded Year
                    </div>

                    <div class="detail-value">

                        <% if (company.getFoundedYear() != null) { %>

                            <%= company.getFoundedYear() %>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>


                <div class="detail-item">

                    <div class="detail-label">
                        Company Size
                    </div>

                    <div class="detail-value">

                        <% if (company.getCompanySize() != null &&
                               !company.getCompanySize().trim().isEmpty()) { %>

                            <%= company.getCompanySize() %>

                        <% } else { %>

                            <span class="empty-value">
                                Not provided
                            </span>

                        <% } %>

                    </div>

                </div>


                <div class="detail-item full">

                    <div class="detail-label">
                        Description
                    </div>

                    <div class="detail-value">

                        <% if (company.getDescription() != null &&
                               !company.getDescription().trim().isEmpty()) { %>

                            <%= company.getDescription() %>

                        <% } else { %>

                            <span class="empty-value">
                                No description provided.
                            </span>

                        <% } %>

                    </div>

                </div>


                <div class="detail-item">

                    <div class="detail-label">
                        Registered User ID
                    </div>

                    <div class="detail-value">
                        <%= company.getUserId() %>
                    </div>

                </div>


                <div class="detail-item">

                    <div class="detail-label">
                        Logo
                    </div>

                    <div class="detail-value">

                        <% if (company.getLogoPath() != null &&
                               !company.getLogoPath().trim().isEmpty()) { %>

                            <%= company.getLogoPath() %>

                        <% } else { %>

                            <span class="empty-value">
                                No logo uploaded
                            </span>

                        <% } %>

                    </div>

                </div>


            </div>

        </div>

    </div>

</section>


<footer>

    <div class="container text-center">

        <small>
            © 2026 CampusConnect · Administration
        </small>

    </div>

</footer>


<% } %>

</body>

</html>