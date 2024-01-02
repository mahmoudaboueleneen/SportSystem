using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Database_Project___Milestone_3
{
    public partial class RegisterSportsAssociationManager : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected bool isNumeric(String str)
        {
            int strNumeric;
            bool strIsNumeric = int.TryParse(str, out strNumeric);

            return strIsNumeric;
        }

        protected int toNumeric(String str)
        {
            int strNumeric;
            int.TryParse(str, out strNumeric);

            return strNumeric;
        }

        protected void login_button_click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
        }

        protected void register_button_click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["dbproj"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            // REGISTER PROCEDURE
            String sname = name1.Text;
            String user = username1.Text;
            String pass = password1.Text;

            if (sname != null && sname != "" && !isNumeric(sname) && sname.Length <= 20 &&
                user != null && user != "" && !isNumeric(user) && user.Length <= 20 &&
                pass != null && pass != "" && pass.Length <= 20)
            {
                SqlCommand registerproc = new SqlCommand("addAssociationManager", conn);
                registerproc.CommandType = System.Data.CommandType.StoredProcedure;
                registerproc.Parameters.Add(new SqlParameter("@name", sname));
                registerproc.Parameters.Add(new SqlParameter("@username", user));
                registerproc.Parameters.Add(new SqlParameter("@password", pass));
                SqlParameter success = registerproc.Parameters.Add("@success", System.Data.SqlDbType.Int);

                success.Direction = ParameterDirection.Output;

                conn.Open();
                registerproc.ExecuteNonQuery();
                conn.Close();

                if (success.Value.ToString() == "1")
                {
                    Response.Redirect("Login.aspx?Parameter=registerSuccess");
                }
                else
                {
                    Response.Write("Registration failed.");
                }
            }
            else
            {
                Response.Write("Invalid data entry. Please read the restrictions and try again!");
            }
        }
    }
}