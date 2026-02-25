<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employee_List.aspx.cs" Inherits="Masstech_Team3_Employee.Employee_List" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employee List</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />

    <style>
        body {
            background-color: #f4f6f9;
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

        .content {
            margin-left: 250px;
            padding: 20px;
        }

        .card-box {
            border-radius: 8px;
            padding: 20px;
            background: white;
            box-shadow: 0 0 10px rgba(0,0,0,0.05);
        }

        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
        }

        .status-active {
            background-color: #28a745;
            color: white;
        }

        .status-inactive {
            background-color: #dc3545;
            color: white;
        }

        .grid-img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        .top-btn {
            float: right;
        }


        .modal {
            z-index: 2000 !important;
        }

        .modal-backdrop {
            z-index: 1999 !important;
        }

    </style>
</head>

<body>
    <form id="form1" runat="server">

        <!-- Sidebar -->
        <div class="sidebar">
            <h5 class="text-center mb-4"><b>Pulse360</b></h5>
            <a href="#">Dashboard</a>
            <a href="#" class="fw-bold text-warning">Employees</a>
            <a href="#">Events</a>
            <a href="#">Training</a>
            <a href="#">Documents</a>
            <a href="#">Projects</a>
            <a href="#">Reports</a>
            <a href="#">Attendance</a>
            <a href="#">Payroll</a>
            <a href="#">Logout</a>
        </div>

        <!-- Main Content -->
        <div class="content">

            <!-- Header -->
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h4>Employee</h4>
                <asp:Button ID="btnAddEmployee"
                    runat="server"
                    Text="+ Add Employee"
                    CssClass="btn btn-warning top-btn"
                    OnClientClick="return false;"
                    data-bs-toggle="modal"
                    data-bs-target="#addEmployeeModal" OnClick="btnAddEmployee_Click" />
            </div>

            <!-- Summary Cards -->
            <div class="row mb-4">
                <div class="col-md-3">
                    <div class="card-box text-center">
                        <h6>Total Employee</h6>
                        <h4><asp:Label ID="lblTotal" runat="server" Text="0"></asp:Label></h4>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-box text-center">
                        <h6 class="text-success">Active</h6>
                        <h4><asp:Label ID="lblActive" runat="server" Text="0"></asp:Label></h4>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-box text-center">
                        <h6 class="text-danger">Inactive</h6>
                        <h4><asp:Label ID="lblInactive" runat="server" Text="0"></asp:Label></h4>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card-box text-center">
                        <h6 class="text-primary">New Joiners</h6>
                        <h4><asp:Label ID="lblNewJoiner" runat="server" Text="0"></asp:Label></h4>
                    </div>
                </div>
            </div>

            <!-- Filters -->
            <div class="card-box mb-3">
                <div class="row">
                    <div class="col-md-2">
                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control" TextMode="Date"></asp:TextBox>
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="ddlDesignation" runat="server" CssClass="form-select">
                            <asp:ListItem Text="All Designation" Value=""></asp:ListItem>
                            <asp:ListItem Text="Software Developer" />
                            <asp:ListItem Text="Manager" />
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-2">
                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                            <asp:ListItem Text="All Status" Value=""></asp:ListItem>
                            <asp:ListItem Text="Active" />
                            <asp:ListItem Text="Inactive" />
                        </asp:DropDownList>
                    </div>
                    <div class="col-md-3">
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search..."></asp:TextBox>
                    </div>
                    <div class="col-md-1">
                        <asp:Button ID="btnSearch" runat="server" Text="Go" CssClass="btn btn-primary w-100" OnClick="btnSearch_Click" />
                    </div>
                </div>
            </div>

            <!-- GridView -->
            <div class="card-box">

                <asp:GridView ID="gvEmployee" runat="server" AutoGenerateColumns="False"
                    CssClass="table table-bordered table-hover"
                    AllowPaging="True"
                    PageSize="5"
                    OnPageIndexChanging="gvEmployee_PageIndexChanging">

                    <Columns>

                        <asp:BoundField DataField="UserId" HeaderText="Id" />

                        <asp:TemplateField HeaderText="Name">
                            <ItemTemplate>
                                <img src='<%# Eval("PhotoUrl") %>' class="grid-img me-2" />
                                <%# Eval("Name") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Email" HeaderText="Email" />
                        <asp:BoundField DataField="PhoneNumber" HeaderText="Number" />
                        <asp:BoundField DataField="Designation" HeaderText="Designation" />
                        <asp:BoundField DataField="ReportingManager" HeaderText="Reporting Manager" />
                        <asp:BoundField DataField="DOJ" HeaderText="DOJ" DataFormatString="{0:yyyy-MM-dd}" />

                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <span class='<%# Eval("Status").ToString() == "Active" ? "status-badge status-active" : "status-badge status-inactive" %>'>
                                    <%# Eval("Status") %>
                                </span>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="CreatedBy" HeaderText="CreatedBy" />
                        <asp:BoundField DataField="ModifiedBy" HeaderText="ModifiedBy" />

                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <i class="fa fa-edit text-primary me-2"></i>
                                <i class="fa fa-trash text-danger"></i>
                            </ItemTemplate>
                        </asp:TemplateField>

                    </Columns>

                </asp:GridView>

            </div>

        </div>



        <!-- Add Employee Modal -->
<div class="modal fade" id="addEmployeeModal" tabindex="-1">
    <div class="modal-dialog modal-xl modal-dialog-centered">
        <div class="modal-content">

            <div class="modal-header">
                <h5 class="modal-title">Add Employee</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <div class="modal-body">

                <!-- Upload Section -->
                <div class="border rounded p-3 mb-4 bg-light">
                    <div class="d-flex align-items-center">
                        <div class="me-3">
                            <div class="rounded-circle border d-flex justify-content-center align-items-center"
                                 style="width:80px;height:80px;">
                                <i class="fa fa-user text-muted"></i>
                            </div>
                        </div>
                        <div>
                            <h6 class="mb-1">Upload Profile Image</h6>
                            <small class="text-muted">Image should be below 4 mb</small><br />
                            <asp:FileUpload ID="fuPhoto" runat="server" CssClass="form-control mt-2" />
                        </div>
                    </div>
                </div>

                <!-- Form Fields -->
                <div class="row g-3">

                    <div class="col-md-6">
                        <label>First Name *</label>
                        <asp:TextBox ID="txtFirstName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-6">
                        <label>Last Name</label>
                        <asp:TextBox ID="txtLastName" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-6">
                        <label>Email *</label>
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-6">
                        <label>Password *</label>
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-6">
                        <label>Joining Date *</label>
                        <asp:TextBox ID="txtJoiningDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-6">
                        <label>Birth Date *</label>
                        <asp:TextBox ID="txtBirthDate" runat="server" TextMode="Date" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-6">
                        <label>Role</label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select">
                            <asp:ListItem Text="-- Select Role --" Value=""></asp:ListItem>
                            <asp:ListItem>Admin</asp:ListItem>
                            <asp:ListItem>Employee</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-6">
                        <label>Department</label>
                        <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-select">
                            <asp:ListItem Text="-- Select Department --" Value=""></asp:ListItem>
                            <asp:ListItem>IT</asp:ListItem>
                            <asp:ListItem>HR</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-6">
                        <label>Manager</label>
                        <asp:DropDownList ID="ddlManager" runat="server" CssClass="form-select">
                            <asp:ListItem Text="-- Select Manager --" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-6">
                        <label>Designation</label>
                        <asp:DropDownList ID="ddlNewDesignation" runat="server" CssClass="form-select">
                            <asp:ListItem Text="-- Select Designation --" Value=""></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-6">
                        <label>Phone Number *</label>
                        <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-6">
                        <label>Address *</label>
                        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-md-6">
                        <label>Gender</label>
                        <asp:DropDownList ID="ddlGender" runat="server" CssClass="form-select">
                            <asp:ListItem>Select</asp:ListItem>
                            <asp:ListItem>Male</asp:ListItem>
                            <asp:ListItem>Female</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-6">
                        <label>Status</label>
                        <asp:DropDownList ID="ddlNewStatus" runat="server" CssClass="form-select">
                            <asp:ListItem>Select</asp:ListItem>
                            <asp:ListItem>Active</asp:ListItem>
                            <asp:ListItem>Inactive</asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-12">
                        <label>About *</label>
                        <asp:TextBox ID="txtAbout" runat="server" TextMode="MultiLine" Rows="3" CssClass="form-control"></asp:TextBox>
                    </div>

                </div>

            </div>

            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <asp:Button ID="btnSaveEmployee" runat="server" Text="Save" CssClass="btn btn-warning" />
            </div>

        </div>
    </div>
</div>


    </form>
</body>
</html>