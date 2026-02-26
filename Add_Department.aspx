<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master"
    AutoEventWireup="true"
    CodeBehind="Add_Department.aspx.cs"
    Inherits="Masstech_Team3_Employee.Add_Department" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    

<style>

    
    .page-title {
        font-size: 28px;
        font-weight: 700;
        color: #2c3e50;
    }

    .card {
        border-radius: 10px;
        border: none;
    }

    .card-header {
        font-weight: 600;
        font-size: 18px;
        background: grey;
        padding: 20px 24px;
    }

    table.dataTable thead th {
        background-color: #E5E7EB;
        color: black;
        font-weight: 600;
    }

    table.dataTable tbody tr:hover {
        background-color: #f3f4f6;
    }

    .dataTables_wrapper .dataTables_filter input {
        border-radius: 6px;
        border: 1px solid #ccc;
        padding: 4px 8px;
    }

    .action-icon {
        color: black !important;
        text-decoration: none;
    }

    .dataTables_wrapper .dt-buttons .btn {
        background-color: whitesmoke;
        border-radius: 8px;
        padding: 6px 12px;
    }


    .dt-buttons .btn:hover {
        color: white !important;
        background-color: #e86425 !important;
    }


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

    <script>
        $(document).ready(function () {
            $('#<%= gvDepartment.ClientID %>').DataTable({
                pageLength: 5,
                lengthMenu: [5,10, 25, 50, 100],
                dom: 'Blfrtip',
                   buttons: [
                       {
                           text: 'Export',
                           className: 'btn btn-primary',
                           extend: 'collection',
                           buttons: [
                               { extend: 'excel', text: 'Export to Excel' },
                               { extend: 'pdf', text: 'Export to PDF' },
                           ]
                       }
                   ],
                   language: {
                       search: "Search:",
                       lengthMenu: "Show _MENU_ entries",
                       info: "Showing _START_ to _END_ of _TOTAL_ entries"
                   }
               });
           });
    </script>



    <%--<script>
        $(document).ready(function () {
            $('#<%= gvDepartment.ClientID %>').DataTable({
             pageLength: 10,
             lengthMenu: [10, 25, 50, 100],
             ordering: true,
             searching: true,
             paging: true,
             info: true,
             dom: 'Bfrtip',
             buttons: [
                 {
                     text: 'Export',
                     className: 'btn btn-primary',
                     extend: 'collection',
                     buttons: [
                         { extend: 'excel', text: 'Export to Excel' },
                         { extend: 'pdf', text: 'Export to PDF' },
                     ]
                 }
             ],
             language: {
                 search: "Search:",
                 lengthMenu: "Show _MENU_ entries",
                 info: "Showing _START_ to _END_ of _TOTAL_ entries"
             }
         });
     });
    </script>--%>

<div class="department-container">

    <div class="page-title">Departments</div>


    <div class="card-box">

        <div class="top-actions">
            <asp:Button ID="btnOpenModal"
                runat="server"
                Text="Add Department"
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

            <asp:ListItem Text="Sort By Id" Value="DepartmentId" />
            <asp:ListItem Text="Sort By Name" Value="DepartmentName" />
            <asp:ListItem Text="Sort By Status" Value="Status" />
        </asp:DropDownList>
    </div>

<!--    <div>
        <asp:TextBox ID="txtSearch" runat="server" placeholder="Search..." />

        <asp:Button ID="btnSearch"
            runat="server"
            Text="Search"
            CssClass="btn-orange"
            OnClick="btnSearch_Click" />
    </div>      -->

</div>




<asp:GridView ID="gvDepartment"
    runat="server"
    AutoGenerateColumns="False">

    <Columns>

        <asp:BoundField DataField="DepartmentId" HeaderText="Id" />
        <asp:BoundField DataField="DepartmentName" HeaderText="Name" />
        <asp:BoundField DataField="NoOfEmp" HeaderText="NoOfEmp" />
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
            <h4>Add Department</h4>

            <label>Department Name</label>
            <asp:TextBox ID="txtDepartmentName" runat="server" />

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




