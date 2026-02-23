using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace Masstech_Team3_Employee
{
    public partial class Add_Department : System.Web.UI.Page
    {
        SqlConnection conn;

        string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                FetchDepartments();
            }
        }

        private void FetchDepartments()
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("sp_GetAllDepartment", conn))
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
                        dt.DefaultView.RowFilter =
                            "DepartmentName LIKE '%" + txtSearch.Text + "%'";
                    }

                    // 🔎 SORT
                    dt.DefaultView.Sort = ddlSortBy.SelectedValue + " ASC";

                    gvDepartment.DataSource = dt;
                    gvDepartment.DataBind();
                }
            }
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(cs))
            {
                using (SqlCommand cmd = new SqlCommand("sp_InsertDepartment", conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.AddWithValue("@DepartmentName", txtDepartmentName.Text);
                    cmd.Parameters.AddWithValue("@NoOfEmp", 0);
                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
                    cmd.Parameters.AddWithValue("@CreatedBy", "Admin");

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            txtDepartmentName.Text = "";
            ddlStatus.SelectedIndex = 0;

            pnlModal.Visible = false;

            FetchDepartments(); // or FetchList() if that’s your method name
        }


        protected void ddlFilterStatus_SelectedIndexChanged(object sender, EventArgs e)
        {
            FetchDepartments();
        }

        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            FetchDepartments();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            FetchDepartments();
        }

        protected void btnOpenModal_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = true;
        }

        protected void gvDepartment_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvDepartment.PageIndex = e.NewPageIndex;

            // Rebind data again
            FetchDepartments();   // <-- use your actual data binding method name
        }

        protected void btnClose_Click(object sender, EventArgs e)
        {
            pnlModal.Visible = false;
        }
    }
}



//using System;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;

//namespace Masstech_Team3_Employee
//{
//    public partial class Add_Department : System.Web.UI.Page
//    {
//        SqlConnection conn;

//        string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            if (!IsPostBack)
//            {
//                FetchList();
//            }
//        }

//        protected void btnOpenModal_Click(object sender, EventArgs e)
//        {
//            pnlModal.Visible = true;
//        }

//        protected void btnClose_Click(object sender, EventArgs e)
//        {
//            pnlModal.Visible = false;
//        }

//        protected void btnSave_Click(object sender, EventArgs e)
//        {
//            using (SqlConnection conn = new SqlConnection(cs))
//            {
//                using (SqlCommand cmd = new SqlCommand("sp_InsertDepartment", conn))
//                {
//                    cmd.CommandType = CommandType.StoredProcedure;

//                    cmd.Parameters.AddWithValue("@DepartmentName", txtDepartmentName.Text);
//                    cmd.Parameters.AddWithValue("@NoOfEmp", 0);
//                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
//                    cmd.Parameters.AddWithValue("@CreatedBy", "Admin");

//                    conn.Open();
//                    cmd.ExecuteNonQuery();
//                }
//            }

//            txtDepartmentName.Text = "";
//            ddlStatus.SelectedIndex = 0;

//            pnlModal.Visible = false;
//            FetchList();
//        }

//        private void FetchList()
//        {
//            using (SqlConnection conn = new SqlConnection(cs))
//            {
//                using (SqlCommand cmd = new SqlCommand("sp_GetAllDepartment", conn))
//                {
//                    cmd.CommandType = CommandType.StoredProcedure;

//                    SqlDataAdapter da = new SqlDataAdapter(cmd);
//                    DataTable dt = new DataTable();
//                    da.Fill(dt);

//                    gvDepartment.DataSource = dt;
//                    gvDepartment.DataBind();
//                }
//            }
//        }
//    }
//}  








//using System;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;
//using System.Web.UI;

//namespace Masstech_Team3_Employee
//{
//    public partial class Add_Department : Page
//    {
//        SqlConnection conn;

//        string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;

//        protected void Page_Load(object sender, EventArgs e)
//        {

//            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
//            conn = new SqlConnection(cs);
//            conn.Open();

//            if (!IsPostBack)
//            {
//                FetchList();
//            }
//        }

//        // Open Modal
//        protected void btnOpenModal_Click(object sender, EventArgs e)
//        {
//            pnlModal.Visible = true;
//        }

//        // Close Modal
//        protected void btnClose_Click(object sender, EventArgs e)
//        {
//            pnlModal.Visible = false;
//        }

//        // Save Department
//        protected void btnSave_Click(object sender, EventArgs e)
//        {
//            using (SqlConnection conn = new SqlConnection(cs))
//            {
//                using (SqlCommand cmd = new SqlCommand("sp_InsertDepartment", conn))
//                {
//                    cmd.CommandType = CommandType.StoredProcedure;

//                    cmd.Parameters.AddWithValue("@DepartmentName", txtDepartmentName.Text);
//                    cmd.Parameters.AddWithValue("@NoOfEmp", 0);
//                    cmd.Parameters.AddWithValue("@Status", ddlStatus.SelectedValue);
//                    cmd.Parameters.AddWithValue("@CreatedBy", "Admin");

//                    conn.Open();
//                    cmd.ExecuteNonQuery();
//                }
//            }

//            txtDepartmentName.Text = "";
//            ddlStatus.SelectedIndex = 0;

//            pnlModal.Visible = false;
//            FetchList();
//        }

//        // Load Grid
//        public void FetchList()
//        {
//            using (SqlConnection conn = new SqlConnection(cs))
//            {
//                using (SqlCommand cmd = new SqlCommand("sp_GetAllDepartment", conn))
//                {
//                    cmd.CommandType = CommandType.StoredProcedure;

//                    SqlDataAdapter da = new SqlDataAdapter(cmd);
//                    DataTable dt = new DataTable();
//                    da.Fill(dt);

//                    gvDepartment.DataSource = dt;
//                    gvDepartment.DataBind();
//                }
//            }
//        }

//        protected void gvDepartment_SelectedIndexChanged(object sender, EventArgs e)
//        {

//        }

//    }
//}











//using System;
//using System.Collections.Generic;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;
//using System.Linq;
//using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;

//namespace Masstech_Team3_Employee
//{
//    public partial class Add_Department : System.Web.UI.Page
//    {
//        SqlConnection conn;

//        protected void Page_Load(object sender, EventArgs e)
//        {
//            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
//            conn = new SqlConnection(cs);
//            conn.Open();

//            if (!IsPostBack)
//            {
//                FetchList();
//            }
//        }

//        // OPEN MODAL
//        protected void btnOpenModal_Click(object sender, EventArgs e)
//        {
//            pnlModal.Visible = true;
//        }

//        // FETCH ALL DEPARTMENTS
//        public void FetchList()
//        {
//            string q = "exec sp_GetAllDepartment";
//            SqlDataAdapter ada = new SqlDataAdapter(q, conn);
//            DataSet ds = new DataSet();
//            ada.Fill(ds);

//            gvDepartment.DataSource = ds;
//            gvDepartment.DataBind();
//        }
//    }
//}