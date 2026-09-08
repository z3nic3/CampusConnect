<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.campusconnect.model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.campusconnect.dao.OpportunityDAO" %>
<%@ page import="com.campusconnect.model.Opportunity" %>
<%@ page import="com.campusconnect.dao.ApplicationDAO" %>
<%@ page import="com.campusconnect.model.Application" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"STUDENT".equals(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    OpportunityDAO opportunityDAO = new OpportunityDAO();
    List<Opportunity> opportunities = opportunityDAO.getAllOpportunities();

    ApplicationDAO applicationDAO = new ApplicationDAO();
    List<Application> applications =
            applicationDAO.getApplicationsByStudent(user.getUserId());

    String applyMessage = (String) session.getAttribute("applyMessage");
    session.removeAttribute("applyMessage");
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Student Dashboard | CampusConnect</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Bootstrap Icons -->
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
          html{
             scroll-behavior:smooth;
          }
          #opportunities;
          #applications;{
               scroll-margin-top:80px;
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
            transition: color .3s ease, text-shadow .3s ease;
        }

        .custom-link:hover {
            color: #f5f1e8 !important;
            background: transparent !important;
            box-shadow: none !important;
            transform: none !important;
        }

        .custom-link:hover i {
            color: #f0ca70;
            text-shadow: 0 0 8px rgba(214,173,82,.7);
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

            box-shadow: 0 0 7px rgba(214,173,82,.7);

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
            text-shadow: 0 0 8px rgba(214,173,82,.7);
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


        /* ================= HERO ================= */

        .hero {
            padding: 65px 0 60px;
            background:
                radial-gradient(
                    circle at 85% 15%,
                    rgba(214,173,82,.12),
                    transparent 32%
                ),
                #0a1a2e;
            border-bottom: 1px solid rgba(214,173,82,.09);
        }

        .hero-label {
            color: #d6ad52;
            font-size: 11px;
            font-weight: 800;
            letter-spacing: 2px;
            text-transform: uppercase;
        }

        .hero h1 {
            margin: 14px 0 12px;
            color: #f5f1e8;
            font-size: clamp(32px, 5vw, 48px);
            font-weight: 800;
            letter-spacing: -1.8px;
        }

        .hero h1 span {
            color: #d6ad52;
        }

        .hero p {
            max-width: 600px;
            margin: 0;
            color: #8d98a6;
            font-size: 14px;
            line-height: 1.7;
        }

        /* ================= DASHBOARD ================= */

        .dashboard {
            padding: 70px 0 90px;
        }

        .section-title {
            font-size: 32px;
            font-weight: 750;
        }


        /* ================= CARDS ================= */

        .feature-card {
            height: 100%;
            min-height: 300px;

            background:
                linear-gradient(
                    145deg,
                    rgba(255,255,255,.045),
                    rgba(255,255,255,.015)
                );

            border: 1px solid rgba(255,255,255,.09);
            border-radius: 18px;

            padding: 32px;

            transition: .3s;
        }

        .feature-card:hover {
            transform: translateY(-7px);

            border-color: rgba(214,173,82,.45);

            box-shadow:
                0 20px 45px rgba(0,0,0,.25);
        }


        /* ================= ICON ================= */

        .icon-box {
            width: 58px;
            height: 58px;

            border-radius: 15px;

            background: rgba(214,173,82,.10);
            border: 1px solid rgba(214,173,82,.25);

            color: #d6ad52;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 25px;

            margin-bottom: 25px;
        }

        .feature-card h4 {
            font-size: 21px;
            font-weight: 700;
        }

        .feature-card p {
            color: #8d98a6;
            line-height: 1.7;
        }


        /* ================= OPPORTUNITY TYPE ================= */

        .opportunity-type {
            display: inline-block;

            color: #d6ad52;

            background: rgba(214,173,82,.10);

            border: 1px solid rgba(214,173,82,.20);

            border-radius: 20px;

            padding: 6px 13px;

            font-size: 12px;
            font-weight: 700;

            text-transform: uppercase;
            letter-spacing: .5px;
        }


        /* ================= OPPORTUNITY INFO ================= */

        .opportunity-location {
            color: #b8c0cb;
            font-size: 14px;
            margin-top: 14px;
        }

        .opportunity-location i {
            color: #d6ad52;
            margin-right: 5px;
        }

        .posted-date {
            color: #707b89;
            font-size: 12px;
            margin-top: 6px;
        }

        .opportunity-description {
            color: #8d98a6;
            line-height: 1.6;
            margin-top: 18px;
            min-height: 70px;
        }

        .skills-title {
            color: #f5f1e8;
            font-size: 14px;
            font-weight: 700;
        }

        .skills {
            color: #d6ad52;
            font-size: 14px;
        }


        /* ================= APPLY BUTTON ================= */

        .apply-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;

            margin-top: 20px;

            padding: 11px 21px;

            border-radius: 9px;

            background: #d6ad52;
            color: #071426;

            text-decoration: none;

            font-weight: 750;
            font-size: 14px;

            border: 1px solid #d6ad52;

            transition:
                transform .25s ease,
                box-shadow .25s ease,
                background .25s ease;

            box-shadow:
                0 0 8px rgba(214,173,82,.35),
                0 0 18px rgba(214,173,82,.18);
        }

        .apply-btn:hover {
            background: #f0ca70;
            color: #071426;

            transform: translateY(-3px) scale(1.02);

            box-shadow:
                0 0 10px rgba(214,173,82,.65),
                0 0 25px rgba(214,173,82,.45),
                0 8px 25px rgba(214,173,82,.25);
        }

        .apply-btn:active {
            transform: translateY(-1px) scale(.98);

            box-shadow:
                0 0 8px rgba(214,173,82,.5);
        }

        .apply-btn:focus {
            outline: none;

            box-shadow:
                0 0 0 3px rgba(214,173,82,.20),
                0 0 18px rgba(214,173,82,.45);
        }


        /* ================= EMPTY STATE ================= */

        .empty-box {
            border: 1px dashed rgba(214,173,82,.25);

            border-radius: 18px;

            padding: 50px 20px;

            text-align: center;

            background: rgba(255,255,255,.02);
        }

        .empty-box i {
            font-size: 40px;
            color: #d6ad52;
            margin-bottom: 15px;
        }

        .empty-box h4 {
            font-weight: 700;
        }

        .empty-box p {
            color: #8d98a6;
        }


        /* ================= ALERT ================= */

        .alert {
            border-radius: 12px;
        }


        /* ================= FOOTER ================= */

        footer {
            background: #050f1c;

            border-top: 1px solid rgba(255,255,255,.06);

            padding: 28px 0;

            color: #707b89;
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
                padding: 16px 0;
            }

            .brand {
                font-size: 21px;
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

            .feature-card {
                min-height: 280px;
                padding: 27px;
            }

            .apply-btn {
                width: 100%;
                padding: 12px 18px;
                margin-top: 22px;
                font-size: 14px;
            }
        }


        /* SMALL MOBILE */

        @media (max-width: 480px) {

            .brand {
                font-size: 19px;
            }

            .brand i {
                margin-right: 5px;
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

            .feature-card {
                padding: 25px;
                border-radius: 15px;
            }

            .opportunity-description {
                min-height: auto;
            }
        }

    </style>

</head>


<body>

<!-- ================= NAVBAR ================= -->

<nav class="navbar-custom navbar navbar-expand-lg">

    <div class="container">


        <!-- ================= LEFT SIDE ================= -->

        <div class="d-flex align-items-center gap-3">


            <!-- BACK BUTTON -->

            <button type="button"
                    class="back-btn"
                    onclick="history.back()">

                <i class="bi bi-arrow-left"></i>

                Back

            </button>


            <!-- BRAND -->

            <a href="studentDashboard.jsp" class="brand">

                <i class="bi bi-mortarboard-fill"></i>

                CampusConnect

            </a>

        </div>


        <!-- ================= MOBILE MENU ================= -->

        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#studentNav"
                aria-controls="studentNav"
                aria-expanded="false"
                aria-label="Toggle navigation">

            <i class="bi bi-list"></i>

        </button>


        <!-- ================= NAVIGATION ================= -->

        <div class="collapse navbar-collapse" id="studentNav">

            <ul class="navbar-nav ms-auto align-items-lg-center">


                <!-- DASHBOARD -->

                <li class="nav-item">

                    <a class="nav-link custom-link active"
                       href="studentDashboard.jsp">

                        <i class="bi bi-grid"></i>

                        Dashboard

                    </a>

                </li>


                <!-- OPPORTUNITIES -->

                <li class="nav-item">

                    <a class="nav-link custom-link"
                       href="studentDashboard.jsp#opportunities">

                        <i class="bi bi-briefcase"></i>

                        Opportunities

                    </a>

                </li>


                <!-- MY APPLICATIONS -->

                <li class="nav-item">

                    <a class="nav-link custom-link"
                       href="studentDashboard.jsp#applications">

                        <i class="bi bi-file-earmark-text"></i>

                        My Applications

                    </a>

                </li>


                <!-- MY PROFILE -->

                <li class="nav-item">

                    <a class="nav-link custom-link"
                       href="<%= request.getContextPath() %>/studentProfile">

                        <i class="bi bi-person-circle"></i>

                        My Profile

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


    <!-- ================= SUCCESS MESSAGE ================= -->

    <%
        if (applyMessage != null) {
    %>

        <div class="container mt-4">

            <div class="alert alert-success alert-dismissible fade show"
                 role="alert">

                <i class="bi bi-check-circle-fill me-2"></i>

                <%= applyMessage %>

                <button type="button"
                        class="btn-close"
                        data-bs-dismiss="alert">
                </button>

            </div>

        </div>

    <%
        }
    %>



    <!-- ================= HERO ================= -->

    <section class="hero">

        <div class="container">

            <div class="hero-label">
                Student Dashboard
            </div>

            <h1 class="mt-3">

                Welcome,

                <span style="color:#d6ad52;">

                    <%= user.getName() %>.

                </span>

            </h1>

            <p class="mt-3 mb-0">

                Discover opportunities, connect with companies
                and take the next step in your career.

            </p>

        </div>

    </section>



    <!-- ================= OPPORTUNITIES ================= -->

    <section class="dashboard" id="opportunities">

        <div class="container">

            <h2 class="section-title mb-2">
                Latest Opportunities
            </h2>

            <p style="color:#8d98a6;" class="mb-4">

                Explore jobs and internships posted by companies
                on CampusConnect.

            </p>


            <div class="row g-4">

                <%

                    if (opportunities != null && !opportunities.isEmpty()) {

                        for (Opportunity opp : opportunities) {

                %>


                    <div class="col-md-6 col-lg-4 d-flex">

                        <div class="feature-card w-100">

                            <div class="company-name">

                                    <i class="bi bi-building"></i>

                                        <%= opp.getCompanyName() %>

                            </div>
                            <!-- TYPE -->

                            <span class="opportunity-type">

                                <%= opp.getType() %>

                            </span>


                            <!-- LOCATION -->

                            <div class="opportunity-location">

                                <i class="bi bi-geo-alt-fill"></i>

                                <%= opp.getLocation() %>

                            </div>


                            <!-- POSTED DATE -->

                            <div class="posted-date">

                                Posted:

                                <%= opp.getPostedDate() %>

                            </div>


                            <!-- DESCRIPTION -->

                            <p class="opportunity-description">

                                <%= opp.getDescription() %>

                            </p>


                            <!-- SKILLS -->

                            <div>

                                <span class="skills-title">
                                    Skills:
                                </span>

                                <span class="skills">

                                    <%= opp.getSkillRequired() %>

                                </span>

                            </div>


                            <!-- APPLY BUTTON -->

                            <form action="${pageContext.request.contextPath}/apply"
                                  method="post">

                                <input type="hidden"
                                       name="oppId"
                                       value="<%= opp.getOppId() %>">

                                <button type="submit"
                                        class="apply-btn border-0">

                                    Apply Now

                                    <i class="bi bi-arrow-right ms-1"></i>

                                </button>

                            </form>


                        </div>

                    </div>


                <%

                        }

                    } else {

                %>


                    <!-- EMPTY STATE -->

                    <div class="col-12">

                        <div class="empty-box">

                            <i class="bi bi-briefcase"></i>

                            <h4>
                                No opportunities available
                            </h4>

                            <p>

                                There are no jobs or internships
                                posted yet. Please check back later.

                            </p>

                        </div>

                    </div>


                <%

                    }

                %>

            </div>

        </div>

    </section>



    <!-- ================= MY APPLICATIONS ================= -->

    <section class="dashboard" id="applications">

        <div class="container">

            <h2 class="section-title mb-2">
                My Applications
            </h2>

            <p style="color:#8d98a6;" class="mb-4">

                Track the status of your job and internship applications.

            </p>


            <div class="row g-4">

                <%

                    if (applications != null && !applications.isEmpty()) {

                        for (Application app : applications) {

                            String status = app.getStatus();

                %>


                    <div class="col-md-6 col-lg-4 d-flex">

                        <div class="feature-card w-100">


                            <span class="opportunity-type">

                                Application

                            </span>


                            <div class="opportunity-location">

                                <i class="bi bi-briefcase-fill"></i>

                                Opportunity #<%= app.getOppId() %>

                            </div>


                            <div class="posted-date">

                                Applied:

                                <%= app.getAppliedDate() %>

                            </div>


                            <div class="mt-4">


                                <% if ("ACCEPTED".equals(status)) { %>

                                    <div class="alert alert-success mb-0">

                                        <i class="bi bi-check-circle-fill me-2"></i>

                                        <strong>
                                            Application Accepted
                                        </strong>

                                    </div>


                                <% } else if ("REJECTED".equals(status)) { %>

                                    <div class="alert alert-danger mb-0">

                                        <i class="bi bi-x-circle-fill me-2"></i>

                                        <strong>
                                            Application Rejected
                                        </strong>

                                    </div>


                                <% } else { %>

                                    <div class="alert alert-warning mb-0">

                                        <i class="bi bi-clock-fill me-2"></i>

                                        <strong>
                                            Application Pending
                                        </strong>

                                    </div>

                                <% } %>


                            </div>

                        </div>

                    </div>


                <%

                        }

                    } else {

                %>


                    <div class="col-12">

                        <div class="empty-box">

                            <i class="bi bi-file-earmark-text"></i>

                            <h4>
                                No applications yet
                            </h4>

                            <p>

                                Apply to an opportunity to see
                                your applications here.

                            </p>

                        </div>

                    </div>


                <%

                    }

                %>

            </div>

        </div>

    </section>



    <!-- ================= FOOTER ================= -->

<footer>

    <div class="container">

        <div class="d-flex justify-content-between
                    align-items-center flex-wrap gap-3">

            <a href="index.jsp" class="brand">

                <i class="bi bi-mortarboard-fill"></i>

                CampusConnect

            </a>


            <small>

                © 2026 CampusConnect · Connecting
                students with opportunities.

            </small>

        </div>

    </div>

</footer>




    <!-- Bootstrap JS -->

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
    </script>


</body>

</html>