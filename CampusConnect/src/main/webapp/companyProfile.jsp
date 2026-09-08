<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.campusconnect.model.User" %>
<%@ page import="com.campusconnect.model.Company" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"COMPANY".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    Company company = (Company) request.getAttribute("company");

    String error = (String) request.getAttribute("error");
    String message = (String) request.getAttribute("message");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Company Profile | CampusConnect</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>
        /* ================= BACK BUTTON ================= */

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
        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            background: #071426;
            color: #f5f1e8;
            font-family: "Segoe UI", Arial, sans-serif;
        }
        .profile-message {
            max-width: 800px;
   			margin: 20px auto;
    		padding: 15px 20px;
    		border-radius: 10px;
    		background: #fff3cd;
    		color: #856404;
     		border: 1px solid #ffe69c;
    		font-weight: 600;
    		text-align: center;
    		box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}
        /* ================= NAVBAR ================= */

        .navbar-custom {
            background: #071426;
            border-bottom: 1px solid rgba(255,255,255,.08);
            padding: 18px 0;
        }

        .brand {
            color: #f5f1e8;
            text-decoration: none;
            font-size: 23px;
            font-weight: 800;
        }

        .brand i {
            color: #d6ad52;
            margin-right: 7px;
        }

        .nav-link {
            color: #b8c0cb !important;
            font-size: 14px;
            font-weight: 600;
            margin-left: 12px;
        }

        .nav-link:hover {
            color: #f0ca70 !important;
        }

        /* ================= LOGOUT ================= */

.logout-link {
    color: #d6ad52 !important;

    font-size: 14px;
    font-weight: 700;

    margin-left: 14px;

    padding: 10px 14px !important;

    border: 1px solid rgba(214,173,82,.25);

    border-radius: 10px;

    background: transparent;

    transition: .3s ease;
}

.logout-link i {
    margin-right: 5px;
}

.logout-link:hover {
    color: #071426 !important;

    background: #d6ad52 !important;

    border-color: #d6ad52;

    box-shadow:
        0 0 10px rgba(214,173,82,.35),
        0 0 25px rgba(214,173,82,.15);

    transform: translateY(-2px);
}

.logout-link:hover i {
    color: #071426;
    text-shadow: none;
}

        /* ================= PAGE ================= */

        .profile-section {
            padding: 65px 15px 80px;
        }

        .profile-header {
            text-align: center;
            margin-bottom: 45px;
        }

        .profile-label {
            color: #d6ad52;
            font-size: 12px;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .profile-header h1 {
            font-size: 40px;
            font-weight: 800;
            margin-top: 12px;
        }

        .profile-header p {
            color: #aeb7c3;
            margin-top: 10px;
        }

        /* ================= CARD ================= */

        .profile-card {
            max-width: 900px;
            margin: auto;
            padding: 40px;
            background: linear-gradient(
                145deg,
                rgba(255,255,255,.06),
                rgba(255,255,255,.025)
            );
            border: 1px solid rgba(214,173,82,.22);
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,.25);
        }

        .section-heading {
            color: #f0ca70;
            font-size: 18px;
            font-weight: 700;
            margin-bottom: 22px;
        }

        .form-label {
            color: #d7dce2;
            font-size: 14px;
            font-weight: 600;
        }

        .form-control,
        .form-select {
            background: rgba(255,255,255,.05);
            border: 1px solid rgba(255,255,255,.12);
            color: #f5f1e8;
            border-radius: 10px;
            padding: 12px 14px;
        }

        .form-control:focus,
        .form-select:focus {
            background: rgba(255,255,255,.07);
            color: #fff;
            border-color: #d6ad52;
            box-shadow: 0 0 0 3px rgba(214,173,82,.12);
        }

        .form-control::placeholder {
            color: #788494;
        }

        textarea.form-control {
            min-height: 130px;
            resize: vertical;
        }

        .form-select option {
            background: #071426;
            color: white;
        }

        /* ================= BUTTON ================= */

        .btn-gold {
            background: #d6ad52;
            border: none;
            color: #071426;
            font-weight: 800;
            border-radius: 10px;
            padding: 12px 25px;
            transition: .3s ease;
        }

        .btn-gold:hover {
            background: #f0ca70;
            color: #071426;
            transform: translateY(-2px);
            box-shadow: 0 0 20px rgba(214,173,82,.35);
        }

        /* ================= ALERT ================= */

        .alert {
            max-width: 900px;
            margin: 0 auto 25px;
            border-radius: 10px;
        }

        /* ================= FOOTER ================= */

        footer {
            border-top: 1px solid rgba(255,255,255,.08);
            padding: 25px 0;
            color: #7f8a98;
        }

        @media(max-width: 768px) {

            .profile-section {
                padding: 45px 15px 60px;
            }

            .profile-card {
                padding: 25px;
            }

            .profile-header h1 {
                font-size: 32px;
            }
            
        }

    </style>

</head>

<body>

<%
    String profileMessage = (String) session.getAttribute("profileMessage");

    if (profileMessage != null) {
%>

<div class="profile-message">
    <%= profileMessage %>
</div>

<%
        session.removeAttribute("profileMessage");
    }
%>
<!-- =====================================================
     NAVBAR
===================================================== -->

<nav class="navbar navbar-expand-lg navbar-custom">

<div class="container">

    <!-- BACK BUTTON + BRAND -->
    <div class="d-flex align-items-center gap-3">

        <button type="button"
                class="back-btn"
                onclick="history.back()">

            <i class="bi bi-arrow-left"></i>
            Back

        </button>

        <a class="brand"
           href="<%= request.getContextPath() %>/companyDashboard">

            <i class="bi bi-mortarboard-fill"></i>
            CampusConnect

        </a>

    </div>


    <!-- MOBILE BUTTON -->
    <button class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#companyNav"
            aria-controls="companyNav"
            aria-expanded="false"
            aria-label="Toggle navigation">

        <i class="bi bi-list"></i>

    </button>


    <!-- NAVIGATION -->
    <div class="collapse navbar-collapse"
         id="companyNav">

        <ul class="navbar-nav ms-auto align-items-lg-center">


            <!-- DASHBOARD -->
            <li class="nav-item">

                <a class="nav-link custom-link active"
                   href="<%= request.getContextPath() %>/companyDashboard">

                    <i class="bi bi-grid"></i>
                    Dashboard

                </a>

            </li>


            <!-- POST OPPORTUNITY -->
            <li class="nav-item">

                <a class="nav-link custom-link"
                   href="<%= request.getContextPath() %>/postJob.jsp">

                    <i class="bi bi-plus-circle"></i>
                    Post Opportunity

                </a>

            </li>


            <!-- MY POSTINGS -->
            <li class="nav-item">

                <a class="nav-link custom-link"
                   href="<%= request.getContextPath() %>/companyDashboard#postings">

                    <i class="bi bi-briefcase"></i>
                    My Postings

                </a>

            </li>


            <!-- APPLICANTS -->
            <li class="nav-item">

                <a class="nav-link custom-link"
                   href="<%= request.getContextPath() %>/companyapplications">

                    <i class="bi bi-people"></i>
                    Applicants

                </a>

            </li>


            <!-- COMPANY NAME / PROFILE -->
            <li class="nav-item">

                <a class="nav-link custom-link company-name"
                   href="<%= request.getContextPath() %>/companyProfile">

                    <i class="bi bi-building"></i>
                    <%= user.getName() %>

                </a>

            </li>


            <!-- LOGOUT -->
            <li class="nav-item">

                <a class="nav-link logout-link"
                   href="<%= request.getContextPath() %>/logout">

                    <i class="bi bi-box-arrow-right"></i>
                    Logout

                </a>

            </li>


        </ul>

    </div>

</div>

</nav>



<!-- ================= PROFILE ================= -->

<section class="profile-section">

    <div class="container">

        <div class="profile-header">

            <div class="profile-label">
                Company Profile
            </div>

            <h1>
                Build your company presence
            </h1>

            <p>
                Students will see this information when viewing
                your opportunities.
            </p>

        </div>


        <% if (error != null) { %>

            <div class="alert alert-danger">
                <i class="bi bi-exclamation-circle-fill me-2"></i>
                <%= error %>
            </div>

        <% } %>


        <% if (message != null) { %>

            <div class="alert alert-success">
                <i class="bi bi-check-circle-fill me-2"></i>
                <%= message %>
            </div>

        <% } %>


        <div class="profile-card">

            <form action="<%= request.getContextPath() %>/companyProfile"
                  method="post">

                <!-- COMPANY INFORMATION -->

                <div class="section-heading">

                    <i class="bi bi-building me-2"></i>
                    Company Information

                </div>

                <div class="row g-4">

                    <div class="col-md-6">

                        <label class="form-label">
                            Company Name *
                        </label>

                        <input type="text"
                               name="companyName"
                               class="form-control"
                               value="<%= company != null && company.getCompanyName() != null
                                       ? company.getCompanyName() : "" %>"
                               placeholder="e.g. ABC Technologies"
                               required>

                    </div>


                    <div class="col-md-6">

                        <label class="form-label">
                            Industry *
                        </label>

                        <input type="text"
                               name="industry"
                               class="form-control"
                               value="<%= company != null && company.getIndustry() != null
                                       ? company.getIndustry() : "" %>"
                               placeholder="e.g. Information Technology"
                               required>

                    </div>


                    <div class="col-md-6">

                        <label class="form-label">
                            Location *
                        </label>

                        <input type="text"
                               name="location"
                               class="form-control"
                               value="<%= company != null && company.getLocation() != null
                                       ? company.getLocation() : "" %>"
                               placeholder="e.g. Kolkata, India"
                               required>

                    </div>


                    <div class="col-md-6">

                        <label class="form-label">
                            Company Size
                        </label>

                        <select name="companySize"
                                class="form-select">

                            <option value="">
                                Select company size
                            </option>

                            <option value="1-10"
                                <%= company != null && "1-10".equals(company.getCompanySize()) ? "selected" : "" %>>
                                1-10 employees
                            </option>

                            <option value="11-50"
                                <%= company != null && "11-50".equals(company.getCompanySize()) ? "selected" : "" %>>
                                11-50 employees
                            </option>

                            <option value="51-200"
                                <%= company != null && "51-200".equals(company.getCompanySize()) ? "selected" : "" %>>
                                51-200 employees
                            </option>

                            <option value="201-500"
                                <%= company != null && "201-500".equals(company.getCompanySize()) ? "selected" : "" %>>
                                201-500 employees
                            </option>

                            <option value="500+"
                                <%= company != null && "500+".equals(company.getCompanySize()) ? "selected" : "" %>>
                                500+ employees
                            </option>

                        </select>

                    </div>


                    <div class="col-12">

                        <label class="form-label">
                            About Company *
                        </label>

                        <textarea name="description"
                                  class="form-control"
                                  placeholder="Tell students about your company..."
                                  required><%= company != null && company.getDescription() != null
                                          ? company.getDescription() : "" %></textarea>

                    </div>

                </div>


                <hr class="border-secondary my-5">


                <!-- CONTACT INFORMATION -->

                <div class="section-heading">

                    <i class="bi bi-person-lines-fill me-2"></i>
                    Contact Information

                </div>


                <div class="row g-4">

                    <div class="col-md-6">

                        <label class="form-label">
                            Company Email
                        </label>

                        <input type="email"
                               name="companyEmail"
                               class="form-control"
                               value="<%= company != null && company.getCompanyEmail() != null
                                       ? company.getCompanyEmail() : "" %>"
                               placeholder="hr@company.com">

                    </div>


                    <div class="col-md-6">

                        <label class="form-label">
                            Contact Number
                        </label>

                        <input type="tel"
                               name="contactNumber"
                               class="form-control"
                               value="<%= company != null && company.getContactNumber() != null
                                       ? company.getContactNumber() : "" %>"
                               placeholder="+91 XXXXX XXXXX">

                    </div>


                    <div class="col-md-6">

                        <label class="form-label">
                            Website
                        </label>

                        <input type="url"
                               name="website"
                               class="form-control"
                               value="<%= company != null && company.getWebsite() != null
                                       ? company.getWebsite() : "" %>"
                               placeholder="https://example.com">

                    </div>


                    <div class="col-md-6">

                        <label class="form-label">
                            LinkedIn
                        </label>

                        <input type="url"
                               name="linkedinUrl"
                               class="form-control"
                               value="<%= company != null && company.getLinkedinUrl() != null
                                       ? company.getLinkedinUrl() : "" %>"
                               placeholder="https://linkedin.com/company/...">

                    </div>


                    <div class="col-md-6">

                        <label class="form-label">
                            Founded Year
                        </label>

                        <input type="number"
                               name="foundedYear"
                               class="form-control"
                               value="<%= company != null && company.getFoundedYear() != null
                                       ? company.getFoundedYear() : "" %>"
                               placeholder="e.g. 2015"
                               min="1800"
                               max="2026">

                    </div>

                </div>


                <div class="text-end mt-5">

                    <button type="submit"
                            class="btn-gold">

                        <i class="bi bi-check-circle me-2"></i>
                        Save Company Profile

                    </button>

                </div>

            </form>

        </div>

    </div>

</section>


<footer>

    <div class="container text-center">

        <small>
            © 2026 CampusConnect · Connecting students with companies.
        </small>

    </div>

</footer>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>