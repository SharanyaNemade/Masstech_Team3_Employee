using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Masstech_Team3_Employee
{
    public partial class Add_Role : System.Web.UI.Page
    {
        SqlConnection conn;

        string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FetchRoles();
            }
        }

        private void FetchRoles()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                // Assuming your stored procedure is named sp_GetAllRoles
                using (SqlCommand cmd = new SqlCommand("sp_GetAllRoles", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // 🔎 FILTER BY STATUS
                    if (!string.IsNullOrEmpty(ddlFilterStatus.SelectedValue))
                    {
                        dt.DefaultView.RowFilter =
                            "Status = '" + ddlFilterStatus.SelectedValue + "'";
                    }

                    // 🔎 SEARCH
                    if (!string.IsNullOrEmpty(txtSearch.Text))
                    {
                        // Note: If you already have a RowFilter from Status, 
                        // this will overwrite it. To combine them, you would use 'AND'.
                        string filter = "RoleName LIKE '%" + txtSearch.Text + "%'";
                        if (!string.IsNullOrEmpty(dt.DefaultView.RowFilter))
                        {
                            filter = dt.DefaultView.RowFilter + " AND " + filter;
                        }
                        dt.DefaultView.RowFilter = filter;
                    }

                    // 🔎 SORT
                    dt.DefaultView.Sort = ddlSortBy.SelectedValue + " ASC";

                    gvRole.DataSource = dt;
                    gvRole.DataBind();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                // Assuming your stored procedure is named sp_InsertRole
                using (SqlCommand cmd = new SqlCommand("sp_InsertRole", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@RoleName", txtRoleName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@CreatedBy", "Admin");
                    cmd.Parameters.AddWithValue("@ModifyBy", "Admin");

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Resetting fields
            txtRoleName.Text = "";
            ddlStatus.SelectedIndex = 0;

            pnlModal.Visible = false;

            FetchRoles();
        }

        protected void ddlFilterStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            FetchRoles();
        }

        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            FetchRoles();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            FetchRoles();
        }

        protected void btnOpenModal_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = true;
        }

        protected void gvRole_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvRole.PageIndex = e.NewPageIndex;
            FetchRoles();
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
        }
    }
}








//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;

//namespace Masstech_Team3_Employee
//{
//    public partial class Add_Role : System.Web.UI.Page
//    {
//        protected void Page_Load(object sender, EventArgs e)
//        {

//        }
//    }
//}