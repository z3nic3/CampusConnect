
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login | CampusConnect</title>

    <!-- ================= BOOTSTRAP ================= -->

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- ================= BOOTSTRAP ICONS ================= -->

    <link rel="stylesheet"
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
            min-height: 100vh;

            font-family: "Segoe UI", Arial, sans-serif;

            background: #071426;
            color: #f5f1e8;
        }


        
       


        /* ================================================= */
        /* ================= NAVBAR ======================== */
        /* ================================================= */

        .navbar-custom {
    padding: 22px 0;

    background: rgba(7, 20, 38, .95);

    border-bottom:
        1px solid rgba(214, 173, 82, .18);
}

        /* ================================================= */
        /* ================= BRAND ========================= */
        /* ================================================= */

        .brand {
            color: #f5f1e8;

            text-decoration: none;

            font-size: 25px;
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
                0 0 8px rgba(214, 173, 82, .35);
        }

        .brand:hover i {
            text-shadow:
                0 0 10px rgba(214, 173, 82, .9);
        }


        /* ================================================= */
        /* ================= HOME BUTTON ==================== */
        /* ================================================= */

        .home-link {
            display: inline-flex;

            align-items: center;
            justify-content: center;

            gap: 5px;

            color: #d6ad52;

            text-decoration: none;

            font-weight: 650;

            padding: 9px 18px;

            border:
                1px solid rgba(214, 173, 82, .55);

            border-radius: 8px;

            transition: all .3s ease;

            box-shadow:
                0 0 6px rgba(214, 173, 82, .35),
                0 0 14px rgba(214, 173, 82, .12);
        }

        .home-link:hover {
            background: #d6ad52;
            color: #071426;

            transform: translateY(-2px);

            box-shadow:
                0 0 8px rgba(214, 173, 82, .9),
                0 0 18px rgba(214, 173, 82, .65),
                0 0 30px rgba(214, 173, 82, .35);
        }

        .home-link:active {
            transform: translateY(0);

            box-shadow:
                0 0 5px rgba(214, 173, 82, .7);
        }


        /* ================================================= */
        /* ================= LOGIN SECTION ================== */
        /* ================================================= */

        .login-section {
            min-height: calc(100vh - 90px);

            display: flex;

            align-items: center;

            padding: 50px 0;

            position: relative;

            overflow: hidden;
        }


        /* ================================================= */
        /* ================= BACKGROUND CIRCLE ============= */
        /* ================================================= */

        .login-section::before {
            content: "";

            position: absolute;

            width: 420px;
            height: 420px;

            border-radius: 50%;

            border:
                1px solid rgba(214, 173, 82, .12);

            right: -160px;
            top: -150px;
        }

        .login-section::after {
            content: "";

            position: absolute;

            width: 280px;
            height: 280px;

            border-radius: 50%;

            background:
                rgba(214, 173, 82, .04);

            left: -120px;
            bottom: -120px;
        }


        /* ================================================= */
        /* ================= LOGIN CARD ===================== */
        /* ================================================= */

        .login-card {
            max-width: 950px;

            margin: auto;

            background: #0a1a2e;

            border:
                1px solid rgba(214, 173, 82, .20);

            border-radius: 22px;

            overflow: hidden;

            box-shadow:
                0 25px 70px rgba(0, 0, 0, .35);

            position: relative;

            z-index: 2;
        }


        /* ================================================= */
        /* ================= LEFT SIDE ====================== */
        /* ================================================= */

        .login-info {
            height: 100%;

            min-height: 600px;

            padding: 55px;

            background:
                linear-gradient(
                    145deg,
                    #10263f,
                    #0b1b2f
                );

            display: flex;

            flex-direction: column;

            justify-content: center;

            border-right:
                1px solid rgba(214, 173, 82, .12);
        }


        /* ================================================= */
        /* ================= GOLD LINE ====================== */
        /* ================================================= */

        .gold-line {
            width: 45px;
            height: 3px;

            background: #d6ad52;

            margin-bottom: 25px;

            box-shadow:
                0 0 10px rgba(214, 173, 82, .45);
        }


        /* ================================================= */
        /* ================= LEFT CONTENT =================== */
        /* ================================================= */

        .login-info h1 {
            font-size: 45px;

            font-weight: 800;

            letter-spacing: -2px;
        }

        .login-info p {
            color: #9da8b5;

            line-height: 1.7;

            max-width: 400px;
        }


        /* ================================================= */
        /* ================= INFO ITEMS ===================== */
        /* ================================================= */

        .info-item {
            margin-top: 28px;

            display: flex;

            align-items: center;

            gap: 13px;

            color: #c4ccd5;
        }

        .info-item i {
            color: #d6ad52;

            font-size: 20px;

            text-shadow:
                0 0 8px rgba(214, 173, 82, .45);
        }


        /* ================================================= */
        /* ================= LOGIN FORM ===================== */
        /* ================================================= */

        .login-form {
            padding: 55px;

            background: #0a1a2e;
        }

        .login-form h2 {
            font-size: 32px;

            font-weight: 750;
        }

        .subtitle {
            color: #7f8a98;

            margin-bottom: 32px;
        }


        /* ================================================= */
        /* ================= FORM LABEL ===================== */
        /* ================================================= */

        .form-label {
            color: #e8e4db;

            font-weight: 650;

            margin-bottom: 8px;
        }


        /* ================================================= */
        /* ================= INPUT GROUP ==================== */
        /* ================================================= */

        .input-group-text {
            background: #10263f;

            border-color:
                rgba(255, 255, 255, .12);

            color: #d6ad52;
        }


        /* ================================================= */
        /* ================= FORM CONTROL =================== */
        /* ================================================= */

        .form-control {
            padding: 13px;

            background: #071426;

            border-color:
                rgba(255, 255, 255, .12);

            color: #f5f1e8;
        }

        .form-control::placeholder {
            color: #667384;
        }

        .form-control:focus {
            background: #071426;

            color: #f5f1e8;

            border-color: #d6ad52;

            box-shadow:
                0 0 0 3px rgba(214, 173, 82, .12);
        }


        /* ================================================= */
        /* ================= LOGIN AS ======================= */
        /* ================================================= */

        .role-select {
            width: 100%;

            padding: 13px 15px;

            background-color: #071426;

            color: #f5f1e8;

            border:
                1px solid rgba(255, 255, 255, .12);

            border-radius: 7px;

            cursor: pointer;

            transition: all .3s ease;

            box-shadow:
                0 0 6px rgba(214, 173, 82, .08);
        }

        .role-select:hover {
            border-color:
                rgba(214, 173, 82, .45);

            box-shadow:
                0 0 8px rgba(214, 173, 82, .15);
        }

        .role-select:focus {
            outline: none;

            border-color: #d6ad52;

            box-shadow:
                0 0 0 3px rgba(214, 173, 82, .12),
                0 0 15px rgba(214, 173, 82, .20);
        }

        .role-select option {
            background: #071426;

            color: #f5f1e8;
        }


        /* ================================================= */
        /* ================= LOGIN BUTTON =================== */
        /* ================================================= */

        .login-btn {
            width: 100%;

            padding: 13px 20px;

            border: none;

            border-radius: 9px;

            background: #d6ad52;

            color: #071426;

            font-weight: 750;

            cursor: pointer;

            transition: all .3s ease;

            box-shadow:
                0 0 8px rgba(214, 173, 82, .45),
                0 8px 25px rgba(214, 173, 82, .18);
        }

        .login-btn:hover {
            background: #e3be68;

            color: #071426;

            transform: translateY(-3px);

            box-shadow:
                0 0 10px rgba(214, 173, 82, 1),
                0 0 22px rgba(214, 173, 82, .7),
                0 12px 35px rgba(214, 173, 82, .30);
        }

        .login-btn:active {
            transform: translateY(0);

            box-shadow:
                0 0 8px rgba(214, 173, 82, .7);
        }


        /* ================================================= */
        /* ================= REGISTER ======================= */
        /* ================================================= */

        .register-text {
            text-align: center;

            margin-top: 25px;

            color: #7f8a98;
        }

        .register-text a {
            display: inline-block;

            color: #d6ad52;

            font-weight: 700;

            text-decoration: none;

            padding: 4px 8px;

            border-radius: 6px;

            transition: all .3s ease;
        }

        .register-text a:hover {
            color: #e3be68;

            background:
                rgba(214, 173, 82, .06);

            text-shadow:
                0 0 8px rgba(214, 173, 82, .8);

            box-shadow:
                0 0 10px rgba(214, 173, 82, .18);
        }


        /* ================================================= */
        /* ================= ERROR ========================== */
        /* ================================================= */

        .alert {
            background:
                rgba(180, 70, 70, .12);

            border:
                1px solid rgba(220, 100, 100, .25);

            color: #e8b5b5;

            border-radius: 9px;
        }


        /* ================================================= */
        /* ================= TABLET ========================= */
        /* ================================================= */

        @media (max-width: 991px) {

            .login-card {
                max-width: 720px;
            }

            .login-info {
                min-height: auto;

                padding: 45px;
            }

            .login-form {
                padding: 45px;
            }

        }


        /* ================================================= */
        /* ================= MOBILE ========================= */
        /* ================================================= */

        @media (max-width: 768px) {

            .navbar-custom {
                padding: 18px 15px;
            }

            .brand {
                font-size: 21px;
            }

            .home-link {
                padding: 8px 13px;

                font-size: 14px;
            }

            .login-section {
                min-height: auto;

                padding: 35px 15px;
            }

            .login-info {
                min-height: auto;

                padding: 40px 30px;

                border-right: none;

                border-bottom:
                    1px solid rgba(214, 173, 82, .12);
            }

            .login-info h1 {
                font-size: 38px;

                letter-spacing: -1.5px;
            }

            .login-form {
                padding: 40px 30px;
            }

            .login-form h2 {
                font-size: 28px;
            }

            .login-btn {
                padding: 14px;

                font-size: 15px;
            }

        }


        /* ================================================= */
        /* ================= SMALL MOBILE =================== */
        /* ================================================= */

        @media (max-width: 480px) {

            .navbar-custom {
                padding: 15px 12px;
            }

            .brand {
                font-size: 18px;
            }

            .brand i {
                margin-right: 4px;
            }

            .home-link {
                padding: 7px 10px;

                font-size: 13px;
            }

            .login-section {
                padding: 25px 10px;
            }

            .login-card {
                border-radius: 16px;
            }

            .login-info {
                padding: 32px 22px;
            }

            .login-form {
                padding: 32px 22px;
            }

            .login-info h1 {
                font-size: 34px;
            }

            .login-info p {
                font-size: 14px;
            }

            .info-item {
                margin-top: 20px;

                font-size: 14px;
            }

            .login-form h2 {
                font-size: 26px;
            }

            .subtitle {
                font-size: 14px;

                margin-bottom: 25px;
            }

            .form-label {
                font-size: 14px;
            }

            .form-control,
            .role-select {
                padding: 12px;

                font-size: 14px;
            }

            .input-group-text {
                padding: 10px 12px;
            }

            .login-btn {
                padding: 13px;

                font-size: 14px;
            }

            .register-text {
                font-size: 14px;
            }

        }


        /* ================================================= */
        /* ================= VERY SMALL ===================== */
        /* ================================================= */

        @media (max-width: 360px) {

            .brand {
                font-size: 16px;
            }

            .home-link {
                padding: 6px 8px;

                font-size: 12px;
            }

            .login-info {
                padding: 28px 18px;
            }

            .login-form {
                padding: 28px 18px;
            }

            .login-info h1 {
                font-size: 30px;
            }

        }

    </style>

</head>


<body>

<!-- ================================================= -->
<!-- ================= NAVBAR ========================= -->
<!-- ================================================= -->

<nav class="navbar-custom">

    <div class="container">

        <div class="d-flex justify-content-between align-items-center">


            <!-- ================= LEFT SIDE ================= -->

            <div class="d-flex align-items-center gap-3">


                <!-- ================= BRAND ================= -->

                <a href="index.jsp" class="brand">

                    <i class="bi bi-mortarboard-fill"></i>

                    CampusConnect

                </a>


            </div>


            <!-- ================= HOME ================= -->

            <a href="index.jsp" class="home-link">

                <i class="bi bi-arrow-left"></i>

                Home

            </a>


        </div>

    </div>

</nav>


    <!-- ================================================= -->
    <!-- ================= LOGIN SECTION ================== -->
    <!-- ================================================= -->

    <section class="login-section">

        <div class="container">

            <div class="row login-card">


                <!-- ================================================= -->
                <!-- ================= LEFT SIDE ====================== -->
                <!-- ================================================= -->

                <div class="col-lg-6">

                    <div class="login-info">


                        <div class="gold-line"></div>


                        <h1>

                            Welcome<br>

                            <span style="color:#d6ad52;">

                                back.

                            </span>

                        </h1>


                        <p class="mt-3">

                            Sign in to continue exploring

                            opportunities and connecting

                            with your campus community.

                        </p>


                        <!-- ================= INFO ITEM 1 ================= -->

                        <div class="info-item">

                            <i class="bi bi-compass"></i>

                            Discover opportunities

                        </div>


                        <!-- ================= INFO ITEM 2 ================= -->

                        <div class="info-item">

                            <i class="bi bi-building"></i>

                            Connect with companies

                        </div>


                        <!-- ================= INFO ITEM 3 ================= -->

                        <div class="info-item">

                            <i class="bi bi-rocket-takeoff"></i>

                            Build your career

                        </div>


                    </div>

                </div>


                <!-- ================================================= -->
                <!-- ================= RIGHT SIDE ===================== -->
                <!-- ================================================= -->

                <div class="col-lg-6">

                    <div class="login-form">


                        <h2>

                            Sign in

                        </h2>


                        <p class="subtitle">

                            Enter your details to continue.

                        </p>


                        <!-- ================= ERROR MESSAGE ================= -->

                        <% if (request.getAttribute("error") != null) { %>

                            <div class="alert mb-4">

                                <i class="bi bi-exclamation-circle me-2"></i>

                                <%= request.getAttribute("error") %>

                            </div>

                        <% } %>


                        <!-- ================================================= -->
                        <!-- ================= LOGIN FORM ====================== -->
                        <!-- ================================================= -->

                        <form action="login" method="post">


                            <!-- ================= EMAIL ================= -->

                            <div class="mb-4">

                                <label class="form-label">

                                    Email address

                                </label>


                                <div class="input-group">

                                    <span class="input-group-text">

                                        <i class="bi bi-envelope"></i>

                                    </span>


                                    <input type="email"
                                           name="email"
                                           class="form-control"
                                           placeholder="you@example.com"
                                           required>

                                </div>

                            </div>


                            <!-- ================= PASSWORD ================= -->

                            <div class="mb-4">

                                <label class="form-label">

                                    Password

                                </label>


                                <div class="input-group">

                                    <span class="input-group-text">

                                        <i class="bi bi-lock"></i>

                                    </span>


                                    <input type="password"
                                           name="password"
                                           class="form-control"
                                           placeholder="Enter your password"
                                           required>

                                </div>

                            </div>


                            <!-- ================= LOGIN AS ================= -->

                            <div class="mb-4">

                                <label class="form-label">

                                    Login as

                                </label>


                                <select name="loginRole"
                                        class="role-select"
                                        required>

                                    <option value=""
                                            selected
                                            disabled>

                                        Select your role

                                    </option>


                                    <option value="STUDENT">

                                        Student

                                    </option>


                                    <option value="COMPANY">

                                        Company

                                    </option>


                                    <option value="ADMIN">

                                        Admin

                                    </option>

                                </select>

                            </div>


                            <!-- ================= LOGIN BUTTON ================= -->

                            <button type="submit"
                                    class="login-btn">

                                Sign in

                                <i class="bi bi-arrow-right ms-2"></i>

                            </button>


                        </form>


                        <!-- ================================================= -->
                        <!-- ================= REGISTER ======================= -->
                        <!-- ================================================= -->

                        <div class="register-text">

                            Don't have an account?

                            <a href="register.jsp">

                                Create one

                            </a>

                        </div>


                    </div>

                </div>


            </div>

        </div>

    </section>


</body>

</html>

