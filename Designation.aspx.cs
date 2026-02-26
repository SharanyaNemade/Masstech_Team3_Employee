using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient; 
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Masstech_Team3_Employee
{
    public partial class Designation : System.Web.UI.Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {

            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                FetchDesignations();
            }
        }

        private void FetchDesignations()
        {
            // It was showing InvalidOperationException: The connection was not open.
            conn.Open();

            string q = $@"exec sp_GetAllDesignations";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            
            conn.Close();   

            gvDesignation.DataSource = dt.DefaultView;
            gvDesignation.DataBind();
        }





        protected void btnSave_Click(object sender, EventArgs e)
        {
            string desigName = txtDesignationName.Text;
            string deptName = TextBox2.Text;
            string status = ddlStatus.SelectedValue;

            string q = $@"exec sp_InsertDesignations '{desigName}','{deptName}', 'IT', 0, '{status}', 'Admin', 'Admin'";
            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();


            Response.Write("<script>alert('Designation Saved Successfully')</script>");

            pnlModal.Visible = false;
            txtDesignationName.Text = "";
            TextBox2.Text = "";
            ddlStatus.SelectedIndex = 0;

            FetchDesignations();
        }


        protected void ddlFilterStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            FetchDesignations();
        }

        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            FetchDesignations();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            FetchDesignations();
        }

        protected void btnOpenModal_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = true;
        }

        protected void gvDesignation_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDesignation.PageIndex = e.NewPageIndex;

            FetchDesignations();   
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
        }
    }
}