<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String fullName =
            (String) request.getAttribute("fullName");

    String phone =
            (String) request.getAttribute("phone");

    String pincode =
            (String) request.getAttribute("pincode");

    String addressLine =
            (String) request.getAttribute("addressLine");

    String city =
            (String) request.getAttribute("city");

    String state =
            (String) request.getAttribute("state");

    String error =
            (String) request.getAttribute("error");
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0"
    >

    <title>Edit Profile — Pacelet</title>


    <link
        rel="stylesheet"
        href="<%= request.getContextPath() %>/assets/css/navbar.css"
    >


    <link
        rel="preconnect"
        href="https://fonts.googleapis.com"
    >

    <link
        rel="preconnect"
        href="https://fonts.gstatic.com"
        crossorigin
    >

    <link
        href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Plus+Jakarta+Sans:wght@500;600;700;800&display=swap"
        rel="stylesheet"
    >


    <link
        href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined"
        rel="stylesheet"
    >


    <style>

        * {
            box-sizing: border-box;
        }

        body {

            margin: 0;

            background: #f6f8fc;

            color: #191c1f;

            font-family: "Inter", sans-serif;
        }


        .edit-page {

            max-width: 850px;

            margin: auto;

            padding: 135px 24px 70px;
        }


        .edit-header {

            margin-bottom: 28px;
        }


        .edit-header h1 {

            margin: 0 0 8px;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 32px;

            font-weight: 800;

            letter-spacing: -0.03em;
        }


        .edit-header p {

            margin: 0;

            color: #52627a;

            font-size: 14px;
        }


        .edit-card {

            padding: 30px;

            background: #ffffff;

            border: 1px solid #e3e7ed;

            border-radius: 14px;
        }


        .section-title {

            margin: 0 0 22px;

            font-family:
                "Plus Jakarta Sans",
                sans-serif;

            font-size: 18px;

            font-weight: 700;
        }


        .section-divider {

            margin: 30px 0;

            border: 0;

            border-top: 1px solid #e8ebef;
        }


        .form-group {

            margin-bottom: 20px;
        }


        .form-label {

            display: block;

            margin-bottom: 8px;

            color: #52627a;

            font-size: 10px;

            font-weight: 700;

            letter-spacing: 0.09em;

            text-transform: uppercase;
        }


        .form-input {

            width: 100%;

            height: 50px;

            padding: 0 15px;

            border: 1px solid #dce1e7;

            border-radius: 8px;

            outline: none;

            background: #f8fafc;

            color: #191c1f;

            font-family: "Inter", sans-serif;

            font-size: 14px;

            transition:
                border-color 0.2s ease,
                box-shadow 0.2s ease;
        }


        textarea.form-input {

            height: 105px;

            padding-top: 14px;

            resize: vertical;
        }


        .form-input:focus {

            border-color: #9b82a0;

            box-shadow:
                0 0 0 3px
                rgba(167, 139, 250, 0.12);
        }


        .form-row {

            display: grid;

            grid-template-columns: 1fr 1fr;

            gap: 16px;
        }


        .error-message {

            margin-bottom: 22px;

            padding: 12px 14px;

            border-radius: 8px;

            background: #fef2f2;

            border: 1px solid #fecaca;

            color: #dc2626;

            font-size: 13px;
        }


        .actions {

            display: flex;

            gap: 12px;

            margin-top: 30px;
        }


        .button {

            flex: 1;

            height: 48px;

            border-radius: 7px;

            display: flex;

            align-items: center;

            justify-content: center;

            text-decoration: none;

            cursor: pointer;

            font-size: 11px;

            font-weight: 800;

            letter-spacing: 0.08em;

            text-transform: uppercase;
        }


        .save-button {

            border: none;

            background: #060607;

            color: #ffffff;
        }


        .save-button:hover {

            background: #222222;
        }


        .cancel-button {

            border: 1px solid #d7dce3;

            background: #ffffff;

            color: #191c1f;
        }


        .cancel-button:hover {

            background: #f8fafc;
        }


        @media (max-width: 600px) {

            .edit-page {

                padding: 115px 16px 60px;
            }


            .edit-card {

                padding: 22px;
            }


            .edit-header h1 {

                font-size: 28px;
            }


            .form-row {

                grid-template-columns: 1fr;

                gap: 0;
            }


            .actions {

                flex-direction: column;
            }

        }


        
/* ===== PACELET EDIT PROFILE RESPONSIVE ===== */

.edit-page {
    width: 100%;
    max-width: 900px;
    margin: 0 auto;
    padding: 120px 24px 60px;
    min-width: 0;
}

.edit-card {
    width: 100%;
    min-width: 0;
}

.edit-header h1 {
    line-height: 1.2;
}

.form-row {
    grid-template-columns: repeat(2, minmax(0, 1fr));
}

.form-group {
    min-width: 0;
}

.form-input {
    min-width: 0;
    max-width: 100%;
}

.actions {
    display: flex;
    flex-wrap: wrap;
}

.button {
    min-width: 0;
}

/* Tablet */
@media (max-width: 760px) {
    .edit-page {
        padding: 108px 20px 48px;
    }

    .edit-card {
        padding: 24px;
    }

    .edit-header h1 {
        font-size: 29px;
    }
}

/* Mobile */
@media (max-width: 600px) {
    .edit-page {
        padding: 94px 14px 36px;
    }

    .edit-header {
        margin-bottom: 20px;
    }

    .edit-header h1 {
        font-size: clamp(25px, 7vw, 29px);
    }

    .edit-header p {
        font-size: 12px;
        line-height: 1.7;
    }

    .edit-card {
        padding: 18px 15px;
        border-radius: 12px;
    }

    .section-title {
        font-size: 16px;
        margin-bottom: 18px;
    }

    .section-divider {
        margin: 24px 0;
    }

    .form-row {
        grid-template-columns: minmax(0, 1fr);
        gap: 0;
    }

    .form-group {
        margin-bottom: 17px;
    }

    .form-label {
        font-size: 10px;
    }

    .form-input {
        height: 47px;
        padding: 0 12px;
        font-size: 13px;
    }

    textarea.form-input {
        min-height: 100px;
        height: auto;
        padding-top: 12px;
    }

    .actions {
        flex-direction: column-reverse;
        gap: 10px;
        margin-top: 22px;
    }

    .button {
        width: 100%;
        min-height: 46px;
        flex: none;
        font-size: 10px;
    }
}

/* Very small screens */
@media (max-width: 360px) {
    .edit-page {
        padding-right: 9px;
        padding-left: 9px;
    }

    .edit-card {
        padding: 15px 12px;
    }

    .edit-header h1 {
        font-size: 25px;
    }

    .form-input {
        font-size: 12px;
    }
}


    </style>

</head>


<body>


    <%@ include file="/WEB-INF/views/common/navbar.jsp" %>


    <main class="edit-page">


        <section class="edit-header">

            <h1>
                Edit Profile
            </h1>

            <p>
                Update your Pacelet account information.
            </p>

        </section>


        <section class="edit-card">


            <% if (error != null) { %>

                <div class="error-message">
                    <%= error %>
                </div>

            <% } %>


            <form
                method="post"
                action="<%= request.getContextPath() %>/profile/edit"
            >


                <!-- =========================
                     PERSONAL INFORMATION
                ========================== -->

                <h2 class="section-title">
                    Personal Information
                </h2>


                <div class="form-group">

                    <label class="form-label">
                        Full Name *
                    </label>

                    <input
                        type="text"
                        name="fullName"
                        class="form-input"
                        placeholder="Enter your full name"
                        value="<%= fullName != null ? fullName : "" %>"
                        required
                    >

                </div>


                <div class="form-group">

                    <label class="form-label">
                        Phone *
                    </label>

                    <input
                        type="tel"
                        name="phone"
                        class="form-input"
                        placeholder="10-digit mobile number"
                        maxlength="10"
                        value="<%= phone != null ? phone : "" %>"
                        required
                    >

                </div>


                <hr class="section-divider">


                <!-- =========================
                     DELIVERY ADDRESS
                ========================== -->

                <h2 class="section-title">
                    Delivery Address
                </h2>


                <!-- PINCODE + CITY -->

                <div class="form-row">


                    <div class="form-group">

                        <label class="form-label">
                            Pincode *
                        </label>

                        <input
                            type="text"
                            name="pincode"
                            class="form-input"
                            placeholder="6-digit pincode"
                            maxlength="6"
                            value="<%= pincode != null ? pincode : "" %>"
                            required
                        >

                    </div>


                    <div class="form-group">

                        <label class="form-label">
                            City *
                        </label>

                        <input
                            type="text"
                            name="city"
                            class="form-input"
                            placeholder="Enter city"
                            value="<%= city != null ? city : "" %>"
                            required
                        >

                    </div>

                </div>


                <!-- STATE -->

                <div class="form-group">

                    <label class="form-label">
                        State *
                    </label>

                    <input
                        type="text"
                        name="state"
                        class="form-input"
                        placeholder="Enter state"
                        value="<%= state != null ? state : "" %>"
                        required
                    >

                </div>


                <!-- ADDRESS -->

                <div class="form-group">

                    <label class="form-label">
                        Street & Building Address *
                    </label>

                    <textarea
                        name="addressLine"
                        class="form-input"
                        placeholder="Flat / House No., Apartment, Street"
                        required
                    ><%= addressLine != null ? addressLine : "" %></textarea>

                </div>


                <!-- =========================
                     ACTIONS
                ========================== -->

                <div class="actions">


                    <a
                        href="<%= request.getContextPath() %>/profile"
                        class="button cancel-button"
                    >
                        Cancel
                    </a>


                    <button
                        type="submit"
                        class="button save-button"
                    >
                        Save Changes →
                    </button>


                </div>


            </form>

        </section>


    </main>


</body>

</html>