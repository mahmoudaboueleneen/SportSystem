using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Database_Project___Milestone_3
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Used to display successful registration message after registering and being redirected back to login page
            Message_Box.Enabled = false;

            if (Request.QueryString["Parameter"] != null)
            {
                String str = Request.QueryString["Parameter"].ToString();
                if (str == "registerSuccess")
                {
                    Message_Box.Text = "Registered successfully!";
                }
            }
        }

        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            
        }

        protected void login_button_click(object sender, EventArgs e)
        {
            string connStr = WebConfigurationManager.ConnectionStrings["dbproj"].ToString();
            SqlConnection conn = new SqlConnection(connStr);

            // LOGIN PROCEDURE
            String user = username.Text;
            String pass = password.Text;

            SqlCommand loginproc = new SqlCommand("userLogin", conn);
            loginproc.CommandType = System.Data.CommandType.StoredProcedure;

            loginproc.Parameters.Add(new SqlParameter("@username", user));
            loginproc.Parameters.Add(new SqlParameter("@password", pass));
            SqlParameter success = loginproc.Parameters.Add("@success", System.Data.SqlDbType.Int);
            SqlParameter type = loginproc.Parameters.Add("@type", System.Data.SqlDbType.Int);

            success.Direction = ParameterDirection.Output;
            type.Direction = ParameterDirection.Output;

            conn.Open();
            loginproc.ExecuteNonQuery();
            conn.Close();

            if (success.Value.ToString() == "1")
            {
                Session["Username"] = user;
                Session["UserType"] = type.Value;

                if(type.Value.ToString() == "1")
                {
                    Response.Redirect("SystemAdmin.aspx");
                }

                else if (type.Value.ToString() == "2")
                {
                    Response.Redirect("SportsAssociationManager.aspx");
                }

                else if (type.Value.ToString() == "3")
                {
                    Response.Redirect("ClubRepresentative.aspx");
                }

                else if (type.Value.ToString() == "4")
                {
                    Response.Redirect("StadiumManager.aspx");
                }

                else if (type.Value.ToString() == "5")
                {
                    Response.Redirect("Fan.aspx");
                }
            }

            else
            {
                Response.Write("Incorrect credentials, please try again!");
            }
        }
    }
}