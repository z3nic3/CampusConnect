<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Register | CampusConnect</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">


    <style>
       
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


        /* ================= NAVBAR ================= */

        .navbar-custom {
            padding: 22px 0;
            background: rgba(7,20,38,.95);
            border-bottom: 1px solid rgba(214,173,82,.18);
        }

        .brand {
            color: #f5f1e8;
            text-decoration: none;
            font-size: 25px;
            font-weight: 750;
        }

        .brand i {
            color: #d6ad52;
            margin-right: 8px;
        }

        .home-link {
            color: #d6ad52;
            text-decoration: none;
            font-weight: 650;
            transition: .25s;
        }

        /* ================= HOME BUTTON ================= */

.home-link {
    display: inline-flex;
    align-items: center;
    gap: 5px;

    color: #d6ad52;
    text-decoration: none;

    font-weight: 650;

    padding: 9px 18px;

    border: 1px solid rgba(214,173,82,.5);

    border-radius: 8px;

    transition: all .3s ease;

    /* GOLD GLOW */
    box-shadow:
        0 0 6px rgba(214,173,82,.45),
        0 0 14px rgba(214,173,82,.20);
}

/* HOVER GLOW */

.home-link:hover {
    background: #d6ad52;

    color: #071426;

    transform: translateY(-2px);

    box-shadow:
        0 0 8px rgba(214,173,82,.9),
        0 0 18px rgba(214,173,82,.6),
        0 0 30px rgba(214,173,82,.35);
}


/* ================= MOBILE ================= */

@media(max-width: 576px) {

    .navbar-custom {
        padding: 18px 15px;
    }

    .brand {
        font-size: 20px;
    }

    .home-link {
        padding: 8px 13px;
        font-size: 14px;
    }

    .home-link i {
        margin-right: 2px !important;
    }
}


/* ================= VERY SMALL SCREEN ================= */

@media(max-width: 380px) {

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

}


        /* ================= REGISTER SECTION ================= */

        .register-section {
            min-height: calc(100vh - 90px);
            display: flex;
            align-items: center;
            padding: 50px 0;
        }


        .register-card {
            max-width: 1050px;
            margin: auto;

            background: #0a1a2e;

            border: 1px solid rgba(214,173,82,.20);

            border-radius: 22px;

            overflow: hidden;

            box-shadow:
                0 25px 70px rgba(0,0,0,.35);
        }


        /* ================= LEFT SIDE ================= */

        .register-info {
            height: 100%;
            min-height: 620px;

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
        }


        .gold-line {
            width: 45px;
            height: 3px;

            background: #d6ad52;

            margin-bottom: 25px;
        }


        .register-info h1 {
            font-size: 45px;

            font-weight: 800;

            letter-spacing: -2px;
        }


        .register-info p {
            color: #9da8b5;

            line-height: 1.7;
        }


        /* ================= ROLE CARD ================= */

        .role-card {
            margin-top: 30px;

            padding: 20px;

            background:
                rgba(214,173,82,.06);

            border:
                1px solid rgba(214,173,82,.18);

            border-radius: 13px;
        }


        .role-card i {
            color: #d6ad52;

            margin-right: 8px;
        }


        /* ================= FORM ================= */

        .register-form {
            padding: 55px;
        }


        .register-form h2 {
            font-size: 32px;

            font-weight: 750;
        }


        .subtitle {
            color: #7f8a98;

            margin-bottom: 32px;
        }


        .form-label {
            font-weight: 650;
        }


        /* ================= INPUTS ================= */

        .input-group-text {
            background: #10263f;

            border-color:
                rgba(255,255,255,.12);

            color: #d6ad52;
        }


        .form-control,
        .form-select {

            padding: 13px;

            background: #071426;

            border-color:
                rgba(255,255,255,.12);

            color: #f5f1e8;
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
                0 0 0 3px rgba(214,173,82,.12);
        }


        /* ================= REGISTER BUTTON ================= */

        .register-btn {

            width: 100%;

            padding: 13px;

            border: none;

            border-radius: 9px;

            background: #d6ad52;

            color: #071426;

            font-weight: 750;

            transition: all .3s ease;


            /* PERMANENT GOLD GLOW */

            box-shadow:
                0 0 6px rgba(214,173,82,.55),
                0 0 15px rgba(214,173,82,.35),
                0 8px 25px rgba(214,173,82,.18);
        }


        .register-btn:hover {

            background: #e3be68;

            color: #071426;

            transform: translateY(-3px);


            /* STRONGER GLOW */

            box-shadow:
                0 0 8px rgba(214,173,82,.9),
                0 0 20px rgba(214,173,82,.65),
                0 0 35px rgba(214,173,82,.35);
        }


        /* ================= LOGIN TEXT ================= */

        .login-text {

            text-align: center;

            margin-top: 25px;

            color: #7f8a98;
        }


        .login-text a {

            color: #d6ad52;

            font-weight: 700;

            text-decoration: none;

            transition: .25s;

            text-shadow:
                0 0 5px rgba(214,173,82,.2);
        }


        .login-text a:hover {

            color: #e3be68;

            text-shadow:
                0 0 8px rgba(214,173,82,.6);
        }


        /* ================= ALERT ================= */

        .alert {

            background:
                rgba(180,70,70,.12);

            border:
                1px solid rgba(220,100,100,.25);

            color: #e8b5b5;
        }


        /* ================= RESPONSIVE ================= */

        @media(max-width: 768px) {

            .register-section {
                padding: 30px 15px;
            }


            .register-info {

                min-height: auto;

                padding: 40px;
            }


            .register-info h1 {
                font-size: 38px;
            }


            .register-form {

                padding: 40px;
            }

        }


        @media(max-width: 480px) {

            .navbar-custom {
                padding: 18px 15px;
            }


            .brand {
                font-size: 21px;
            }


            .home-link {
                font-size: 14px;
            }


            .register-info {
                padding: 30px 25px;
            }


            .register-form {
                padding: 30px 25px;
            }


            .register-info h1 {
                font-size: 34px;
            }


            .register-form h2 {
                font-size: 27px;
            }


            .register-card {
                border-radius: 16px;
            }

        }

    </style>

</head>


<body>


<!-- ================= NAVBAR ================= -->

<nav class="navbar-custom">

    <div class="container">

        <div class="d-flex justify-content-between align-items-center">

            <a href="index.jsp" class="brand">

                <i class="bi bi-mortarboard-fill"></i>

                CampusConnect

            </a>


            <a href="index.jsp" class="home-link">

                <i class="bi bi-arrow-left me-1"></i>

                Home

            </a>

        </div>

    </div>

</nav>



<!-- ================= REGISTER ================= -->

<section class="register-section">

    <div class="container">

        <div class="row register-card">


            <!-- ================= LEFT ================= -->

            <div class="col-lg-5">

                <div class="register-info">

                    <div class="gold-line"></div>


                    <h1>

                        Build your<br>

                        <span style="color:#d6ad52;">

                            next chapter.

                        </span>

                    </h1>


                    <p class="mt-3">

                        Create your CampusConnect account and

                        become part of a community connecting

                        students with real opportunities.

                    </p>


                    <div class="role-card">

                        <div class="fw-bold mb-2">

                            <i class="bi bi-stars"></i>

                            One platform. Endless possibilities.

                        </div>


                        <small style="color:#8793a1;">

                            Students discover opportunities.

                            Companies discover talent.

                        </small>

                    </div>

                </div>

            </div>



            <!-- ================= RIGHT ================= -->

            <div class="col-lg-7">

                <div class="register-form">

                    <h2>

                        Create account

                    </h2>


                    <p class="subtitle">

                        Join CampusConnect today.

                    </p>



                    <!-- ERROR MESSAGE -->

                    <% if (request.getAttribute("error") != null) { %>

                        <div class="alert mb-4">

                            <i class="bi bi-exclamation-circle me-2"></i>

                            <%= request.getAttribute("error") %>

                        </div>

                    <% } %>



                    <!-- ================= FORM ================= -->

                    <form action="register" method="post">


                        <!-- NAME -->

                        <div class="mb-3">

                            <label class="form-label">

                                Full name

                            </label>


                            <div class="input-group">

                                <span class="input-group-text">

                                    <i class="bi bi-person"></i>

                                </span>


                                <input

                                    type="text"

                                    name="name"

                                    class="form-control"

                                    placeholder="Enter your name"

                                    required>

                            </div>

                        </div>



                        <!-- EMAIL -->

                        <div class="mb-3">

                            <label class="form-label">

                                Email address

                            </label>


                            <div class="input-group">

                                <span class="input-group-text">

                                    <i class="bi bi-envelope"></i>

                                </span>


                                <input

                                    type="email"

                                    name="email"

                                    class="form-control"

                                    placeholder="you@example.com"

                                    required>

                            </div>

                        </div>



                        <!-- PASSWORD -->

                        <div class="mb-3">

                            <label class="form-label">

                                Password

                            </label>


                            <div class="input-group">

                                <span class="input-group-text">

                                    <i class="bi bi-lock"></i>

                                </span>


                                <input

                                    type="password"

                                    name="password"

                                    class="form-control"

                                    placeholder="Create a password"

                                    required>

                            </div>

                        </div>



                        <!-- ROLE -->

                        <div class="mb-4">

                            <label class="form-label">

                                I am registering as

                            </label>


                            <div class="input-group">

                                <span class="input-group-text">

                                    <i class="bi bi-person-badge"></i>

                                </span>


                                <select

                                    name="role"

                                    class="form-select"

                                    required>


                                    <option value="" selected disabled>

                                        Select your role

                                    </option>


                                    <option value="STUDENT">

                                        Student

                                    </option>


                                    <option value="COMPANY">

                                        Company

                                    </option>


                                </select>

                            </div>

                        </div>



                        <!-- SUBMIT BUTTON -->

                        <button

                            type="submit"

                            class="register-btn">

                            Create account

                            <i class="bi bi-arrow-right ms-2"></i>

                        </button>


                    </form>



                    <!-- LOGIN -->

                    <div class="login-text">

                        Already have an account?

                        <a href="login.jsp">

                            Sign in

                        </a>

                    </div>


                </div>

            </div>


        </div>

    </div>

</section>


</body>

</html>