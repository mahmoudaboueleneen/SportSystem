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
    public partial class ClubRepresentative : System.Web.UI.Page
    {
        static String connStr = WebConfigurationManager.ConnectionStrings["dbproj"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null && Session["Username"] != null)
            {
                String type = (Session["UserType"]).ToString();

                if (Int16.Parse(type) != 3)
                {
                    Response.Redirect("Unauthorized.aspx");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

            ShowClubInfo();
            ShowClubUpcomingMatches();
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

        protected void logout_button_click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Session["UserType"] = null;
            Response.Redirect("Login.aspx");
        }

        protected void ShowClubInfo()
        {
            conn.Open();
            String crusername = Session["Username"].ToString();
            SqlCommand cmd = new SqlCommand("showClubInfo", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", crusername));
            SqlDataReader sdr = cmd.ExecuteReader();
            GridView1.DataSource = sdr;
            GridView1.DataBind();
            conn.Close();
        }

        protected void ShowClubUpcomingMatches()
        {
            conn.Open();

            // GET REPRESENTATIVE'S CLUB NAME
            String username = Session["Username"].ToString();
            SqlCommand cmd = new SqlCommand("getClubOfRep", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", username));
            String clubname = (String) cmd.ExecuteScalar();

            // PASS REPRESENTATIVE'S CLUB NAME TO SQL PROCEDURE & EXECUTE
            SqlCommand upcomingMatchesProc = new SqlCommand("showClubUpcomingMatches", conn);
            upcomingMatchesProc.CommandType = System.Data.CommandType.StoredProcedure;
            upcomingMatchesProc.Parameters.Add(new SqlParameter("@cname",clubname));
            SqlDataReader sdr = upcomingMatchesProc.ExecuteReader();
            GridView2.DataSource = sdr;
            GridView2.DataBind();
            conn.Close();
        }

        protected void ShowStadiums_button_click(object sender, EventArgs e)
        {
            conn.Open();
            String date = AvDate.Text;

            if (date != null && date != "" && isDateTime(date) && toDateTime(date) >= new DateTime(1754, 1, 1, 1, 0, 0))
            {
                SqlCommand cmd = new SqlCommand("showAvailableStadiumsOn", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@datetime", toDateTime(date)));

                SqlDataReader sdr = cmd.ExecuteReader();
                GridView3.DataSource = sdr;
                GridView3.DataBind();
            }
            else
            {
                Response.Write("Invalid date!");
            }

            conn.Close();
        }

        protected void SendRequest_button_click(object sender, EventArgs e)
        {
            conn.Open();

            // GET REPRESENTATIVE'S CLUB NAME
            String username = Session["Username"].ToString();
            SqlCommand cmd = new SqlCommand("getClubOfRep", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", username));
            String clubname = (String)cmd.ExecuteScalar();

            // SEND REQUEST PROCEDURE
            String sname = TextBox1.Text;
            String date = TextBox2.Text;

            if (clubname == null)
            {
                Response.Write("Invalid request: You are currently not representing a club!");
            }
            else
            {
                if(sname != null && sname != "" && !isNumeric(sname) && sname.Length <= 20 &&
                   date != null && date != "" && isDateTime(date) && toDateTime(date) >= new DateTime(1754, 1, 1, 1, 0, 0))
                {
                    SqlCommand addRequestProc = new SqlCommand("addHostRequest", conn);
                    addRequestProc.CommandType = System.Data.CommandType.StoredProcedure;
                    addRequestProc.Parameters.Add(new SqlParameter("@cname", clubname));
                    addRequestProc.Parameters.Add(new SqlParameter("@sname", sname));
                    addRequestProc.Parameters.Add(new SqlParameter("@datetime", toDateTime(date)));

                    addRequestProc.ExecuteNonQuery();
                    Response.Redirect("ClubRepresentative.aspx");
                }
                else
                {
                    Response.Write("Invalid request!");
                }
            }
            conn.Close();
        }
    }
}