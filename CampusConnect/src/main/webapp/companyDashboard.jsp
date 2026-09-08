<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.campusconnect.model.User" %>
<%@ page import="com.campusconnect.model.Company" %>
<%@ page import="com.campusconnect.model.Opportunity" %>
<%@ page import="java.util.List" %>

<%
User user = (User) session.getAttribute("user");
if (user == null || !"COMPANY".equals(user.getRole())) {
    response.sendRedirect(request.getContextPath() + "/login.jsp");
    return;
}

Company company = (Company) request.getAttribute("company");

List<Opportunity> opportunities =
        (List<Opportunity>) request.getAttribute("opportunities");

boolean profileCompleted = false;

if (company != null) {
    profileCompleted =
            company.getIndustry() != null &&
            !company.getIndustry().trim().isEmpty();
}


%>

<!DOCTYPE html>

<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Company Dashboard | CampusConnect</title>

<!-- Bootstrap -->
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">

<!-- Bootstrap Icons -->
<link
    rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">

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


    html {
        scroll-behavior: smooth;
    }

    body {
        margin: 0;
        background: #071426;
        color: #f5f1e8;
        font-family: "Segoe UI", Arial, sans-serif;
    }

    a {
        text-decoration: none;
    }


    /* =====================================================
       NAVBAR
    ===================================================== */

    .navbar-custom {
        background: #071426 !important;
        border-bottom: 1px solid rgba(255,255,255,.07);
        padding: 17px 0;
    }

    .brand {
        color: #f5f1e8 !important;
        font-size: 23px;
        font-weight: 800;
        letter-spacing: -.5px;
    }

    .brand i {
        color: #d6ad52;
        margin-right: 8px;
    }

    .custom-link {
        position: relative;
        color: #b8c0cb !important;
        font-size: 13px;
        font-weight: 600;
        margin-left: 12px;
        padding: 10px 8px !important;
        transition: .25s ease;
    }

    .custom-link i {
        color: #d6ad52;
        margin-right: 5px;
    }

    .custom-link:hover,
    .custom-link.active {
        color: #f5f1e8 !important;
    }

    .custom-link::after {
        content: "";
        position: absolute;
        left: 50%;
        bottom: 3px;
        width: 0;
        height: 2px;
        transform: translateX(-50%);
        background: #d6ad52;
        border-radius: 5px;
        box-shadow: 0 0 8px rgba(214,173,82,.7);
        transition: width .25s ease;
    }

    .custom-link:hover::after,
    .custom-link.active::after {
        width: 55%;
    }

    .company-name {
        color: #d6ad52 !important;
    }

    .company-name::after {
        display: none;
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

    .navbar-toggler {
        border: 1px solid rgba(214,173,82,.35);
        padding: 7px 10px;
        border-radius: 8px;
    }

    .navbar-toggler i {
        color: #d6ad52;
        font-size: 21px;
    }

    .navbar-toggler:focus {
        box-shadow: none;
    }


    /* =====================================================
       PROFILE STATUS
    ===================================================== */

    .profile-status-wrapper {
        background: #071426;
        padding: 20px 0 0;
    }

    .profile-status {
        width: 100%;
        display: flex;
        align-items: center;
        justify-content: space-between;
        gap: 20px;

        padding: 14px 18px;

        border-radius: 11px;

        font-size: 13px;
        line-height: 1.5;

        transition: .25s ease;
    }

    .profile-status-left {
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .profile-status-left i {
        font-size: 17px;
    }

    .profile-status a {
        white-space: nowrap;
        font-weight: 700;
        transition: .2s ease;
    }


    /* COMPLETED */

    .profile-status.completed {
        color: #a8d8b4;
        background: rgba(80,180,105,.08);
        border: 1px solid rgba(80,180,105,.20);
    }

    .profile-status.completed i {
        color: #78c98b;
    }

    .profile-status.completed a {
        color: #d6ad52;
    }

    .profile-status.completed a:hover {
        color: #ffffff;
    }


    /* INCOMPLETE */

    .profile-status.incomplete {
        color: #e7d7a5;
        background: rgba(214,173,82,.08);
        border: 1px solid rgba(214,173,82,.25);
    }

    .profile-status.incomplete i {
        color: #d6ad52;
    }

    .profile-status.incomplete a {
        color: #d6ad52;
    }

    .profile-status.incomplete a:hover {
        color: #ffffff;
    }


    /* =====================================================
       HERO
    ===================================================== */

    .hero {
        padding: 62px 0 58px;

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


    /* =====================================================
       DASHBOARD
    ===================================================== */

    .dashboard {
        padding: 55px 0 70px;
    }

    .section-title {
        color: #f5f1e8;
        font-size: 28px;
        font-weight: 800;
        letter-spacing: -.7px;
    }

    .section-subtitle {
        color: #8d98a6;
        font-size: 13px;
        margin: 7px 0 0;
    }


    /* =====================================================
       FEATURE CARDS
    ===================================================== */

    .feature-card {
        height: 100%;
        padding: 23px;

        border-radius: 14px;

        background:
            linear-gradient(
                145deg,
                rgba(255,255,255,.045),
                rgba(255,255,255,.012)
            );

        border: 1px solid rgba(255,255,255,.08);

        transition:
            transform .25s ease,
            border-color .25s ease,
            box-shadow .25s ease;
    }

    .feature-card:hover {
        transform: translateY(-4px);

        border-color: rgba(214,173,82,.4);

        box-shadow:
            0 0 14px rgba(214,173,82,.08),
            0 12px 30px rgba(0,0,0,.22);
    }

    .icon-box {
        width: 44px;
        height: 44px;

        display: flex;
        align-items: center;
        justify-content: center;

        margin-bottom: 18px;

        border-radius: 12px;

        color: #d6ad52;

        background: rgba(214,173,82,.09);

        border: 1px solid rgba(214,173,82,.22);

        font-size: 20px;
    }

    .feature-card h4 {
        color: #f5f1e8;
        font-size: 17px;
        font-weight: 700;
        margin-bottom: 9px;
    }

    .feature-card p {
        min-height: 48px;
        margin-bottom: 18px;

        color: #8d98a6;

        font-size: 12px;
        line-height: 1.65;
    }


    /* =====================================================
       BUTTON
    ===================================================== */

    .dashboard-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        gap: 6px;

        padding: 9px 14px;

        border-radius: 8px;

        color: #071426;

        background: #d6ad52;

        border: 1px solid #d6ad52;

        font-size: 12px;
        font-weight: 800;

        box-shadow:
            0 0 9px rgba(214,173,82,.2);

        transition: .25s ease;
    }

    .dashboard-btn:hover {
        color: #071426;

        background: #f0ca70;

        transform: translateY(-2px);

        box-shadow:
            0 0 12px rgba(214,173,82,.5),
            0 0 25px rgba(214,173,82,.18);
    }


    /* =====================================================
       POSTINGS
    ===================================================== */

    .postings-section {
        padding: 10px 0 90px;
        scroll-margin-top: 90px;
    }

    .postings-heading {
        display: flex;
        align-items: flex-end;
        justify-content: space-between;

        gap: 20px;

        margin-bottom: 25px;
    }

    .small-post-btn {
        display: inline-flex;
        align-items: center;
        justify-content: center;

        gap: 7px;

        padding: 9px 13px;

        border-radius: 8px;

        color: #d6ad52;

        border: 1px solid rgba(214,173,82,.3);

        font-size: 12px;
        font-weight: 700;

        white-space: nowrap;

        transition: .25s ease;
    }

    .small-post-btn:hover {
        color: #071426;

        background: #d6ad52;

        box-shadow:
            0 0 15px rgba(214,173,82,.25);
    }

    .postings-grid {
        display: grid;

        grid-template-columns:
            repeat(3, minmax(0, 1fr));

        gap: 17px;
    }


    /* =====================================================
       POSTING CARD
    ===================================================== */

    .posting-card {
        min-width: 0;

        padding: 20px;

        border-radius: 13px;

        background:
            linear-gradient(
                145deg,
                rgba(255,255,255,.045),
                rgba(255,255,255,.012)
            );

        border: 1px solid rgba(255,255,255,.08);

        transition:
            transform .25s ease,
            border-color .25s ease,
            box-shadow .25s ease;
    }

    .posting-card:hover {
        transform: translateY(-4px);

        border-color: rgba(214,173,82,.4);

        box-shadow:
            0 0 13px rgba(214,173,82,.08),
            0 12px 28px rgba(0,0,0,.2);
    }

    .posting-top {
        display: flex;
        align-items: center;
        justify-content: space-between;

        gap: 10px;
    }

    .opportunity-type {
        display: inline-block;

        max-width: 80%;

        padding: 5px 8px;

        border-radius: 20px;

        color: #d6ad52;

        background: rgba(214,173,82,.08);

        border: 1px solid rgba(214,173,82,.2);

        font-size: 9px;
        font-weight: 800;

        text-transform: uppercase;
        letter-spacing: .4px;

        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .posting-icon {
        color: #d6ad52;
        font-size: 16px;
    }

    .posting-title {
        color: #f5f1e8;

        font-size: 16px;
        font-weight: 700;

        line-height: 1.35;

        margin: 16px 0 8px;

        word-break: break-word;
    }

    .posting-location {
        color: #aab5c2;

        font-size: 11px;

        margin-bottom: 13px;
    }

    .posting-location i {
        color: #d6ad52;
        margin-right: 4px;
    }

    .posting-description {
        display: -webkit-box;

        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;

        overflow: hidden;

        min-height: 53px;

        margin: 0 0 18px;

        color: #8d98a6;

        font-size: 11px;
        line-height: 1.6;
    }

    .posting-bottom {
        display: flex;
        align-items: center;
        justify-content: space-between;

        gap: 8px;

        padding-top: 13px;

        border-top:
            1px solid rgba(255,255,255,.07);
    }

    .posting-date {
        color: #69788b;
        font-size: 10px;
    }

    .posting-date i {
        color: #d6ad52;
        margin-right: 3px;
    }

    .posting-status {
        padding: 4px 7px;

        border-radius: 20px;

        color: #9ed6ae;

        background: rgba(80,180,105,.09);

        border: 1px solid rgba(80,180,105,.18);

        font-size: 9px;
        font-weight: 700;
    }


    /* =====================================================
       EMPTY POSTINGS
    ===================================================== */

    .empty-postings {
        padding: 45px 20px;

        text-align: center;

        border:
            1px dashed rgba(214,173,82,.25);

        border-radius: 14px;

        background:
            rgba(255,255,255,.015);
    }

    .empty-postings i {
        display: block;

        color: #d6ad52;

        font-size: 34px;

        margin-bottom: 13px;
    }

    .empty-postings h4 {
        color: #f5f1e8;

        font-size: 17px;
        font-weight: 700;
    }

    .empty-postings p {
        color: #8d98a6;

        font-size: 12px;

        margin-bottom: 20px;
    }


    /* =====================================================
       FOOTER
    ===================================================== */

    footer {
        padding: 25px 0;

        background: #050f1c;

        border-top:
            1px solid rgba(255,255,255,.06);

        color: #69788b;

        font-size: 11px;

        text-align: center;
    }

    footer .brand {
        font-size: 19px;
    }


    /* =====================================================
       RESPONSIVE
    ===================================================== */

    @media (max-width: 991px) {

        .navbar-collapse {
            margin-top: 15px;
        }

        .navbar-nav {
            align-items: flex-start !important;
        }

        .custom-link {
            margin-left: 0;
            padding-left: 0 !important;
        }

        .logout-link {
            margin-left: 0;
            margin-top: 8px;
        }

        .postings-grid {
            grid-template-columns:
                repeat(2, minmax(0, 1fr));
        }
    }


    @media (max-width: 600px) {

        .profile-status {
            align-items: flex-start;
            flex-direction: column;
            gap: 10px;
        }

        .profile-status a {
            margin-left: 27px;
        }

        .hero {
            padding: 50px 0;
        }

        .hero h1 {
            font-size: 34px;
        }

        .dashboard {
            padding: 45px 0 60px;
        }

        .postings-heading {
            align-items: flex-start;
            flex-direction: column;
        }

        .small-post-btn {
            width: 100%;
        }

        .postings-grid {
            grid-template-columns: 1fr;
        }

        .feature-card {
            padding: 21px;
        }
    }

</style>

</head>


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


<!-- =====================================================
     PROFILE STATUS
===================================================== -->

<div class="profile-status-wrapper">


<div class="container">

    <% if (profileCompleted) { %>

        <!-- PROFILE COMPLETED -->

        <div class="profile-status completed">

            <div class="profile-status-left">

                <i class="bi bi-check-circle-fill"></i>

                <span>
                    Your company profile is complete.
                </span>

            </div>

            <a
                href="<%= request.getContextPath() %>/companyProfile">

                Edit Profile
                <i class="bi bi-arrow-right"></i>

            </a>

        </div>

    <% } else { %>

        <!-- PROFILE INCOMPLETE -->

        <div class="profile-status incomplete">

            <div class="profile-status-left">

                <i class="bi bi-exclamation-circle-fill"></i>

                <span>
                    Complete your company profile before posting opportunities.
                </span>

            </div>

            <a
                href="<%= request.getContextPath() %>/companyProfile">

                Complete Profile
                <i class="bi bi-arrow-right"></i>

            </a>

        </div>

    <% } %>

</div>


</div>

<!-- =====================================================
     HERO
===================================================== -->

<section class="hero">

<div class="container">

    <div class="hero-label">
        Company Dashboard
    </div>


    <h1>

        Welcome,

        <span>
            <%= user.getName() %>.
        </span>

    </h1>


    <p>

        Manage your opportunities, connect with students,
        and find the right talent for your company.

    </p>

</div>


</section>

<!-- =====================================================
     DASHBOARD CARDS
===================================================== -->

<section class="dashboard">

<div class="container">


    <h2 class="section-title">
        Company Dashboard
    </h2>


    <p class="section-subtitle mb-4">

        Manage your opportunities and student applications
        from one place.

    </p>


    <div class="row g-3">


        <!-- POST OPPORTUNITY -->

        <div class="col-md-6 col-lg-4">

            <div class="feature-card">

                <div class="icon-box">

                    <i class="bi bi-plus-circle"></i>

                </div>


                <h4>
                    Post Opportunity
                </h4>


                <p>

                    Create and publish a new job or
                    internship opportunity.

                </p>


                <a
                    href="<%= request.getContextPath() %>/postJob.jsp"
                    class="dashboard-btn">

                    Post Now

                    <i class="bi bi-arrow-right"></i>

                </a>

            </div>

        </div>


        <!-- MY POSTINGS -->

        <div class="col-md-6 col-lg-4">

            <div class="feature-card">

                <div class="icon-box">

                    <i class="bi bi-briefcase"></i>

                </div>


                <h4>
                    My Postings
                </h4>


                <p>

                    View all jobs and internships posted
                    by your company.

                </p>


                <a
                    href="#postings"
                    class="dashboard-btn">

                    View Postings

                    <i class="bi bi-arrow-down"></i>

                </a>

            </div>

        </div>


        <!-- APPLICANTS -->

        <div class="col-md-6 col-lg-4">

            <div class="feature-card">

                <div class="icon-box">

                    <i class="bi bi-people"></i>

                </div>


                <h4>
                    View Applicants
                </h4>


                <p>

                    Review students who applied to
                    your opportunities.

                </p>


                <a
                    href="<%= request.getContextPath() %>/companyapplications"
                    class="dashboard-btn">

                    View Applicants

                    <i class="bi bi-arrow-right"></i>

                </a>

            </div>

        </div>


    </div>

</div>

</section>

<!-- =====================================================
     MY POSTINGS
===================================================== -->

<section
    class="postings-section"
    id="postings">


<div class="container">


    <div class="postings-heading">


        <div>

            <div class="hero-label">
                Your Activity
            </div>


            <h2 class="section-title mt-2">
                My Postings
            </h2>


            <p class="section-subtitle">

                View all opportunities posted from
                your company account.

            </p>

        </div>


        <a
            href="<%= request.getContextPath() %>/postJob.jsp"
            class="small-post-btn">

            <i class="bi bi-plus-circle"></i>

            Post New Opportunity

        </a>


    </div>


    <% if (opportunities != null && !opportunities.isEmpty()) { %>


        <div class="postings-grid">


            <% for (Opportunity opportunity : opportunities) { %>


                <div class="posting-card">


                    <div class="posting-top">


                        <span class="opportunity-type">

                            <%= opportunity.getType() %>

                        </span>


                        <i
                            class="bi bi-briefcase posting-icon">
                        </i>


                    </div>


                    <h3 class="posting-title">

                        <%= opportunity.getTitle() %>

                    </h3>


                    <div class="posting-location">

                        <i class="bi bi-geo-alt"></i>

                        <%= opportunity.getLocation() %>

                    </div>


                    <p class="posting-description">

                        <%= opportunity.getDescription() %>

                    </p>


                    <div class="posting-bottom">


                        <span class="posting-date">

                            <i class="bi bi-calendar3"></i>

                            Posted opportunity

                        </span>


                        <span class="posting-status">

                            Active

                        </span>


                    </div>


                </div>


            <% } %>


        </div>


    <% } else { %>


        <div class="empty-postings">

            <i class="bi bi-briefcase"></i>


            <h4>
                No postings yet
            </h4>


            <p>

                You have not posted any job or
                internship opportunities.

            </p>


            <a
                href="<%= request.getContextPath() %>/postJob.jsp"
                class="dashboard-btn">

                <i class="bi bi-plus-circle"></i>

                Post Your First Opportunity

            </a>

        </div>


    <% } %>


</div>

</section>

<!-- =====================================================
     FOOTER
===================================================== -->

<footer>


<div class="container">

    <div
        class="d-flex justify-content-between
               align-items-center
               flex-wrap gap-3">


        <a
            href="index.jsp"
            class="brand">

            <i class="bi bi-mortarboard-fill"></i>

            CampusConnect

        </a>


        <small>

            © 2026 CampusConnect ·
            Connecting students with opportunities.

        </small>


    </div>

</div>


</footer>

<!-- Bootstrap JS -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>

</html>
