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


        protected void Page_Load(object sender, EventArgs e)
        {

            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                FetchRoles();
            }
        }

        private void FetchRoles()
        {
            string q = $"exec sp_GetAllRoles";

            SqlCommand cmd = new SqlCommand(q, conn);

                    

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Alternate temporary Method for search, sort, filter

                    // FILTER BY STATUS
                    if (!string.IsNullOrEmpty(ddlFilterStatus.SelectedValue))
                    {
                        dt.DefaultView.RowFilter =
                            "Status = '" + ddlFilterStatus.SelectedValue + "'";
                    }

                    // SEARCH
                    if (!string.IsNullOrEmpty(txtSearch.Text))
                    {
                        
                        string filter = "RoleName LIKE '%" + txtSearch.Text + "%'";
                        if (!string.IsNullOrEmpty(dt.DefaultView.RowFilter))
                        {
                            filter = dt.DefaultView.RowFilter + " AND " + filter;
                        }
                        dt.DefaultView.RowFilter = filter;
                    }

                    // SORT
                    dt.DefaultView.Sort = ddlSortBy.SelectedValue + " ASC";

                    gvRole.DataSource = dt;
                    gvRole.DataBind();    
        }




        protected void btnSave_Click(object sender, EventArgs e)
        {
            

            string roleName = txtRoleName.Text.Trim();
            string status = ddlStatus.SelectedValue;

            string q = $"exec sp_InsertRole '{roleName}', '{status}', 'Admin', 'Admin'";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();

            

            Response.Write("<script>alert('Role Saved Successfully')</script>");

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

