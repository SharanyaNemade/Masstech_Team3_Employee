<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employee_Grid.aspx.cs" Inherits="Masstech_Team3_Employee.Employee_Grid" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee Grid</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

    <style>
        body {
            background-color: #f5f6fa;
        }

        .dashboard-title {
            font-weight: 600;
            font-size: 22px;
        }

        .stat-card {
            border-radius: 10px;
            padding: 20px;
            background: #fff;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .stat-icon {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #fff;
        }

        .bg-green { background: #22c55e; }
        .bg-red { background: #ef4444; }
        .bg-blue { background: #3b82f6; }
        .bg-dark { background: #111827; }

        .employee-card {
            border-radius: 12px;
            padding: 25px;
            background: #fff;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            position: relative;
            transition: 0.3s;
        }

        .employee-card:hover {
            transform: translateY(-5px);
        }

        .employee-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            object-fit: cover;
            border: 3px solid #e5e7eb;
        }

        .online-dot {
            width: 14px;
            height: 14px;
            background: #22c55e;
            border-radius: 50%;
            position: absolute;
            bottom: 0;
            right: 0;
            border: 2px solid #fff;
        }

        .progress {
            height: 6px;
            border-radius: 10px;
        }

        .productivity-text {
            font-size: 13px;
            font-weight: 500;
            color: #6b7280;
        }

        .btn-orange {
            background: #f97316;
            color: #fff;
        }

        .btn-orange:hover {
            background: #ea580c;
            color: #fff;
        }

        .section-title {
            font-weight: 600;
            font-size: 18px;
        }

    </style>

</head>
<body>
    <form id="form1" runat="server">

        <div class="container-fluid p-4">

            <!-- Header -->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <div class="dashboard-title">Employee</div>
                    <small class="text-muted">Employee / Employee Grid</small>
                </div>
                <div>
                    <button type="button" class="btn btn-outline-secondary me-2">
                        <i class="bi bi-download"></i> Export
                    </button>
                    <button type="button" class="btn btn-orange">
                        <i class="bi bi-plus-circle"></i> Add Employee
                    </button>
                </div>
            </div>

            <!-- Statistics Cards -->
            <div class="row g-3 mb-4">

                <div class="col-md-3">
                    <div class="stat-card d-flex align-items-center">
                        <div class="stat-icon bg-dark me-3">
                            <i class="bi bi-people"></i>
                        </div>
                        <div>
                            <div class="text-muted">Total Employee</div>
                            <h5 class="mb-0">7</h5>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="stat-card d-flex align-items-center">
                        <div class="stat-icon bg-green me-3">
                            <i class="bi bi-person-check"></i>
                        </div>
                        <div>
                            <div class="text-muted">Active</div>
                            <h5 class="mb-0">7</h5>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="stat-card d-flex align-items-center">
                        <div class="stat-icon bg-red me-3">
                            <i class="bi bi-person-x"></i>
                        </div>
                        <div>
                            <div class="text-muted">InActive</div>
                            <h5 class="mb-0">0</h5>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="stat-card d-flex align-items-center">
                        <div class="stat-icon bg-blue me-3">
                            <i class="bi bi-person-plus"></i>
                        </div>
                        <div>
                            <div class="text-muted">New Joiners</div>
                            <h5 class="mb-0">0</h5>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Employee List Header -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="section-title">Employee List</div>
                <div>
                    <select class="form-select d-inline-block w-auto me-2">
                        <option>Select Designation</option>
                    </select>
                    <select class="form-select d-inline-block w-auto">
                        <option>Sorting By</option>
                    </select>
                </div>
            </div>

            <!-- Employee Cards -->
            <div class="row g-4">

                <!-- Card 1 -->
                <div class="col-md-4">
                    <div class="employee-card text-center">

                        <div class="position-relative d-inline-block">
                            <img src="https://i.pravatar.cc/150?img=1" class="employee-avatar" />
                            <div class="online-dot"></div>
                        </div>

                        <h6 class="mt-3 mb-1">Krish Kheloji</h6>
                        <small class="text-muted">Software Developer</small>

                        <div class="row mt-4">
                            <div class="col">
                                <small class="text-muted">Projects</small>
                                <div>1</div>
                            </div>
                            <div class="col">
                                <small class="text-muted">Done</small>
                                <div>1</div>
                            </div>
                            <div class="col">
                                <small class="text-muted">Progress</small>
                                <div>0</div>
                            </div>
                        </div>

                        <div class="mt-3 productivity-text">
                            Productivity: 25%
                        </div>

                        <div class="progress mt-2">
                            <div class="progress-bar bg-purple" style="width:25%; background:#8b5cf6;"></div>
                        </div>

                    </div>
                </div>

                <!-- Duplicate this block for more employees -->

                <div class="col-md-4">
                    <div class="employee-card text-center">
                        <div class="position-relative d-inline-block">
                            <img src="https://i.pravatar.cc/150?img=5" class="employee-avatar" />
                            <div class="online-dot"></div>
                        </div>

                        <h6 class="mt-3 mb-1">Suraj R</h6>
                        <small class="text-muted">Software Developer</small>

                        <div class="row mt-4">
                            <div class="col">
                                <small class="text-muted">Projects</small>
                                <div>1</div>
                            </div>
                            <div class="col">
                                <small class="text-muted">Done</small>
                                <div>0</div>
                            </div>
                            <div class="col">
                                <small class="text-muted">Progress</small>
                                <div>2</div>
                            </div>
                        </div>

                        <div class="mt-3 productivity-text">
                            Productivity: 0%
                        </div>

                        <div class="progress mt-2">
                            <div class="progress-bar" style="width:0%; background:#8b5cf6;"></div>
                        </div>
                    </div>
                </div>


                <!-- Card 3 -->

                <div class="col-md-4">
                    <div class="employee-card text-center">
                        <div class="position-relative d-inline-block">
                            <img src="https://i.pravatar.cc/150?img=5" class="employee-avatar" />
                            <div class="online-dot"></div>
                        </div>

                        <h6 class="mt-3 mb-1">Suraj R</h6>
                        <small class="text-muted">Software Developer</small>

                        <div class="row mt-4">
                            <div class="col">
                                <small class="text-muted">Projects</small>
                                <div>1</div>
                            </div>
                            <div class="col">
                                <small class="text-muted">Done</small>
                                <div>0</div>
                            </div>
                            <div class="col">
                                <small class="text-muted">Progress</small>
                                <div>2</div>
                            </div>
                        </div>

                        <div class="mt-3 productivity-text">
                            Productivity: 0%
                        </div>

                        <div class="progress mt-2">
                            <div class="progress-bar" style="width: 0%; background: #8b5cf6;"></div>
                        </div>
                    </div>
                </div>





            </div>

        </div>

    </form>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
