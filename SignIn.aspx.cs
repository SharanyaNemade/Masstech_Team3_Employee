using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Masstech_Team3
{
    public partial class SignIn : System.Web.UI.Page
    {
        SqlConnection conn;
        protected void Page_Load(object sender, EventArgs e)
        {
            string cs = ConfigurationManager.ConnectionStrings["dbconn"].ConnectionString;
            conn = new SqlConnection(cs);
            conn.Open();
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string email = TextBox1.Text;
            string password = TextBox2.Text;

            string q = $"exec sp_logindetails '{email}','{password}'";
            SqlCommand cmd = new SqlCommand(q, conn);
            SqlDataReader rdr = cmd.ExecuteReader();
            if (rdr.HasRows)
            {
                while (rdr.Read())
                {

                    if (rdr["Email"].Equals(email) && rdr["PasswordHash"].Equals(password) && rdr["RoleName"].Equals("Admin"))
                    {
                        Session["User"] = rdr["Email"];
                        Response.Redirect("AddDepartment.aspx");
                    }
                    else if (rdr["Email"].Equals(email) && rdr["PasswordHash"].Equals(password) && rdr["RoleName"].Equals("Manager"))
                    {
                        Session["User"] = email;
                        Response.Redirect("Manager.aspx");
                    }
                    else if (rdr["Email"].Equals(email) && rdr["PasswordHash"].Equals(password) && rdr["RoleName"].Equals("Employee"))
                    {
                        Session["User"] = email;
                        Response.Redirect("Employee.aspx");
                    }
                    else
                    {
                        Response.Redirect("<script>alert('Invalid Email or Password')</script>");
                    }
                }

            }
            else
            {

            }

        }
        protected void clear()
        {
            TextBox1.Text = "";
            TextBox2.Text = "";
        }
    }
}
