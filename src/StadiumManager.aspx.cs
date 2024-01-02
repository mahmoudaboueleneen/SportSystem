using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Database_Project___Milestone_3
{
    public partial class StadiumManager : System.Web.UI.Page
    {
        static String connStr = WebConfigurationManager.ConnectionStrings["dbproj"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null && Session["Username"] != null)
            {
                String type = (Session["UserType"]).ToString();

                if (Int16.Parse(type) != 4)
                {
                    Response.Redirect("Unauthorized.aspx");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

            ShowStadiumInfo();
            ShowHostRequests();
        }

        protected void logout_button_click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Session["UserType"] = null;
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

        protected void ShowStadiumInfo()
        {
            conn.Open();
            String smusername = Session["Username"].ToString();
            SqlCommand cmd = new SqlCommand("showStadiumInfo", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", smusername));
            SqlDataReader sdr = cmd.ExecuteReader();
            GridView1.DataSource = sdr;
            GridView1.DataBind();
            conn.Close();
        }

        protected void ShowHostRequests()
        {
            conn.Open();
            String smusername = Session["Username"].ToString();
            SqlCommand cmd = new SqlCommand("showHostRequests", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", smusername));
            SqlDataReader sdr = cmd.ExecuteReader();
            GridView2.DataSource = sdr;
            GridView2.DataBind();
            conn.Close();
        }

        protected void acceptRequest(object sender, EventArgs e)
        {
            conn.Open();

            // ACCEPT REQUEST PROCEDURE
            String smusername = Session["Username"].ToString();
            String chname = TextBox1.Text;
            String c2name = TextBox2.Text;
            String date = TextBox3.Text;

            if (chname != null && chname != "" && !isNumeric(chname) && chname.Length <= 20 &&
                c2name != null && c2name != "" && !isNumeric(c2name) && c2name.Length <= 20 &&
                date != null && date != "" && isDateTime(date) && toDateTime(date) >= new DateTime(1754, 1, 1, 1, 0, 0))
            {
                SqlCommand cmd = new SqlCommand("acceptRequest", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@username", smusername));
                cmd.Parameters.Add(new SqlParameter("@chname", chname));
                cmd.Parameters.Add(new SqlParameter("@c2name", c2name));
                cmd.Parameters.Add(new SqlParameter("@datetime", toDateTime(date)));

                cmd.ExecuteNonQuery();
                Response.Redirect("StadiumManager.aspx");
            }
            else
            {
                Response.Write("Invalid entry!");
            }

            conn.Close();
        }

        protected void rejectRequest(object sender, EventArgs e)
        {
            conn.Open();

            // REJECT REQUEST PROCEDURE
            String smusername = Session["Username"].ToString();
            String chname = TextBox4.Text;
            String c2name = TextBox5.Text;
            String date = TextBox6.Text;

            if (chname != null && chname != "" && !isNumeric(chname) && chname.Length <= 20 &&
                c2name != null && c2name != "" && !isNumeric(c2name) && c2name.Length <= 20 &&
                date != null && date != "" && isDateTime(date) && toDateTime(date) >= new DateTime(1754, 1, 1, 1, 0, 0))
            {
                SqlCommand cmd = new SqlCommand("rejectRequest", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@username", smusername));
                cmd.Parameters.Add(new SqlParameter("@chname", chname));
                cmd.Parameters.Add(new SqlParameter("@c2name", c2name));
                cmd.Parameters.Add(new SqlParameter("@datetime", toDateTime(date)));

                cmd.ExecuteNonQuery();
                Response.Redirect("StadiumManager.aspx");
            }
            else
            {
                Response.Write("Invalid entry!");
            }

            conn.Close();
        }
    }
}