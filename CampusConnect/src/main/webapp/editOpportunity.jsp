<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="com.campusconnect.model.User" %>
<%@ page import="com.campusconnect.model.Opportunity" %>
<%@ page import="com.campusconnect.dao.OpportunityDAO" %>

<%
    // =========================================================
    // ADMIN CHECK
    // =========================================================

    User user = (User) session.getAttribute("user");

    if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // =========================================================
    // GET OPPORTUNITY ID
    // =========================================================

    String oppIdParam = request.getParameter("oppId");

    if (oppIdParam == null || oppIdParam.trim().isEmpty()) {
        response.sendRedirect("adminDashboard.jsp?message=invalid");
        return;
    }

    int oppId;

    try {
        oppId = Integer.parseInt(oppIdParam);
    } catch (NumberFormatException e) {
        response.sendRedirect("adminDashboard.jsp?message=invalid");
        return;
    }

    // =========================================================
    // GET OPPORTUNITY
    // =========================================================

    OpportunityDAO opportunityDAO = new OpportunityDAO();

    Opportunity opportunity = null;

    for (Opportunity o : opportunityDAO.getAllOpportunities()) {

        if (o.getOppId() == oppId) {
            opportunity = o;
            break;
        }
    }

    if (opportunity == null) {
        response.sendRedirect("adminDashboard.jsp?message=oppNotFound");
        return;
    }

    // =========================================================
    // HANDLE FORM SUBMISSION
    // =========================================================

    String message = null;

    if ("POST".equalsIgnoreCase(request.getMethod())) {

        String title = request.getParameter("title");
        String type = request.getParameter("type");
        String skillRequired = request.getParameter("skillRequired");
        String location = request.getParameter("location");
        String description = request.getParameter("description");

        if (title == null || title.trim().isEmpty() ||
            type == null || type.trim().isEmpty() ||
            skillRequired == null || skillRequired.trim().isEmpty() ||
            location == null || location.trim().isEmpty() ||
            description == null || description.trim().isEmpty()) {

            message = "Please fill in all fields.";

        } else {

            opportunity.setTitle(title.trim());
            opportunity.setType(type.trim());
            opportunity.setSkillRequired(skillRequired.trim());
            opportunity.setLocation(location.trim());
            opportunity.setDescription(description.trim());

            boolean updated = opportunityDAO.updateOpportunity(opportunity);

            if (updated) {

                response.sendRedirect(
                    "adminDashboard.jsp?message=opportunityUpdated"
                );

                return;

            } else {

                message = "Unable to update the opportunity.";
            }
        }
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Edit Opportunity | CampusConnect</title>

    <!-- =====================================================
         BOOTSTRAP
    ====================================================== -->

    <link
        href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
        rel="stylesheet">

    <!-- =====================================================
         BOOTSTRAP ICONS
    ====================================================== -->

    <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <style>

        /* =====================================================
           GENERAL
        ===================================================== */

        * {
            box-sizing: border-box;
        }

        html {
            scroll-behavior: smooth;
        }

        body {
            margin: 0;
            background: #071426;
            color: #f5f1e8;
            font-family: "Segoe UI", Arial, sans-serif;
            min-height: 100vh;
        }


        /* =====================================================
           NAVBAR
        ===================================================== */

        .navbar-custom {
            background: #071426;
            border-bottom: 1px solid rgba(214, 173, 82, 0.18);
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


        /* =====================================================
           BACK BUTTON
        ===================================================== */

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 7px;

            padding: 9px 14px;

            color: #d6ad52;
            background: transparent;

            border: 1px solid rgba(214, 173, 82, 0.28);
            border-radius: 9px;

            text-decoration: none;

            font-size: 13px;
            font-weight: 700;

            transition: 0.3s ease;
        }

        .back-btn:hover {
            color: #071426;
            background: #d6ad52;
            border-color: #d6ad52;

            transform: translateY(-2px);

            box-shadow:
                0 0 12px rgba(214, 173, 82, 0.25);
        }

        .back-btn i {
            font-size: 14px;
        }


        /* =====================================================
           BRAND
        ===================================================== */

        .brand {
            color: #f5f1e8;
            text-decoration: none;

            font-size: 24px;
            font-weight: 800;

            letter-spacing: -0.5px;

            transition: 0.3s ease;
        }

        .brand i {
            color: #d6ad52;
            margin-right: 8px;
        }

        .brand:hover {
            color: #ffffff;
        }


        /* =====================================================
           ADMIN USER
        ===================================================== */

        .navbar-right {
            display: flex;
            align-items: center;
        }

        .admin-name {
            display: flex;
            align-items: center;

            color: #b8c0cb;

            font-size: 14px;
            font-weight: 600;
        }

        .admin-icon {
            width: 38px;
            height: 38px;

            display: inline-flex;
            align-items: center;
            justify-content: center;

            margin-right: 9px;

            border-radius: 50%;

            background: rgba(214, 173, 82, 0.10);
            border: 1px solid rgba(214, 173, 82, 0.25);

            color: #d6ad52;

            font-size: 16px;
        }


        /* =====================================================
           PAGE
        ===================================================== */

        .page {
            padding: 65px 0 90px;
        }

        .page-container {
            max-width: 900px;
            margin: 0 auto;
            padding: 0 20px;
        }


        /* =====================================================
           PAGE HEADER
        ===================================================== */

        .page-header {
            margin-bottom: 35px;
        }

        .page-label {
            color: #d6ad52;

            font-size: 12px;
            font-weight: 700;

            letter-spacing: 2px;
            text-transform: uppercase;

            margin-bottom: 12px;
        }

        .page-header h1 {
            margin: 0;

            font-size: 38px;
            font-weight: 800;

            letter-spacing: -1px;
        }

        .page-header h1 span {
            color: #d6ad52;
        }

        .page-header p {
            margin: 12px 0 0;

            max-width: 650px;

            color: #8d98a6;

            font-size: 15px;
            line-height: 1.7;
        }


        /* =====================================================
           FORM CARD
        ===================================================== */

        .form-card {
            background:
                linear-gradient(
                    145deg,
                    rgba(255,255,255,.045),
                    rgba(255,255,255,.015)
                );

            border: 1px solid rgba(255,255,255,.09);

            border-radius: 18px;

            padding: 35px;

            box-shadow:
                0 15px 40px rgba(0,0,0,.22);

            transition: 0.3s ease;
        }

        .form-card:hover {
            border-color: rgba(214,173,82,.18);
        }


        /* =====================================================
           FORM TOP
        ===================================================== */

        .form-top {
            display: flex;
            align-items: center;
            gap: 15px;

            padding-bottom: 25px;
            margin-bottom: 28px;

            border-bottom: 1px solid rgba(255,255,255,.07);
        }

        .form-icon {
            width: 48px;
            height: 48px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 12px;

            background: rgba(214,173,82,.10);

            border: 1px solid rgba(214,173,82,.22);

            color: #d6ad52;

            font-size: 20px;
        }

        .form-top h2 {
            margin: 0;

            font-size: 19px;
            font-weight: 700;
        }

        .form-top p {
            margin: 4px 0 0;

            color: #707b89;

            font-size: 13px;
        }


        /* =====================================================
           FORM GROUP
        ===================================================== */

        .form-group {
            margin-bottom: 23px;
        }

        .form-label {
            display: block;

            margin-bottom: 8px;

            color: #dfe4ea;

            font-size: 13px;
            font-weight: 700;
        }

        .required {
            color: #d6ad52;
        }


        /* =====================================================
           INPUTS
        ===================================================== */

        .form-control,
        .form-select {

            width: 100%;

            padding: 12px 14px;

            background: #071426;
            color: #f5f1e8;

            border: 1px solid rgba(255,255,255,.11);

            border-radius: 9px;

            font-size: 14px;

            transition: 0.25s ease;
        }

        .form-control::placeholder {
            color: #667181;
        }

        .form-control:hover,
        .form-select:hover {
            border-color: rgba(214,173,82,.22);
        }

        .form-control:focus,
        .form-select:focus {

            background: #071426;

            color: #f5f1e8;

            border-color: #d6ad52;

            outline: none;

            box-shadow:
                0 0 0 3px rgba(214,173,82,.10);
        }


        /* =====================================================
           SELECT
        ===================================================== */

        .form-select {
            cursor: pointer;
        }

        .form-select option {
            background: #071426;
            color: #f5f1e8;
        }


        /* =====================================================
           TEXTAREA
        ===================================================== */

        textarea.form-control {
            min-height: 160px;
            resize: vertical;
            line-height: 1.6;
        }


        /* =====================================================
           TWO COLUMN FORM
        ===================================================== */

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }


        /* =====================================================
           OPPORTUNITY ID
        ===================================================== */

        .opportunity-id {
            display: inline-flex;
            align-items: center;
            gap: 6px;

            margin-top: 3px;

            color: #707b89;

            font-size: 12px;
        }

        .opportunity-id i {
            color: #d6ad52;
        }


        /* =====================================================
           ERROR MESSAGE
        ===================================================== */

        .error-message {

            display: flex;
            align-items: center;
            gap: 9px;

            margin-bottom: 25px;

            padding: 13px 16px;

            background: rgba(220,80,80,.08);

            border: 1px solid rgba(220,80,80,.28);

            border-radius: 10px;

            color: #e98585;

            font-size: 13px;
            font-weight: 600;
        }

        .error-message i {
            font-size: 16px;
        }


        /* =====================================================
           BUTTON ROW
        ===================================================== */

        .button-row {

            display: flex;

            justify-content: flex-end;

            align-items: center;

            gap: 12px;

            margin-top: 32px;

            padding-top: 25px;

            border-top: 1px solid rgba(255,255,255,.07);
        }


        /* =====================================================
           CANCEL BUTTON
        ===================================================== */

        .cancel-btn {

            display: inline-flex;
            align-items: center;
            justify-content: center;

            gap: 7px;

            padding: 11px 18px;

            color: #c5ccd5;

            background: transparent;

            border: 1px solid rgba(255,255,255,.14);

            border-radius: 9px;

            text-decoration: none;

            font-size: 13px;
            font-weight: 700;

            transition: 0.3s ease;
        }

        .cancel-btn:hover {

            color: #071426;

            background: #f5f1e8;

            border-color: #f5f1e8;

            transform: translateY(-1px);
        }


        /* =====================================================
           SAVE BUTTON
        ===================================================== */

        .save-btn {

            display: inline-flex;
            align-items: center;
            justify-content: center;

            gap: 7px;

            padding: 11px 20px;

            color: #071426;

            background: #d6ad52;

            border: 1px solid #d6ad52;

            border-radius: 9px;

            font-size: 13px;
            font-weight: 800;

            cursor: pointer;

            transition: 0.3s ease;
        }

        .save-btn:hover {

            background: #e2bd68;

            border-color: #e2bd68;

            transform: translateY(-2px);

            box-shadow:
                0 8px 20px rgba(214,173,82,.15);
        }


        /* =====================================================
           FOOTER
        ===================================================== */

        footer {

            background: #050f1c;

            border-top: 1px solid rgba(255,255,255,.06);

            padding: 25px 0;

            color: #707b89;

            text-align: center;
        }

        footer small {
            font-size: 12px;
        }


        /* =====================================================
           RESPONSIVE
        ===================================================== */

        @media (max-width: 768px) {

            .navbar-custom {
                padding: 16px 0;
            }

            .navbar-container {
                padding: 0 15px;
            }

            .brand {
                font-size: 21px;
            }

            .admin-name {
                font-size: 13px;
            }

            .admin-icon {
                width: 34px;
                height: 34px;
            }

            .page {
                padding: 50px 0 70px;
            }

            .page-container {
                padding: 0 15px;
            }

            .page-header h1 {
                font-size: 32px;
            }

            .form-card {
                padding: 27px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
        }


        @media (max-width: 500px) {

            .navbar-left {
                gap: 9px;
            }

            .back-btn {
                padding: 8px 10px;
            }

            .back-btn span {
                display: none;
            }

            .brand {
                font-size: 19px;
            }

            .brand i {
                margin-right: 5px;
            }

            .admin-name > span:last-child {
                display: none;
            }

            .page {
                padding: 40px 0 55px;
            }

            .page-header h1 {
                font-size: 28px;
            }

            .page-header p {
                font-size: 14px;
            }

            .form-card {
                padding: 22px;
                border-radius: 15px;
            }

            .form-top {
                padding-bottom: 20px;
                margin-bottom: 23px;
            }

            .button-row {
                flex-direction: column-reverse;
            }

            .cancel-btn,
            .save-btn {
                width: 100%;
            }
        }

    </style>

</head>


<body>


<!-- =========================================================
     NAVBAR
========================================================= -->

<nav class="navbar-custom">

    <div class="navbar-container">

        <!-- LEFT -->

        <div class="navbar-left">

            <a href="adminDashboard.jsp"
               class="back-btn">

                <i class="bi bi-arrow-left"></i>

                <span>Back</span>

            </a>


            <a href="adminDashboard.jsp"
               class="brand">

                <i class="bi bi-mortarboard-fill"></i>

                CampusConnect

            </a>

        </div>


        <!-- RIGHT -->

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



<!-- =========================================================
     PAGE
========================================================= -->

<section class="page">

    <div class="page-container">


        <!-- =================================================
             PAGE HEADER
        ================================================== -->

        <div class="page-header">

            <div class="page-label">

                Administration

            </div>

            <h1>

                Edit <span>Opportunity</span>

            </h1>

            <p>

                Update the opportunity information and keep
                the CampusConnect listings accurate.

            </p>

        </div>



        <!-- =================================================
             FORM CARD
        ================================================== -->

        <div class="form-card">


            <!-- FORM HEADER -->

            <div class="form-top">

                <div class="form-icon">

                    <i class="bi bi-pencil-square"></i>

                </div>

                <div>

                    <h2>

                        Opportunity Information

                    </h2>

                    <p>

                        Modify the details of this opportunity.

                    </p>

                </div>

            </div>



            <!-- ERROR -->

            <% if (message != null) { %>

                <div class="error-message">

                    <i class="bi bi-exclamation-circle-fill"></i>

                    <%= message %>

                </div>

            <% } %>



            <!-- FORM -->

            <form method="post"
                  action="editOpportunity.jsp?oppId=<%= opportunity.getOppId() %>">


                <!-- OPPORTUNITY ID -->

                <div class="opportunity-id">

                    <i class="bi bi-hash"></i>

                    Opportunity ID:
                    <strong>
                        <%= opportunity.getOppId() %>
                    </strong>

                </div>

                <br>


                <!-- TITLE -->

                <div class="form-group">

                    <label class="form-label">

                        Opportunity Title
                        <span class="required">*</span>

                    </label>

                    <input
                        type="text"
                        name="title"
                        class="form-control"
                        value="<%= opportunity.getTitle() != null ? opportunity.getTitle() : "" %>"
                        placeholder="Enter opportunity title"
                        required>

                </div>



                <!-- TYPE + LOCATION -->

                <div class="form-row">


                    <!-- TYPE -->

                    <div class="form-group">

                        <label class="form-label">

                            Opportunity Type
                            <span class="required">*</span>

                        </label>

                        <select
                            name="type"
                            class="form-select"
                            required>

                            <option value="JOB"
                                <%= "JOB".equalsIgnoreCase(opportunity.getType())
                                    ? "selected" : "" %>>

                                Job

                            </option>

                            <option value="INTERNSHIP"
                                <%= "INTERNSHIP".equalsIgnoreCase(opportunity.getType())
                                    ? "selected" : "" %>>

                                Internship

                            </option>

                        </select>

                    </div>


                    <!-- LOCATION -->

                    <div class="form-group">

                        <label class="form-label">

                            Location
                            <span class="required">*</span>

                        </label>

                        <input
                            type="text"
                            name="location"
                            class="form-control"
                            value="<%= opportunity.getLocation() != null ? opportunity.getLocation() : "" %>"
                            placeholder="Enter location"
                            required>

                    </div>

                </div>



                <!-- SKILLS -->

                <div class="form-group">

                    <label class="form-label">

                        Skills Required
                        <span class="required">*</span>

                    </label>

                    <input
                        type="text"
                        name="skillRequired"
                        class="form-control"
                        value="<%= opportunity.getSkillRequired() != null ? opportunity.getSkillRequired() : "" %>"
                        placeholder="Example: Java, SQL, HTML, CSS"
                        required>

                </div>



                <!-- DESCRIPTION -->

                <div class="form-group">

                    <label class="form-label">

                        Description
                        <span class="required">*</span>

                    </label>

                    <textarea
                        name="description"
                        class="form-control"
                        placeholder="Enter opportunity description"
                        required><%= opportunity.getDescription() != null
                            ? opportunity.getDescription()
                            : "" %></textarea>

                </div>



                <!-- BUTTONS -->

                <div class="button-row">

                    <a href="adminDashboard.jsp"
                       class="cancel-btn">

                        <i class="bi bi-x-lg"></i>

                        Cancel

                    </a>


                    <button
                        type="submit"
                        class="save-btn">

                        <i class="bi bi-check-lg"></i>

                        Save Changes

                    </button>

                </div>


            </form>

        </div>

    </div>

</section>



<!-- =========================================================
     FOOTER
========================================================= -->

<footer>

    <small>

        © 2026 CampusConnect · Administration

    </small>

</footer>


</body>

</html>