<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="Add_Role.aspx.cs" Inherits="Masstech_Team3_Employee.Add_Role" %>


<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


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

    /* Modal */
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


<div class="department-container">

    <div class="page-title">Roles</div>


    <div class="card-box">

        <div class="top-actions">
            <asp:Button ID="btnOpenModal"
                runat="server"
                Text="Add Role"
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

            <asp:ListItem Text="Sort By Id" Value="RoleId" />
            <asp:ListItem Text="Sort By Name" Value="RoleName" />
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




<asp:GridView ID="gvRole"
    runat="server"
    AutoGenerateColumns="False"
    CssClass="dept-grid table table-bordered"
    AllowPaging="true"
    PageSize="4"
    OnPageIndexChanging="gvRole_PageIndexChanging">

    <Columns>

        <asp:BoundField DataField="RoleId" HeaderText="Id" />
        <asp:BoundField DataField="RoleName" HeaderText="Name" />
        <asp:BoundField DataField="Status" HeaderText="Status" />
        <asp:BoundField DataField="CreatedBy" HeaderText="CreatedBy" />
        <asp:BoundField DataField="ModifiedBy" HeaderText="ModifiedBy" />

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

    <!-- Modal Panel -->
    <asp:Panel ID="pnlModal"
        runat="server"
        CssClass="modal-overlay"
        Visible="false">

        <div class="modal-box">
            <h4>Add Role</h4>

            <label>Role Name</label>
            <asp:TextBox ID="txtRoleName" runat="server" />

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

</asp:Content>