<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>
<%@ page import="com.campusconnect.model.User" %>
<%@ page import="com.campusconnect.model.Application" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"COMPANY".equals(user.getRole())) {
        response.sendRedirect(
            request.getContextPath() + "/login.jsp"
        );
        return;
    }

    List<Application> applications =
        (List<Application>) request.getAttribute("applications");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>View Applicants | CampusConnect</title>

    <!-- Bootstrap -->
    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link
        rel="stylesheet"
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


        /* ================= NAVBAR ================= */

        .navbar-custom {
            background: #071426;
            border-bottom: 1px solid rgba(255,255,255,.06);
            padding: 18px 0;
        }

        .brand {
            color: #f5f1e8;
            text-decoration: none;
            font-size: 23px;
            font-weight: 800;
            letter-spacing: -.5px;
        }

        .brand i {
            color: #d6ad52;
            margin-right: 8px;
        }

        .brand:hover {
            color: #f5f1e8;
        }


        /* NORMAL NAV LINKS */

        .custom-link {
            position: relative;
            color: #b8c0cb !important;
            font-size: 14px;
            font-weight: 600;
            margin-left: 10px;
            padding: 10px 8px !important;

            background: transparent !important;
            border: none !important;
            border-radius: 0 !important;
            box-shadow: none !important;

            transition: color .3s ease;
        }

        .custom-link i {
            color: #d6ad52;
            margin-right: 5px;

            transition:
                color .3s ease,
                text-shadow .3s ease;
        }

        .custom-link:hover {
            color: #f5f1e8 !important;
            background: transparent !important;
            box-shadow: none !important;
            transform: none !important;
        }

        .custom-link:hover i {
            color: #f0ca70;

            text-shadow:
                0 0 8px rgba(214,173,82,.7);
        }


        /* GOLD UNDERLINE */

        .custom-link::after {
            content: "";

            position: absolute;

            left: 50%;
            bottom: 4px;

            width: 0;
            height: 2px;

            background: #d6ad52;

            transform: translateX(-50%);

            border-radius: 5px;

            box-shadow:
                0 0 7px rgba(214,173,82,.7);

            transition: width .3s ease;
        }

        .custom-link:hover::after {
            width: 55%;
        }


        /* ACTIVE LINK */

        .custom-link.active {
            color: #f5f1e8 !important;
            background: transparent !important;
            box-shadow: none !important;
        }

        .custom-link.active::after {
            width: 55%;
        }

        .custom-link.active i {
            color: #f0ca70;

            text-shadow:
                0 0 8px rgba(214,173,82,.7);
        }


        /* COMPANY NAME */

        .company-name {
            cursor: default;
            color: #b8c0cb !important;
        }

        .company-name i {
            color: #d6ad52;
        }


        /* LOGOUT */

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


        /* NAVBAR TOGGLER */

        .navbar-toggler {
            border: 1px solid rgba(214,173,82,.35);

            border-radius: 8px;

            padding: 7px 10px;

            color: #d6ad52;

            background: transparent;
        }

        .navbar-toggler i {
            color: #d6ad52;
            font-size: 22px;
        }

        .navbar-toggler:focus {
            box-shadow: none;
        }


        /* ================= PAGE ================= */

        .page {
            padding: 65px 15px 90px;

            min-height:
                calc(100vh - 80px);
        }

        .page-header {
            margin-bottom: 35px;
        }

        .page-label {
            color: #d6ad52;

            font-size: 13px;

            font-weight: 700;

            letter-spacing: 2px;

            text-transform: uppercase;
        }

        .page-header h1 {
            font-size: 42px;

            font-weight: 800;

            margin-top: 10px;

            margin-bottom: 10px;
        }

        .page-header p {
            color: #8d98a6;

            font-size: 16px;
        }


        /* ================= APPLICATION CARD ================= */

        .application-card {
            background:
                linear-gradient(
                    145deg,
                    rgba(255,255,255,.045),
                    rgba(255,255,255,.015)
                );

            border: 1px solid rgba(255,255,255,.09);

            border-radius: 18px;

            padding: 28px;

            margin-bottom: 20px;

            transition: all .3s ease;
        }

        .application-card:hover {
            transform: translateY(-5px);

            border-color:
                rgba(214,173,82,.45);

            box-shadow:
                0 0 15px rgba(214,173,82,.10),
                0 20px 45px rgba(0,0,0,.25);
        }


        /* APPLICATION ICON */

        .application-icon {
            width: 55px;
            height: 55px;

            border-radius: 14px;

            display: flex;

            align-items: center;
            justify-content: center;

            background:
                rgba(214,173,82,.10);

            border:
                1px solid rgba(214,173,82,.25);

            color: #d6ad52;

            font-size: 24px;

            margin-bottom: 18px;
        }


        .application-card h4 {
            font-size: 20px;

            font-weight: 700;

            margin-bottom: 15px;
        }

        .application-card p {
            color: #8d98a6;

            margin-bottom: 8px;
        }

        .application-card strong {
            color: #dce1e7;
        }


        /* ================= STATUS ================= */

        .status {
            display: inline-flex;

            align-items: center;

            padding: 7px 13px;

            border-radius: 8px;

            background:
                rgba(214,173,82,.10);

            border:
                1px solid rgba(214,173,82,.25);

            color: #d6ad52;

            font-size: 12px;

            font-weight: 750;

            box-shadow:
                0 0 7px rgba(214,173,82,.12);
        }


        /* ================= BUTTONS ================= */

        .btn-success,
        .btn-danger {
            border-radius: 8px;

            font-weight: 600;

            padding: 8px 15px;

            transition: .25s ease;
        }

        .btn-success:hover,
        .btn-danger:hover {
            transform: translateY(-2px);
        }


        /* ================= EMPTY ================= */

        .empty-box {
            text-align: center;

            padding: 70px 20px;

            background:
                linear-gradient(
                    145deg,
                    rgba(255,255,255,.045),
                    rgba(255,255,255,.015)
                );

            border:
                1px solid rgba(255,255,255,.09);

            border-radius: 18px;
        }

        .empty-box i {
            font-size: 50px;

            color: #d6ad52;

            margin-bottom: 20px;
        }

        .empty-box h3 {
            font-weight: 700;
        }

        .empty-box p {
            color: #8d98a6;
        }


        /* ================= ERROR ================= */

        .error-box {
            padding: 18px;

            border-radius: 10px;

            background:
                rgba(214,173,82,.08);

            border:
                1px solid rgba(214,173,82,.25);

            color: #d6ad52;

            margin-bottom: 25px;
        }


        /* ================= RESPONSIVE ================= */

        @media (max-width: 991px) {

            .navbar-collapse {
                margin-top: 15px;

                padding: 10px 0;

                background: transparent;

                border: none;

                border-radius: 0;

                box-shadow: none;
            }

            .navbar-nav {
                align-items: flex-start !important;
            }

            .custom-link {
                margin-left: 0;

                padding-left: 0 !important;
            }

            .logout-link {
                display: inline-block;

                margin-left: 0;

                margin-top: 8px;
            }
        }


        @media (max-width: 768px) {

            .navbar-custom {
                padding: 16px 15px;
            }

            .brand {
                font-size: 21px;
            }

            .page {
                padding: 50px 15px 70px;
            }

            .page-header h1 {
                font-size: 34px;
            }

            .application-card {
                padding: 24px;
            }
        }


        @media (max-width: 480px) {

            .brand {
                font-size: 19px;
            }

            .brand i {
                margin-right: 5px;
            }

            .page {
                padding: 45px 12px 60px;
            }

            .page-header h1 {
                font-size: 30px;
            }

            .application-card {
                padding: 22px;

                border-radius: 15px;
            }
        }

    </style>

</head>


<body>


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



<!-- ================= PAGE ================= -->

<section class="page">

    <div class="container">


        <!-- HEADER -->

        <div class="page-header">

            <div class="page-label">
                Company Dashboard
            </div>

            <h1>
                View Applicants
            </h1>

            <p>
                Review students who have applied
                to your opportunities.
            </p>

        </div>


        <!-- ERROR -->

        <% if (request.getAttribute("error") != null) { %>

            <div class="error-box">

                <i class="bi bi-exclamation-circle me-2"></i>

                <%= request.getAttribute("error") %>

            </div>

        <% } %>



        <!-- APPLICATIONS -->

        <%
            if (applications != null && !applications.isEmpty()) {

                for (Application app : applications) {
        %>


        <!-- APPLICATION CARD -->

        <div class="application-card">


            <div class="application-icon">

                <i class="bi bi-person-fill"></i>

            </div>


            <h4>
                <%= app.getStudentName() %>
            </h4>


            <p>
                <strong>Student ID:</strong>
                <%= app.getStudentId() %>
            </p>


            <p>
                <strong>Opportunity ID:</strong>
                <%= app.getOppId() %>
            </p>


            <p>
                <strong>Application ID:</strong>
                <%= app.getAppId() %>
            </p>


            <p>
                <strong>Applied Date:</strong>
                <%= app.getAppliedDate() %>
            </p>

            <!-- STUDENT PROFILE -->

<p>
    <strong>Skills:</strong>
    <%= app.getSkills() != null && !app.getSkills().trim().isEmpty()
            ? app.getSkills()
            : "Not provided" %>
</p>

<p>
    <strong>Education:</strong>
    <%= app.getEducation() != null && !app.getEducation().trim().isEmpty()
            ? app.getEducation()
            : "Not provided" %>
</p>

<!-- RESUME -->

<p>
    <strong>Resume:</strong>

    <% if (app.getResumePath() != null
            && !app.getResumePath().trim().isEmpty()) { %>

        <a href="<%= request.getContextPath() %>/viewResume?appId=<%= app.getAppId() %>"
           target="_blank"
           class="btn btn-sm btn-outline-warning ms-2">

            <i class="bi bi-file-earmark-pdf"></i>
            View Resume

        </a>

    <% } else { %>

        <span class="text-secondary">
            Resume not uploaded
        </span>

    <% } %>
</p>
            <!-- STATUS -->

            <div class="mt-3">

                <span class="status">

                    <i class="bi bi-clock me-1"></i>

                    <%= app.getStatus() %>

                </span>

            </div>


            <!-- ACCEPT / REJECT -->

            <% if ("PENDING".equals(app.getStatus())) { %>

                <div class="mt-3 d-flex gap-2">

                    <!-- ACCEPT -->

                    <form action="<%= request.getContextPath() %>/applicationStatus"
                          method="post">

                        <input type="hidden"
                               name="appId"
                               value="<%= app.getAppId() %>">

                        <input type="hidden"
                               name="status"
                               value="ACCEPTED">

                        <button type="submit"
                                class="btn btn-success">

                            <i class="bi bi-check-circle"></i>

                            Accept

                        </button>

                    </form>


                    <!-- REJECT -->

                    <form action="<%= request.getContextPath() %>/applicationStatus"
                          method="post">

                        <input type="hidden"
                               name="appId"
                               value="<%= app.getAppId() %>">

                        <input type="hidden"
                               name="status"
                               value="REJECTED">

                        <button type="submit"
                                class="btn btn-danger">

                            <i class="bi bi-x-circle"></i>

                            Reject

                        </button>

                    </form>

                </div>

            <% } %>


        </div>


        <%
                }

            } else {
        %>


        <!-- NO APPLICATIONS -->

        <div class="empty-box">

            <i class="bi bi-people"></i>

            <h3>
                No applicants yet
            </h3>

            <p>
                Students who apply to your
                opportunities will appear here.
            </p>

        </div>


        <%
            }
        %>


    </div>

</section>



<!-- Bootstrap JS -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>