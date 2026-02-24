<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="NavigationBar.aspx.cs" Inherits="Masstech_Team3_Employee.NavigationBar" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Navigation</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        body {
            margin: 0;
        }

        .sidebar {
            width: 240px;
            position: fixed;
            height: 100%;
            background: #ffffff;
            border-right: 1px solid #e3e6f0;
            padding-top: 20px;
        }

        .sidebar a {
            display: block;
            padding: 10px 20px;
            color: #333;
            text-decoration: none;
            font-size: 14px;
        }

        .sidebar a:hover {
            background: #f8f9fc;
            color: #ff6a00;
        }

        .sidebar h5 {
            margin-bottom: 20px;
        }

        /* Arrow rotation */
        .dropdown-arrow {
            transition: transform 0.3s ease;
        }

        a[aria-expanded="true"] .dropdown-arrow {
            transform: rotate(180deg);
        }
    </style>

</head>
<body>
<form id="form1" runat="server">

<div class="sidebar">

    <h5 class="text-center"><b>Pulse360</b></h5>

    <a href="Dashboard.aspx">
        <i class="fa fa-home me-2"></i>Dashboard
    </a>

    <a href="Employee_List.aspx">
        <i class="fa fa-users me-2"></i>Employees
    </a>

    <!-- Performance -->
    <a class="d-flex justify-content-between align-items-center"
       data-bs-toggle="collapse"
       href="#performanceMenu"
       role="button">
        <span><i class="fa fa-chart-line me-2"></i>Performance & Goal</span>
        <i class="fa fa-chevron-down dropdown-arrow"></i>
    </a>
    <div class="collapse ps-4 submenu" id="performanceMenu">
        <a href="#">Set Goals</a>
        <a href="#">Appraisal</a>
        <a href="#">Reviews</a>
    </div>

    <!-- Master Document -->
    <a class="d-flex justify-content-between align-items-center"
       data-bs-toggle="collapse"
       href="#masterDocMenu"
       role="button">
        <span><i class="fa fa-folder-open me-2"></i>Master Document</span>
        <i class="fa fa-chevron-down dropdown-arrow"></i>
    </a>
    <div class="collapse ps-4 submenu" id="masterDocMenu">
        <a href="#">Policies</a>
        <a href="#">Company Forms</a>
        <a href="#">Templates</a>
    </div>

    <!-- Promotion -->
    <a class="d-flex justify-content-between align-items-center"
       data-bs-toggle="collapse"
       href="#promotionMenu"
       role="button">
        <span><i class="fa fa-arrow-up me-2"></i>Promotion</span>
        <i class="fa fa-chevron-down dropdown-arrow"></i>
    </a>
    <div class="collapse ps-4 submenu" id="promotionMenu">
        <a href="#">Promotion Requests</a>
        <a href="#">Approval</a>
    </div>

    <!-- Resignation -->
    <a class="d-flex justify-content-between align-items-center"
       data-bs-toggle="collapse"
       href="#resignationMenu"
       role="button">
        <span><i class="fa fa-user-minus me-2"></i>Resignation</span>
        <i class="fa fa-chevron-down dropdown-arrow"></i>
    </a>
    <div class="collapse ps-4 submenu" id="resignationMenu">
        <a href="#">Apply Resignation</a>
        <a href="#">Resignation Status</a>
    </div>

    <!-- Termination -->
    <a class="d-flex justify-content-between align-items-center"
       data-bs-toggle="collapse"
       href="#terminationMenu"
       role="button">
        <span><i class="fa fa-user-slash me-2"></i>Termination</span>
        <i class="fa fa-chevron-down dropdown-arrow"></i>
    </a>
    <div class="collapse ps-4 submenu" id="terminationMenu">
        <a href="#">Termination List</a>
        <a href="#">Exit Clearance</a>
    </div>

    <!-- Events -->
    <a class="d-flex justify-content-between align-items-center"
       data-bs-toggle="collapse"
       href="#eventsMenu"
       role="button">
        <span><i class="fa fa-calendar me-2"></i>Events</span>
        <i class="fa fa-chevron-down dropdown-arrow"></i>
    </a>
    <div class="collapse ps-4 submenu" id="eventsMenu">
        <a href="#">Create Event</a>
        <a href="#">Event List</a>
    </div>

    <!-- Training -->
    <a class="d-flex justify-content-between align-items-center"
       data-bs-toggle="collapse"
       href="#trainingMenu"
       role="button">
        <span><i class="fa fa-graduation-cap me-2"></i>Training</span>
        <i class="fa fa-chevron-down dropdown-arrow"></i>
    </a>
    <div class="collapse ps-4 submenu" id="trainingMenu">
        <a href="#">Training Schedule</a>
        <a href="#">Training Reports</a>
    </div>

    <!-- Documents -->
    <a class="d-flex justify-content-between align-items-center"
       data-bs-toggle="collapse"
       href="#documentsMenu"
       role="button">
        <span><i class="fa fa-folder me-2"></i>Documents</span>
        <i class="fa fa-chevron-down dropdown-arrow"></i>
    </a>
    <div class="collapse ps-4 submenu" id="documentsMenu">
        <a href="#">Upload Document</a>
        <a href="#">Document Library</a>
    </div>

    <!-- Projects -->
    <a class="d-flex justify-content-between align-items-center"
       data-bs-toggle="collapse"
       href="#projectsMenu"
       role="button">
        <span><i class="fa fa-briefcase me-2"></i>Projects</span>
        <i class="fa fa-chevron-down dropdown-arrow"></i>
    </a>
    <div class="collapse ps-4 submenu" id="projectsMenu">
        <a href="#">Project List</a>
        <a href="#">Assign Project</a>
    </div>

    <!-- Reports -->
    <a class="d-flex justify-content-between align-items-center"
       data-bs-toggle="collapse"
       href="#reportsMenu"
       role="button">
        <span><i class="fa fa-chart-bar me-2"></i>Reports</span>
        <i class="fa fa-chevron-down dropdown-arrow"></i>
    </a>
    <div class="collapse ps-4 submenu" id="reportsMenu">
        <a href="#">Employee Report</a>
        <a href="#">Performance Report</a>
    </div>

    <!-- Attendance -->
    <a class="d-flex justify-content-between align-items-center"
       data-bs-toggle="collapse"
       href="#attendanceMenu"
       role="button">
        <span><i class="fa fa-clock me-2"></i>Attendance</span>
        <i class="fa fa-chevron-down dropdown-arrow"></i>
    </a>
    <div class="collapse ps-4 submenu" id="attendanceMenu">
        <a href="#">Attendance List</a>
        <a href="#">Monthly Report</a>
    </div>

    <!-- Payroll -->
    <a class="d-flex justify-content-between align-items-center"
       data-bs-toggle="collapse"
       href="#payrollMenu"
       role="button">
        <span><i class="fa fa-money-bill me-2"></i>Payroll</span>
        <i class="fa fa-chevron-down dropdown-arrow"></i>
    </a>
    <div class="collapse ps-4 submenu" id="payrollMenu">
        <a href="#">Salary Structure</a>
        <a href="#">Payslip</a>
    </div>

    <a href="Login.aspx">
        <i class="fa fa-sign-out-alt me-2"></i>Logout
    </a>

</div>

</form>
</body>
</html>