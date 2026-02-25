<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Designation.aspx.cs"
    Inherits="Masstech_Team3_Employee.Designation" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous"/>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>


    <title>Designation</title>

    <style>
        .status-active {
            background-color: #22c55e;
            color: #fff;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }

        .status-inactive {
            background-color: #ef4444;
            color: #fff;
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 600;
        }

        .department-container {
            width: 85%;
            margin: 30px auto;
        }

        .card-box {
            background: #fff;
            padding: 20px;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
        }

        .page-title {
            font-size: 24px;
            font-weight: 600;
            margin-bottom: 15px;
        }

        .top-actions {
            text-align: right;
            margin-bottom: 15px;
        }

        .btn-orange {
            background-color: #f97316;
            color: white;
            border: none;
            padding: 8px 15px;
            border-radius: 4px;
            cursor: pointer;
        }

        .dept-grid {
            width: 100%;
            border-collapse: collapse;
        }

        .dept-grid th {
            background: #f3f4f6;
            padding: 10px;
            border-bottom: 2px solid #ddd;
            text-align: left;
        }

        .dept-grid td {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0,0,0,0.5);
            display: flex;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }

        .modal-box {
            background: #fff;
            width: 400px;
            padding: 25px;
            border-radius: 6px;
        }

        .modal-box input,
        .modal-box select {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 15px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
    </style>
</head>

<body>
<form id="form1" runat="server">

    <div class="department-container">

        <div class="page-title">Designation</div>

        <div class="card-box">

            <div class="top-actions">
                <asp:Button ID="btnOpenModal"
                    runat="server"
                    Text="Add Designation"
                    CssClass="btn-orange"
                    OnClick="btnOpenModal_Click" />
            </div>

            <div style="display:flex; justify-content:space-between; margin-bottom:15px;">

                <div>
                    <asp:DropDownList ID="ddlFilterStatus" runat="server"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlFilterStatus_SelectedIndexChanged">

                        <asp:ListItem Text="All Status" Value="" />
                        <asp:ListItem Text="Active" Value="Active" />
                        <asp:ListItem Text="Inactive" Value="Inactive" />
                    </asp:DropDownList>

                    <asp:DropDownList ID="ddlSortBy" runat="server"
                        AutoPostBack="true"
                        OnSelectedIndexChanged="ddlSortBy_SelectedIndexChanged">

                        <asp:ListItem Text="Sort By Id" Value="DesignationId" />
                        <asp:ListItem Text="Sort By Name" Value="DesignationName" />
                        <asp:ListItem Text="Sort By Status" Value="Status" />
                    </asp:DropDownList>
                </div>

                <div>
                    <asp:TextBox ID="txtSearch" runat="server" placeholder="Search..." />
                    <asp:Button ID="btnSearch"
                        runat="server"
                        Text="Search"
                        CssClass="btn-orange"
                        OnClick="btnSearch_Click" />
                </div>
            </div>

            <asp:GridView ID="gvDesignation"
                runat="server"
                AutoGenerateColumns="False"
                CssClass="dept-grid"
                AllowPaging="true"
                PageSize="4"
                OnPageIndexChanging="gvDesignation_PageIndexChanging">

                <Columns>
                    <asp:BoundField DataField="DesignationId" HeaderText="Id" />
                    <asp:BoundField DataField="DesignationName" HeaderText="Name" />
                    <asp:BoundField DataField="NoOfEmp" HeaderText="NoOfEmp" />
                    <asp:BoundField DataField="CreatedBy" HeaderText="CreatedBy" />
                    <asp:BoundField DataField="ModifyBy" HeaderText="Modified By" />

                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lblStatus"
                                runat="server"
                                Text='<%# Eval("Status") %>'
                                CssClass='<%# Eval("Status").ToString() == "Active" ? "status-active" : "status-inactive" %>'>
                            </asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

        </div>

        <asp:Panel ID="pnlModal"
            runat="server"
            CssClass="modal-overlay"
            Visible="false">

            <div class="modal-box">
                <h4>Add Designation</h4>

                <label>Designation Name</label>
                <asp:TextBox ID="txtDesignationName" runat="server" />

                <label>Department Name</label>
                <asp:TextBox ID="TextBox2" runat="server" />

                <label>Status</label>
                <asp:DropDownList ID="ddlStatus" runat="server">
                    <asp:ListItem Text="Active" Value="Active" />
                    <asp:ListItem Text="Inactive" Value="Inactive" />
                </asp:DropDownList>

                <asp:Button ID="btnSave"
                    runat="server"
                    Text="Save"
                    CssClass="btn-orange"
                    OnClick="btnSave_Click" />

                <asp:Button ID="btnClose"
                    runat="server"
                    Text="Cancel"
                    CssClass="btn-orange"
                    OnClick="btnClose_Click" />
            </div>

        </asp:Panel>

    </div>

</form>
</body>
</html>