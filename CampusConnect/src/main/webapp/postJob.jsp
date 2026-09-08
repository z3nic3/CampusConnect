<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.campusconnect.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null || !"COMPANY".equals(user.getRole())) {
        response.sendRedirect(
            request.getContextPath() + "/login.jsp"
        );
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Post Opportunity | CampusConnect</title>

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
        /* ================= GENERAL ================= */

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
            border-bottom: 1px solid rgba(214,173,82,.18);
            padding: 20px 0;
        }

        .brand {
            color: #f5f1e8;
            text-decoration: none;
            font-size: 24px;
            font-weight: 750;
            transition: all .3s ease;
        }

        .brand i {
            color: #d6ad52;
            margin-right: 8px;
            transition: all .3s ease;
        }

        .brand:hover {
            color: #ffffff;
            text-shadow:
                0 0 8px rgba(214,173,82,.35);
        }

        .brand:hover i {
            text-shadow:
                0 0 10px rgba(214,173,82,.9);
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


/* ================= NAV LINKS ================= */

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


/* ================= GOLD UNDERLINE ================= */

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


/* ================= ACTIVE LINK ================= */

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


/* ================= COMPANY NAME ================= */

.company-name {
    cursor: default;
    color: #b8c0cb !important;
}

.company-name i {
    color: #d6ad52;
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


/* ================= MOBILE TOGGLER ================= */

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
}


@media (max-width: 480px) {

    .navbar-custom {
        padding: 14px 12px;
    }

    .brand {
        font-size: 19px;
    }

    .brand i {
        margin-right: 5px;
    }
}

        /* ================= DASHBOARD BUTTON ================= */

        .back-link {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 5px;

            color: #d6ad52;
            text-decoration: none;
            font-weight: 650;

            padding: 9px 18px;

            border: 1px solid rgba(214,173,82,.50);
            border-radius: 9px;

            transition:
                all .3s ease;

            box-shadow:
                0 0 7px rgba(214,173,82,.25),
                0 0 15px rgba(214,173,82,.10);
        }

        .back-link:hover {
            background: #d6ad52;
            color: #071426;

            transform: translateY(-2px);

            box-shadow:
                0 0 10px rgba(214,173,82,.9),
                0 0 22px rgba(214,173,82,.55),
                0 8px 25px rgba(214,173,82,.20);
        }

        .back-link:active {
            transform: translateY(0);

            box-shadow:
                0 0 7px rgba(214,173,82,.7);
        }

        .back-link:focus {
            outline: none;

            box-shadow:
                0 0 0 3px rgba(214,173,82,.15),
                0 0 18px rgba(214,173,82,.55);
        }


        /* ================= PAGE ================= */

        .page {
            padding: 65px 15px 90px;
            min-height: calc(100vh - 80px);

            position: relative;
            overflow: hidden;
        }

        .page::before {
            content: "";
            position: absolute;

            width: 400px;
            height: 400px;

            border-radius: 50%;

            border: 1px solid rgba(214,173,82,.08);

            right: -180px;
            top: -150px;
        }

        .page::after {
            content: "";
            position: absolute;

            width: 280px;
            height: 280px;

            border-radius: 50%;

            background: rgba(214,173,82,.035);

            left: -140px;
            bottom: -130px;
        }


        /* ================= FORM CARD ================= */

        .form-card {
            max-width: 800px;
            margin: auto;

            background: #0a1a2e;

            border: 1px solid rgba(214,173,82,.20);

            border-radius: 20px;

            padding: 45px;

            box-shadow:
                0 25px 70px rgba(0,0,0,.35);

            position: relative;
            z-index: 2;
        }


        /* ================= HEADING ICON ================= */

        .heading-icon {
            width: 65px;
            height: 65px;

            background: rgba(214,173,82,.10);

            border: 1px solid rgba(214,173,82,.25);

            color: #d6ad52;

            border-radius: 17px;

            display: flex;
            align-items: center;
            justify-content: center;

            font-size: 28px;

            margin-bottom: 22px;

            transition:
                all .3s ease;

            box-shadow:
                0 0 8px rgba(214,173,82,.15);
        }

        .heading-icon:hover {
            transform: translateY(-3px);

            background: rgba(214,173,82,.14);

            box-shadow:
                0 0 12px rgba(214,173,82,.45),
                0 0 25px rgba(214,173,82,.20);
        }


        /* ================= HEADING ================= */

        .form-card h1 {
            font-size: 36px;
            font-weight: 800;
            letter-spacing: -1px;
        }

        .subtitle {
            color: #7f8a98;
            line-height: 1.7;
        }


        /* ================= FORM ================= */

        .form-label {
            font-weight: 650;
            margin-bottom: 8px;
        }

        .form-control,
        .form-select {

            padding: 13px;

            background: #071426;

            border-color:
                rgba(255,255,255,.12);

            color: #f5f1e8;

            border-radius: 9px;

            transition:
                border-color .25s ease,
                box-shadow .25s ease,
                transform .25s ease;
        }

        .form-control::placeholder {
            color: #667384;
        }

        .form-select option {
            background: #071426;
        }

        .form-control:focus,
        .form-select:focus {

            background: #071426;

            color: #f5f1e8;

            border-color: #d6ad52;

            box-shadow:
                0 0 0 3px rgba(214,173,82,.12),
                0 0 12px rgba(214,173,82,.10);

            outline: none;
        }

        textarea {
            resize: vertical;
            min-height: 160px;
        }


        /* ================= PUBLISH BUTTON ================= */

        .submit-btn {

            width: 100%;

            padding: 13px;

            border: none;

            border-radius: 9px;

            background: #d6ad52;

            color: #071426;

            font-weight: 750;

            cursor: pointer;

            transition:
                all .3s ease;

            box-shadow:
                0 0 8px rgba(214,173,82,.45),
                0 0 18px rgba(214,173,82,.18),
                0 8px 25px rgba(214,173,82,.12);
        }

        .submit-btn:hover {

            background: #e3be68;

            color: #071426;

            transform:
                translateY(-3px)
                scale(1.01);

            box-shadow:
                0 0 10px rgba(214,173,82,1),
                0 0 22px rgba(214,173,82,.70),
                0 12px 35px rgba(214,173,82,.30);
        }

        .submit-btn:active {

            transform:
                translateY(-1px)
                scale(.98);

            box-shadow:
                0 0 8px rgba(214,173,82,.70);
        }

        .submit-btn:focus {

            outline: none;

            box-shadow:
                0 0 0 3px rgba(214,173,82,.20),
                0 0 18px rgba(214,173,82,.60);
        }


        /* ================= ALERT ================= */

        .alert {

            background:
                rgba(214,173,82,.08);

            border:
                1px solid rgba(214,173,82,.20);

            color: #d6ad52;

            border-radius: 9px;
        }


        /* ================= TIP ================= */

        .tip {

            margin-top: 25px;

            padding: 15px 18px;

            background:
                rgba(214,173,82,.06);

            border:
                1px solid rgba(214,173,82,.12);

            border-radius: 10px;

            color: #8d98a6;

            font-size: 14px;

            transition:
                all .3s ease;
        }

        .tip:hover {

            border-color:
                rgba(214,173,82,.28);

            box-shadow:
                0 0 15px rgba(214,173,82,.08);
        }

        .tip i {
            color: #d6ad52;
        }


        /* ================= TABLET ================= */

        @media (max-width: 768px) {

            .navbar-custom {
                padding: 16px 15px;
            }

            .brand {
                font-size: 21px;
            }

            .back-link {
                padding: 8px 14px;
                font-size: 14px;
            }

            .page {
                padding:
                    45px 15px 70px;
            }

            .form-card {
                padding: 35px;
                border-radius: 18px;
            }

            .form-card h1 {
                font-size: 32px;
            }

            .heading-icon {
                width: 60px;
                height: 60px;
                font-size: 25px;
            }

            .submit-btn {
                padding: 14px;
                font-size: 15px;
            }
        }


        /* ================= SMALL MOBILE ================= */

        @media (max-width: 480px) {

            .navbar-custom {
                padding: 14px 12px;
            }

            .brand {
                font-size: 18px;
            }

            .brand i {
                margin-right: 4px;
            }

            .back-link {
                padding: 7px 10px;
                font-size: 13px;
            }

            .page {
                padding:
                    30px 10px 55px;
            }

            .form-card {
                padding: 28px 22px;
                border-radius: 16px;
            }

            .heading-icon {
                width: 55px;
                height: 55px;
                border-radius: 14px;
                font-size: 23px;
            }

            .form-card h1 {
                font-size: 28px;
            }

            .subtitle {
                font-size: 14px;
            }

            .form-label {
                font-size: 14px;
            }

            .form-control,
            .form-select {
                padding: 12px;
                font-size: 14px;
            }

            textarea {
                min-height: 140px;
            }

            .submit-btn {
                padding: 13px;
                font-size: 14px;
            }

            .tip {
                font-size: 13px;
                padding: 13px 15px;
            }
        }


        /* ================= VERY SMALL DEVICES ================= */

        @media (max-width: 360px) {

            .brand {
                font-size: 16px;
            }

            .back-link {
                padding: 6px 8px;
                font-size: 12px;
            }

            .form-card {
                padding: 25px 18px;
            }

            .form-card h1 {
                font-size: 25px;
            }

            .heading-icon {
                width: 50px;
                height: 50px;
                font-size: 21px;
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

    <div class="form-card">


        <!-- ================= ICON ================= -->

        <div class="heading-icon">

            <i class="bi bi-briefcase"></i>

        </div>



        <!-- ================= HEADING ================= -->

        <h1>

            Post an opportunity

        </h1>


        <p class="subtitle mb-4">

            Share a job or internship opportunity
            with students on CampusConnect.

        </p>



        <!-- ================= ERROR ================= -->

        <% if (request.getAttribute("error") != null) { %>

            <div class="alert mb-4">

                <i class="bi bi-exclamation-circle me-2"></i>

                <%= request.getAttribute("error") %>

            </div>

        <% } %>



        <!-- ================= SUCCESS ================= -->

        <% if (request.getAttribute("message") != null) { %>

            <div class="alert mb-4">

                <i class="bi bi-check-circle me-2"></i>

                <%= request.getAttribute("message") %>

            </div>

        <% } %>



        <!-- ================= FORM ================= -->

        <form action="postOpportunity"
              method="post">


            <!-- OPPORTUNITY TITLE -->

            <div class="mb-4">

                <label class="form-label">

                    Opportunity title

                </label>

                <input type="text"
                       name="title"
                       class="form-control"
                       placeholder="e.g. Java Developer Intern"
                       required>

            </div>



            <!-- OPPORTUNITY TYPE -->

            <div class="mb-4">

                <label class="form-label">

                    Opportunity type

                </label>

                <select name="type"
                        class="form-select"
                        required>

                    <option value=""
                            selected
                            disabled>

                        Choose an opportunity type

                    </option>

                    <option value="JOB">

                        Full-Time Job

                    </option>

                    <option value="INTERNSHIP">

                        Internship

                    </option>

                </select>

            </div>



            <!-- SKILLS -->

            <div class="mb-4">

                <label class="form-label">

                    Skills required

                </label>

                <input type="text"
                       name="skillRequired"
                       class="form-control"
                       placeholder="e.g. Java, SQL, HTML, CSS">

            </div>



            <!-- LOCATION -->

            <div class="mb-4">

                <label class="form-label">

                    Location

                </label>

                <input type="text"
                       name="location"
                       class="form-control"
                       placeholder="e.g. Kolkata / Remote">

            </div>



            <!-- DESCRIPTION -->

            <div class="mb-4">

                <label class="form-label">

                    Description

                </label>

                <textarea name="description"
                          class="form-control"
                          placeholder="Describe the role, responsibilities and requirements..."
                          required></textarea>

            </div>



            <!-- PUBLISH BUTTON -->

            <button type="submit"
                    class="submit-btn">

                <i class="bi bi-send me-2"></i>

                Publish opportunity

            </button>


        </form>



        <!-- ================= TIP ================= -->

        <div class="tip">

            <i class="bi bi-lightbulb me-2"></i>

            <strong>Tip:</strong>

            Add clear skills and requirements so students
            can quickly understand the opportunity.

        </div>


    </div>

</section>


</body>

</html>