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
using static System.Net.Mime.MediaTypeNames;

namespace Database_Project___Milestone_3
{
    public partial class RegisterFan : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void login_button_click(object sender, EventArgs e)
        {
            Response.Redirect("Login.aspx");
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

        protected bool isDateTime(String str)
        {
            DateTime strDateTime;
            bool strIsDateTime = DateTime.TryParse(str, out strDateTime);

            return strIsDateTime;
        }

        protected DateTime toDateTime(String str)
        {
            DateTime strDateTime;
            DateTime.TryParse(str, out strDateTime);

            return strDateTime;
        }

        protected void register_button_click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["dbproj"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            // REGISTER PROCEDURE
            String fname = name1.Text;
            String user = username1.Text;
            String pass = password1.Text;
            String natid = nationalid1.Text;
            String phoneno = phonenumber1.Text;
            String bdate = birthdate1.Text;
            String addr = address1.Text;

            if (fname != null && fname != "" && !isNumeric(fname) && fname.Length <= 20 &&
                user != null && user != "" && !isNumeric(user) && user.Length <= 20 &&
                pass != null && pass != "" && pass.Length <= 20 &&
                natid != null && natid != "" && natid.Length <= 20 &&
                phoneno != null && phoneno != "" && isNumeric(phoneno) &&
                bdate != null && bdate != "" && isDateTime(bdate) && toDateTime(bdate) >= new DateTime(1754, 1, 1, 1, 0, 0) &&
                addr != null && addr != "" && !isNumeric(addr) && addr.Length <= 20)
            {
                SqlCommand registerproc = new SqlCommand("addFan", conn);
                registerproc.CommandType = System.Data.CommandType.StoredProcedure;
                registerproc.Parameters.Add(new SqlParameter("@name", fname));
                registerproc.Parameters.Add(new SqlParameter("@username", user));
                registerproc.Parameters.Add(new SqlParameter("@password", pass));
                registerproc.Parameters.Add(new SqlParameter("@national_id", natid));
                registerproc.Parameters.Add(new SqlParameter("@birth_date", toDateTime(bdate)));
                registerproc.Parameters.Add(new SqlParameter("@address", addr));
                registerproc.Parameters.Add(new SqlParameter("@phone_no", toNumeric(phoneno)));
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
                    Response.Write("Registration failed. This username is already taken.");
                }
            }
            else
            {
                Response.Write("Invalid data entry. Please read the restrictions and try again!");
            }
        }
    }
}