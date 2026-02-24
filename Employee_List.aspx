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
                <asp:Button ID="btnAddEmployee" runat="server" Text="+ Add Employee" CssClass="btn btn-warning top-btn" />
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

    </form>
</body>
</html>