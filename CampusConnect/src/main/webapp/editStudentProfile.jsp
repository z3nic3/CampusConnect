<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="javax.servlet.http.HttpSession"%>
<%@ page import="com.campusconnect.model.User"%>
<%@ page import="com.campusconnect.model.StudentProfile"%>

<%
    HttpSession currentSession = request.getSession(false);

    User user = null;
    StudentProfile profile = null;

    if (currentSession != null) {
        user = (User) currentSession.getAttribute("user");
        profile = (StudentProfile) request.getAttribute("profile");
    }

    if (user == null || !"STUDENT".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="UTF-8">

<meta name="viewport"
      content="width=device-width, initial-scale=1.0">

<title>Edit Profile | CampusConnect</title>


<!-- =====================================================
     BOOTSTRAP
===================================================== -->

<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
    rel="stylesheet">


<!-- =====================================================
     BOOTSTRAP ICONS
===================================================== -->

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
/* =========================================================
   GLOBAL
========================================================= */

* {
    box-sizing: border-box;
}

html {
    scroll-behavior: smooth;
}

body {

    margin: 0;

    background:
        radial-gradient(
            circle at 15% 10%,
            rgba(214,173,82,0.06),
            transparent 28%
        ),
        radial-gradient(
            circle at 85% 25%,
            rgba(214,173,82,0.04),
            transparent 30%
        ),
        #071426;

    color: #f5f1e8;

    font-family: "Segoe UI", Arial, sans-serif;

    min-height: 100vh;
}


/* =========================================================
   NAVBAR
========================================================= */

.navbar-custom {

    background: rgba(7,20,38,0.94) !important;

    backdrop-filter: blur(12px);

    border-bottom:
        1px solid rgba(214,173,82,0.12);

    padding: 17px 0;
}


/* LOGO */

.brand {

    color: #f5f1e8 !important;

    text-decoration: none;

    font-size: 23px;

    font-weight: 800;

    letter-spacing: -0.5px;
}

.brand i {

    color: #d6ad52;

    margin-right: 8px;

    filter:
        drop-shadow(
            0 0 6px rgba(214,173,82,0.5)
        );
}


/* NAV LINKS */

.custom-link {

    position: relative;

    color: #aeb9c8 !important;

    font-size: 14px;

    font-weight: 600;

    margin-left: 10px;

    padding: 10px 9px !important;

    background: transparent !important;

    border: none !important;

    transition: 0.3s ease;
}

.custom-link i {

    color: #d6ad52;

    margin-right: 5px;
}

.custom-link:hover {

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

    box-shadow:
        0 0 9px rgba(214,173,82,0.8);

    transition: width 0.3s ease;
}

.custom-link:hover::after {

    width: 55%;
}


/* LOGOUT */

.logout-link {

    color: #d6ad52 !important;

    font-size: 14px;

    font-weight: 700;

    margin-left: 14px;

    padding: 9px 14px !important;

    border:
        1px solid rgba(214,173,82,0.25) !important;

    border-radius: 9px !important;

    background: transparent !important;

    transition: 0.3s ease;
}

.logout-link i {

    margin-right: 5px;
}

.logout-link:hover {

    color: #071426 !important;

    background: #d6ad52 !important;

    border-color: #d6ad52 !important;

    box-shadow:
        0 0 18px rgba(214,173,82,0.35);

    transform: translateY(-2px);
}


/* MOBILE TOGGLER */

.navbar-toggler {

    border:
        1px solid rgba(214,173,82,0.30);

    border-radius: 8px;

    padding: 7px 10px;

    background: transparent;
}

.navbar-toggler i {

    color: #d6ad52;

    font-size: 21px;
}


/* =========================================================
   PAGE
========================================================= */

.profile-section {

    padding: 50px 5% 70px;

    min-height:
        calc(100vh - 75px);
}


/* =========================================================
   HEADING
========================================================= */

.profile-heading {

    text-align: center;

    margin-bottom: 32px;
}

.profile-heading h1 {

    margin: 0 0 8px;

    color: #d6ad52;

    font-size: 2.15rem;

    font-weight: 800;

    letter-spacing: -0.8px;

    text-shadow:
        0 0 20px rgba(214,173,82,0.16);
}

.profile-heading h1 i {

    margin-right: 7px;
}

.profile-heading p {

    margin: 0;

    color: #7f8da0;

    font-size: 0.83rem;
}


/* =========================================================
   MAIN CARD
========================================================= */

.profile-card {

    position: relative;

    max-width: 900px;

    margin: 0 auto;

    padding: 30px;

    background:
        linear-gradient(
            145deg,
            rgba(14,35,59,0.94),
            rgba(7,20,38,0.94)
        );

    border:
        1px solid rgba(214,173,82,0.17);

    border-radius: 17px;

    box-shadow:
        0 15px 45px rgba(0,0,0,0.30),
        0 0 30px rgba(214,173,82,0.025);

    overflow: hidden;
}


/* subtle glow */

.profile-card::before {

    content: "";

    position: absolute;

    width: 260px;
    height: 260px;

    top: -180px;
    right: -100px;

    border-radius: 50%;

    background:
        rgba(214,173,82,0.07);

    filter: blur(50px);

    pointer-events: none;
}


/* =========================================================
   FORM SECTION
========================================================= */

.section-title {

    display: flex;

    align-items: center;

    gap: 8px;

    color: #d6ad52;

    font-size: 0.88rem;

    font-weight: 700;

    margin-top: 25px;

    margin-bottom: 15px;

    padding-bottom: 8px;

    border-bottom:
        1px solid rgba(214,173,82,0.10);
}

.section-title:first-of-type {

    margin-top: 0;
}

.section-title i {

    font-size: 0.85rem;

    filter:
        drop-shadow(
            0 0 5px rgba(214,173,82,0.35)
        );
}


/* =========================================================
   FORM LABEL
========================================================= */

.form-label {

    color: #aeb9c8;

    font-size: 0.73rem;

    font-weight: 600;

    margin-bottom: 6px;
}


/* =========================================================
   INPUTS
========================================================= */

.form-control {

    background:
        rgba(5,15,29,0.65) !important;

    border:
        1px solid rgba(214,173,82,0.13) !important;

    color: #e8e8e8 !important;

    border-radius: 8px;

    padding: 9px 11px;

    font-size: 0.77rem;

    transition:
        border-color 0.2s ease,
        box-shadow 0.2s ease,
        background 0.2s ease;
}

.form-control:hover {

    border-color:
        rgba(214,173,82,0.22) !important;
}

.form-control:focus {

    background:
        rgba(7,20,38,0.85) !important;

    color: #ffffff !important;

    border-color:
        rgba(214,173,82,0.55) !important;

    box-shadow:
        0 0 0 2px rgba(214,173,82,0.07),
        0 0 15px rgba(214,173,82,0.06);

    outline: none;
}

.form-control::placeholder {

    color: #5f6e81;

    font-size: 0.74rem;
}


/* TEXTAREA */

textarea.form-control {

    resize: vertical;

    min-height: 85px;
}


/* FILE INPUT */

input[type="file"].form-control {

    padding: 7px 9px;
}

input[type="file"]::file-selector-button {

    background:
        rgba(214,173,82,0.10);

    color: #d6ad52;

    border:
        1px solid rgba(214,173,82,0.18);

    border-radius: 6px;

    padding: 5px 9px;

    margin-right: 9px;

    font-size: 0.70rem;

    cursor: pointer;
}


/* =========================================================
   READ ONLY NAME
========================================================= */

.readonly-input {

    background:
        rgba(214,173,82,0.035) !important;

    color: #c8cdd5 !important;

    border-color:
        rgba(214,173,82,0.10) !important;
}


/* =========================================================
   SMALL HELP TEXT
========================================================= */

.form-help {

    color: #59697d;

    font-size: 0.65rem;

    margin-top: 5px;

    display: block;
}


/* =========================================================
   CURRENT RESUME
========================================================= */

.current-resume {

    display: inline-flex;

    align-items: center;

    gap: 7px;

    margin-top: 10px;

    padding: 7px 10px;

    border-radius: 7px;

    background:
        rgba(214,173,82,0.05);

    border:
        1px solid rgba(214,173,82,0.13);

    color: #9da8b7;

    font-size: 0.68rem;
}

.current-resume i {

    color: #d6ad52;

    font-size: 0.8rem;
}


/* =========================================================
   BUTTON AREA
========================================================= */

.form-actions {

    display: flex;

    justify-content: flex-end;

    align-items: center;

    gap: 9px;

    margin-top: 28px;

    padding-top: 18px;

    border-top:
        1px solid rgba(214,173,82,0.09);
}


/* SAVE */

.btn-save {

    display: inline-flex;

    align-items: center;

    justify-content: center;

    gap: 6px;

    color: #071426;

    background:
        linear-gradient(
            135deg,
            #e2bf69,
            #cda548
        );

    border: none;

    padding: 8px 16px;

    border-radius: 7px;

    font-size: 0.74rem;

    font-weight: 700;

    transition: 0.25s ease;

    box-shadow:
        0 4px 12px rgba(214,173,82,0.08);
}

.btn-save:hover {

    color: #071426;

    transform: translateY(-2px);

    box-shadow:
        0 0 18px rgba(214,173,82,0.30);
}


/* CANCEL */

.btn-cancel {

    display: inline-flex;

    align-items: center;

    justify-content: center;

    gap: 6px;

    color: #9da8b7;

    background:
        rgba(255,255,255,0.025);

    border:
        1px solid rgba(255,255,255,0.10);

    padding: 8px 16px;

    border-radius: 7px;

    font-size: 0.74rem;

    font-weight: 600;

    text-decoration: none;

    transition: 0.25s ease;
}

.btn-cancel:hover {

    color: #f5f1e8;

    border-color:
        rgba(214,173,82,0.25);

    background:
        rgba(214,173,82,0.05);
}


/* =========================================================
   FOOTER
========================================================= */

footer {

    background: #050f1c;

    border-top:
        1px solid rgba(214,173,82,0.10);

    text-align: center;

    padding: 18px;

    color: #617085;

    font-size: 0.70rem;
}

footer i {

    color: #d6ad52;

    margin-right: 4px;
}


/* =========================================================
   TABLET
========================================================= */

@media (max-width: 991px) {

    .navbar-collapse {

        margin-top: 12px;
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

        margin-top: 7px;
    }
}


/* =========================================================
   MOBILE
========================================================= */

@media (max-width: 768px) {

    .profile-section {

        padding: 40px 4% 60px;
    }

    .profile-heading h1 {

        font-size: 1.8rem;
    }

    .profile-card {

        padding: 22px 17px;

        border-radius: 14px;
    }

    .form-actions {

        justify-content: stretch;
    }

    .btn-save,
    .btn-cancel {

        flex: 1;
    }
}


/* =========================================================
   SMALL MOBILE
========================================================= */

@media (max-width: 480px) {

    .profile-heading {

        margin-bottom: 25px;
    }

    .profile-heading h1 {

        font-size: 1.55rem;
    }

    .profile-heading p {

        font-size: 0.75rem;
    }

    .profile-card {

        padding: 20px 14px;
    }

    .section-title {

        font-size: 0.82rem;
    }
}

</style>

</head>


<body>

<div class="back-container">
    <button type="button" class="back-btn" onclick="history.back()">
        <i class="bi bi-arrow-left"></i>
        Back
    </button>
</div>
<!-- =====================================================
     NAVBAR
====================================================== -->
<nav class="navbar navbar-expand-lg navbar-custom">

    <div class="container">

        <!-- LOGO -->
        <a class="brand"
           href="<%= request.getContextPath() %>/studentDashboard.jsp">

            <i class="bi bi-mortarboard-fill"></i>
            CampusConnect

        </a>


        <!-- MOBILE TOGGLE -->
        <button
            class="navbar-toggler"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#studentNavbar"
            aria-controls="studentNavbar"
            aria-expanded="false"
            aria-label="Toggle navigation">

            <i class="bi bi-list"></i>

        </button>


        <!-- NAVIGATION -->
        <div class="collapse navbar-collapse"
             id="studentNavbar">

            <ul class="navbar-nav ms-auto align-items-center">


                <!-- DASHBOARD -->
                <li class="nav-item">

                    <a class="nav-link custom-link"
                       href="<%= request.getContextPath() %>/studentDashboard.jsp">

                        <i class="bi bi-grid-fill"></i>
                        Dashboard

                    </a>

                </li>


                <!-- OPPORTUNITIES -->
                <li class="nav-item">

                    <a class="nav-link custom-link"
                       href="<%= request.getContextPath() %>/studentDashboard.jsp#opportunities">

                        <i class="bi bi-briefcase-fill"></i>
                        Opportunities

                    </a>

                </li>


                <!-- PROFILE -->
                <li class="nav-item">

                    <a class="nav-link custom-link active"
                       href="<%= request.getContextPath() %>/studentProfile">

                        <i class="bi bi-person-fill"></i>
                        Profile

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
     PROFILE SECTION
====================================================== -->

<section class="profile-section">


    <!-- HEADING -->

    <div class="profile-heading">

        <h1>
            <i class="bi bi-person-gear"></i>
            Edit Profile
        </h1>

        <p>
            Keep your profile updated so companies can know you better.
        </p>

    </div>



    <!-- =================================================
         FORM CARD
    ================================================== -->

    <div class="profile-card">


        <form
            action="<%= request.getContextPath() %>/editStudentProfile"
            method="post"
            enctype="multipart/form-data">


            <!-- =================================================
                 PERSONAL INFORMATION
            ================================================== -->

            <h4 class="section-title">

                <i class="bi bi-person-vcard-fill"></i>

                Personal Information

            </h4>


            <div class="mb-3">

                <label class="form-label">
                    Full Name
                </label>

                <input
                    type="text"
                    class="form-control readonly-input"
                    value="<%= user.getName() %>"
                    readonly>

            </div>


            <div class="row">

                <div class="col-md-6 mb-3">

                    <label class="form-label">
                        Phone Number
                    </label>

                    <input
                        type="text"
                        name="phone"
                        class="form-control"
                        value="<%= profile != null && profile.getPhone() != null ? profile.getPhone() : "" %>"
                        placeholder="Enter phone number">

                </div>


                <div class="col-md-6 mb-3">

                    <label class="form-label">
                        Location
                    </label>

                    <input
                        type="text"
                        name="location"
                        class="form-control"
                        value="<%= profile != null && profile.getLocation() != null ? profile.getLocation() : "" %>"
                        placeholder="City, State">

                </div>

            </div>


            <div class="mb-3">

                <label class="form-label">
                    About Me
                </label>

                <textarea
                    name="bio"
                    class="form-control"
                    rows="3"
                    placeholder="Tell companies a little about yourself..."><%= profile != null && profile.getBio() != null ? profile.getBio() : "" %></textarea>

            </div>



            <!-- =================================================
                 EDUCATION
            ================================================== -->

            <h4 class="section-title">

                <i class="bi bi-mortarboard-fill"></i>

                Education

            </h4>


            <div class="mb-3">

                <label class="form-label">
                    Education Details
                </label>

                <textarea
                    name="education"
                    class="form-control"
                    rows="2"
                    placeholder="B.Tech CSE, Asansol Engineering College, 2028"><%= profile != null && profile.getEducation() != null ? profile.getEducation() : "" %></textarea>

            </div>



            <!-- =================================================
                 SKILLS
            ================================================== -->

            <h4 class="section-title">

                <i class="bi bi-code-slash"></i>

                Skills

            </h4>


            <div class="mb-3">

                <label class="form-label">
                    Technical Skills
                </label>

                <input
                    type="text"
                    name="skills"
                    class="form-control"
                    value="<%= profile != null && profile.getSkills() != null ? profile.getSkills() : "" %>"
                    placeholder="Java, SQL, HTML, CSS, Python">

                <small class="form-help">
                    Separate multiple skills with commas.
                </small>

            </div>



            <!-- =================================================
                 PROFESSIONAL LINKS
            ================================================== -->

            <h4 class="section-title">

                <i class="bi bi-link-45deg"></i>

                Professional Links

            </h4>


            <div class="row">

                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        <i class="bi bi-github"></i>
                        GitHub

                    </label>

                    <input
                        type="url"
                        name="githubLink"
                        class="form-control"
                        value="<%= profile != null && profile.getGithubLink() != null ? profile.getGithubLink() : "" %>"
                        placeholder="https://github.com/username">

                </div>


                <div class="col-md-6 mb-3">

                    <label class="form-label">

                        <i class="bi bi-linkedin"></i>
                        LinkedIn

                    </label>

                    <input
                        type="url"
                        name="linkedinLink"
                        class="form-control"
                        value="<%= profile != null && profile.getLinkedinLink() != null ? profile.getLinkedinLink() : "" %>"
                        placeholder="https://linkedin.com/in/username">

                </div>

            </div>



            <!-- =================================================
                 RESUME
            ================================================== -->

            <h4 class="section-title">

                <i class="bi bi-file-earmark-pdf-fill"></i>

                Resume

            </h4>


            <div class="mb-3">

                <label class="form-label">
                    Upload Resume
                </label>

                <input
                    type="file"
                    name="resume"
                    class="form-control"
                    accept=".pdf,application/pdf">

                <small class="form-help">
                    Upload your latest resume in PDF format.
                </small>


                <% if (profile != null &&
                       profile.getResumePath() != null &&
                       !profile.getResumePath().isEmpty()) { %>


                    <div class="current-resume">

                        <i class="bi bi-check-circle-fill"></i>

                        Current resume is already uploaded.

                    </div>


                <% } %>

            </div>



            <!-- =================================================
                 BUTTONS
            ================================================== -->

            <div class="form-actions">


                <a
                    href="<%= request.getContextPath() %>/studentProfile"
                    class="btn-cancel">

                    <i class="bi bi-x-lg"></i>

                    Cancel

                </a>


                <button
                    type="submit"
                    class="btn-save">

                    <i class="bi bi-check-lg"></i>

                    Save Profile

                </button>


            </div>


        </form>

    </div>

</section>



<!-- =====================================================
     FOOTER
====================================================== -->

<footer>

    <i class="bi bi-mortarboard-fill"></i>

    CampusConnect &nbsp;•&nbsp; Student Portal

</footer>



<!-- =====================================================
     BOOTSTRAP JS
====================================================== -->

<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>


</body>

</html>