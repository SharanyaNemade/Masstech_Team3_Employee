<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employee_Details.aspx.cs" Inherits="Masstech_Team3_Employee.Employee_Details" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Details</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>


    <style>
        body {
            background-color: #f4f6f9;
        }

        .profile-card {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
        }

        .profile-header {
            background: linear-gradient(to right, #ff7a00, #ffb347);
            height: 120px;
            position: relative;
        }

        .profile-img {
            width: 90px;
            height: 90px;
            border-radius: 50%;
            border: 5px solid #fff;
            position: absolute;
            bottom: -45px;
            left: 50%;
            transform: translateX(-50%);
            background: #fff;
        }

        .profile-body {
            padding-top: 60px;
        }

        .info-label {
            font-weight: 600;
            color: #6c757d;
            font-size: 14px;
        }

        .info-value {
            font-size: 14px;
        }

        .edit-btn {
            background-color: #0d1b2a;
            color: #fff;
        }

        .section-card {
            border-radius: 8px;
            box-shadow: 0 1px 6px rgba(0,0,0,0.05);
        }

        .section-header {
            font-weight: 600;
            font-size: 15px;
        }

        .icon-actions i {
            cursor: pointer;
            margin-left: 10px;
            color: #6c757d;
        }

        .icon-actions i:hover {
            color: #000;
        }
    </style>
</head>
<body>

<form id="form1" runat="server">

<div class="container-fluid mt-4">
    <div class="row">

        <!-- LEFT PROFILE CARD -->
        <div class="col-md-4">

            <div class="card profile-card">

                <div class="profile-header">
                    <img src="https://cdn-icons-png.flaticon.com/512/3135/3135715.png"
                        class="profile-img" />
                </div>

                <div class="card-body profile-body text-center">

                    <h5 class="mb-0">admin a <i class="fa-solid fa-circle-check text-success"></i></h5>
                    <span class="badge bg-light text-dark mt-1">Software Developer</span>

                    <hr />

                    <div class="row text-start">
                        <div class="col-6 info-label">Client ID</div>
                        <div class="col-6 text-end info-value">1</div>

                        <div class="col-6 info-label">Department</div>
                        <div class="col-6 text-end info-value">Not Applicable</div>

                        <div class="col-6 info-label">Date Of Join</div>
                        <div class="col-6 text-end info-value">2/11/2025</div>

                        <div class="col-6 info-label">Report Office</div>
                        <div class="col-6 text-end info-value">Mumbai</div>
                    </div>

                    <button type="button" class="btn edit-btn w-100 mt-3">
                        <i class="fa-solid fa-pen"></i> Edit Info
                    </button>

                    <hr />

                    <h6 class="text-start fw-bold">Basic Information</h6>

                    <div class="row text-start mt-2">
                        <div class="col-6 info-label">Phone</div>
                        <div class="col-6 text-end info-value">1222222222</div>

                        <div class="col-6 info-label">Email</div>
                        <div class="col-6 text-end info-value text-primary">
                            admin@gmail.com
                        </div>

                        <div class="col-6 info-label">Gender</div>
                        <div class="col-6 text-end info-value">Male</div>

                        <div class="col-6 info-label">Birthday</div>
                        <div class="col-6 text-end info-value">2/11/2025</div>

                        <div class="col-6 info-label">Address</div>
                        <div class="col-6 text-end info-value">Mumbai</div>
                    </div>

                </div>
            </div>

        </div>

        <!-- RIGHT SIDE SECTIONS -->
        <div class="col-md-8">

            <!-- About Employee -->
            <div class="card section-card mb-3">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span class="section-header">About Employee</span>
                    <div class="icon-actions">
                        <i class="fa-solid fa-pen"></i>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                </div>
                <div class="card-body">
                    I am Software developer
                </div>
            </div>

            <!-- Bank Information -->
            <div class="card section-card mb-3">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span class="section-header">Bank Information</span>
                    <div class="icon-actions">
                        <i class="fa-solid fa-plus"></i>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                </div>
            </div>

            <!-- Family Information -->
            <div class="card section-card mb-3">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span class="section-header">Family Information</span>
                    <div class="icon-actions">
                        <i class="fa-solid fa-plus"></i>
                        <i class="fa-solid fa-chevron-down"></i>
                    </div>
                </div>
            </div>

            <div class="row">

                <!-- Education -->
                <div class="col-md-6">
                    <div class="card section-card mb-3">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span class="section-header">Education Details</span>
                            <div class="icon-actions">
                                <i class="fa-solid fa-plus"></i>
                                <i class="fa-solid fa-chevron-down"></i>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Experience -->
                <div class="col-md-6">
                    <div class="card section-card mb-3">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <span class="section-header">Experience</span>
                            <div class="icon-actions">
                                <i class="fa-solid fa-plus"></i>
                                <i class="fa-solid fa-chevron-down"></i>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>
</div>

</form>

</body>
</html>