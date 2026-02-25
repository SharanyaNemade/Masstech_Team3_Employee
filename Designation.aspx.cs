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

            string q = $@"exec sp_GetAllDesignations";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);

            // For Filtering by Status
            if (!string.IsNullOrEmpty(ddlFilterStatus.SelectedValue))
            {
                dt.DefaultView.RowFilter = "Status = '" + ddlFilterStatus.SelectedValue + "'";
            }

            // For Searching
            if (!string.IsNullOrEmpty(txtSearch.Text))
            {
                dt.DefaultView.RowFilter = "DesignationName LIKE '%" + txtSearch.Text + "%'";
            }

            // For Sorting
            dt.DefaultView.Sort = ddlSortBy.SelectedValue + " ASC";

            gvDesignation.DataSource = dt.DefaultView;
            gvDesignation.DataBind();






            /*using (SqlCommand cmd = new SqlCommand("sp_GetAllDesignations", conn))
            {
                cmd.CommandType = CommandType.StoredProcedure;

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                //  Filtering by Status
                if (!string.IsNullOrEmpty(ddlFilterStatus.SelectedValue))
                {
                    dt.DefaultView.RowFilter =
                        "Status = '" + ddlFilterStatus.SelectedValue + "'";
                }

                //  Searching
                if (!string.IsNullOrEmpty(txtSearch.Text))
                {
                    dt.DefaultView.RowFilter =
                        "DesignationName LIKE '%" + txtSearch.Text + "%'";
                }

                //  Sorting

                dt.DefaultView.Sort = ddlSortBy.SelectedValue + " ASC";


                gvDesignation.DataSource = dt.DefaultView;
                gvDesignation.DataBind();

            }*/

        }



        protected void btnSave_Click(object sender, EventArgs e)
        {
            string desigName = txtDesignationName.Text;
            string deptName = TextBox2.Text;
            string status = ddlStatus.SelectedValue;
            string createdBy = "Admin";
            string ModifiedBy = "Admin";

            string q = $@"exec sp_InsertDesignations '{desigName}','{deptName}', 'IT', 0, '{status}', '{createdBy}', '{ModifiedBy}'";


            try
            {
                SqlCommand cmd = new SqlCommand(q, conn);
                conn.Open();
                cmd.ExecuteNonQuery();

                Response.Write("<script>alert('Designation Saved Successfully');</script>");

                // Reset UI
                pnlModal.Visible = false;
                txtDesignationName.Text = "";
                TextBox2.Text = "";
                FetchDesignations();
            }
            catch (Exception ex)
            {
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }

        /*protected void btnSave_Click(object sender, EventArgs e)
        {
            string email = TextBox1.Text;
            string username = TextBox2.Text;
            string password = TextBox3.Text;
            string role = DropDownList1.SelectedValue;

           
            string q = $@"exec sp_SaveUsers '{email}', '{username}', '{password}', '{role}'";

            try
            {
               
                if (conn.State == ConnectionState.Closed) conn.Open();

                SqlCommand cmd = new SqlCommand(q, conn);
                cmd.ExecuteNonQuery();

               

                Response.Write("<script>alert('User Saved Successfully');</script>");

             
                TextBox1.Text = TextBox2.Text = TextBox3.Text = "";
                DropDownList1.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
               
                Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
            }
        }*/














        /*        protected void btnSave_Click(object sender, EventArgs e)
                {

                    using (SqlCommand cmd = new SqlCommand("sp_InsertDepartment", conn))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;

                        cmd.Parameters.AddWithValue("@DepartmentName", txtDesignationName.Text);
                        cmd.Parameters.AddWithValue("@NoOfEmp", 0);
                        cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                        cmd.Parameters.AddWithValue("@CreatedBy", "Admin");

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }


                    txtDesignationName.Text = "";
                    ddlStatus.SelectedIndex = 0;

                    pnlModal.Visible = false;

                    FetchDepartments();
                }*/


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

            // Rebind data again
            FetchDesignations();   //  use your actual data binding method name
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
        }
    }
}