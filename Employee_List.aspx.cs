using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Masstech_Team3_Employee
{
    public partial class Employee_List : System.Web.UI.Page
    {
        SqlConnection conn;

        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();

            if (!IsPostBack)
            {
                FetchList();
                LoadSummary();
            }
        }


        // ================= FETCH EMPLOYEE LIST =================
        public void FetchList()
        {
            SqlCommand cmd = new SqlCommand("sp_GetAllUsers", conn);
            cmd.CommandType = CommandType.StoredProcedure;

            SqlDataAdapter ada = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            ada.Fill(ds);

            gvEmployee.DataSource = ds;
            gvEmployee.DataBind();
        }


        // ================= DELETE EMPLOYEE =================
        protected void gvEmployee_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvEmployee.DataKeys[e.RowIndex].Value);

            string q = $"exec sp_DeleteEmployee '{id}'";

            SqlCommand cmd = new SqlCommand(q, conn);
            cmd.ExecuteNonQuery();

            Response.Write("<script>alert('Employee Deleted')</script>");

            FetchList();
            LoadSummary();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            FetchList();
        }

        // ================= PAGING =================
        protected void gvEmployee_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvEmployee.PageIndex = e.NewPageIndex;
            FetchList();
        }


        // ================= SUMMARY CARDS =================
        public void LoadSummary()
        {
            string q = "exec sp_GetEmployeeSummary";

            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader dr = cmd.ExecuteReader();

            if (dr.Read())
            {
                lblTotal.Text = dr["TotalEmployee"].ToString();
                lblActive.Text = dr["ActiveEmployee"].ToString();
                lblInactive.Text = dr["InactiveEmployee"].ToString();
                lblNewJoiner.Text = dr["NewJoiner"].ToString();
            }
        }
    }
}







//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Web;
//using System.Data;
//using System.Data.SqlClient;
//using System.Configuration;
//using System.Web.UI;
//using System.Web.UI.WebControls;

//namespace Masstech_Team3_Employee
//{
//    public partial class Employee_List : System.Web.UI.Page
//    {
//        SqlConnection conn;

//        protected void Page_Load(object sender, EventArgs e)
//        {

//            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
//            conn = new SqlConnection(cs);
//            conn.Open();


//            if (!IsPostBack)
//            {
//                BindGrid();
//                SetSummary();
//            }
//        }

//        private void BindGrid()
//        {
//            DataTable dt = new DataTable();

//            dt.Columns.Add("EmployeeId");
//            dt.Columns.Add("PhotoUrl");
//            dt.Columns.Add("Name");
//            dt.Columns.Add("Email");
//            dt.Columns.Add("PhoneNumber");
//            dt.Columns.Add("Designation");
//            dt.Columns.Add("ReportingManager");
//            dt.Columns.Add("DOJ", typeof(DateTime));
//            dt.Columns.Add("Status");
//            dt.Columns.Add("CreatedBy");
//            dt.Columns.Add("ModifiedBy");

//            dt.Rows.Add("35", "https://i.pravatar.cc/40?img=1", "Krish Kheloji", "krish@gmail.com", "8877665544", "Software Developer", "Null", DateTime.Now, "Active", "Admin", "Admin");
//            dt.Rows.Add("36", "https://i.pravatar.cc/40?img=2", "Suraj K", "suraj@gmail.com", "6546378292", "Software Developer", "Krish", DateTime.Now, "Active", "Admin", "Admin");
//            dt.Rows.Add("37", "https://i.pravatar.cc/40?img=3", "Ram Kheloji", "ram@gmail.com", "8877665544", "Software Developer", "Krish", DateTime.Now, "Active", "Admin", "Admin");

//            gvEmployee.DataSource = dt;
//            gvEmployee.DataBind();
//        }

//        protected void gvEmployee_PageIndexChanging(object sender, System.Web.UI.WebControls.GridViewPageEventArgs e)
//        {
//            gvEmployee.PageIndex = e.NewPageIndex;
//            BindGrid();
//        }

//        protected void btnSearch_Click(object sender, EventArgs e)
//        {
//            BindGrid();
//        }

//        private void SetSummary()
//        {
//            lblTotal.Text = "7";
//            lblActive.Text = "7";
//            lblInactive.Text = "0";
//            lblNewJoiner.Text = "0";
//        }
//    }
//}
