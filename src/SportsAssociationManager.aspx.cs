using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.Configuration;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Database_Project___Milestone_3
{
    public partial class SportsAssociationManager : System.Web.UI.Page
    {
        static String connStr = WebConfigurationManager.ConnectionStrings["dbproj"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null && Session["Username"] != null)
            {
                String type = (Session["UserType"]).ToString();

                if (Int16.Parse(type) != 2)
                {
                    Response.Redirect("Unauthorized.aspx");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

            ShowUpcomingMatches();
            ShowPlayedMatches();
            ShowClubsNeverPlayed();
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

        protected void AddMatch_Button_Click(object sender, EventArgs e)
        {
            String chname = TextBox2.Text;
            String cgname = TextBox3.Text;
            String start_time = TextBox4.Text;
            String end_time = TextBox5.Text;

            // ADD MATCH PROCEDURE
            if (chname != null && chname != "" && !isNumeric(chname) && chname.Length <= 20 &&
                cgname != null && cgname != "" && !isNumeric(cgname) && cgname.Length <= 20 &&
                start_time != null && start_time != "" && isDateTime(start_time) && toDateTime(start_time) >= new DateTime(1754, 1, 1, 1, 0, 0) &&
                end_time != null && end_time != "" && isDateTime(end_time) && toDateTime(end_time) >= new DateTime(1754, 1, 1, 1, 0, 0))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("addNewMatch", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@chname", TextBox2.Text));
                cmd.Parameters.Add(new SqlParameter("@cgname", TextBox3.Text));
                cmd.Parameters.Add(new SqlParameter("@start_time", toDateTime(TextBox4.Text)));
                cmd.Parameters.Add(new SqlParameter("@end_time", toDateTime(TextBox5.Text)));

                cmd.ExecuteNonQuery();
                conn.Close();
                Response.Redirect("SportsAssociationManager.aspx");
            }
            else
            {
                Response.Write("Invalid entry!");
            }
        }

        protected void DeleteMatch_Button_Click(object sender, EventArgs e)
        {
            String chname = TextBox6.Text;
            String cgname = TextBox7.Text;
            String start_time = TextBox8.Text;
            String end_time = TextBox9.Text;

            // DELETE MATCH PROCEDURE
            if (chname != null && chname != "" && !isNumeric(chname) && chname.Length <= 20 &&
                cgname != null && cgname != "" && !isNumeric(cgname) && cgname.Length <= 20 &&
                start_time != null && start_time != "" && isDateTime(start_time) && toDateTime(start_time) >= new DateTime(1754, 1, 1, 1, 0, 0) &&
                end_time != null && end_time != "" && isDateTime(end_time) && toDateTime(end_time) >= new DateTime(1754, 1, 1, 1, 0, 0))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("deleteMatch2", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@chname", TextBox6.Text));
                cmd.Parameters.Add(new SqlParameter("@cgname", TextBox7.Text));
                cmd.Parameters.Add(new SqlParameter("@start_time", toDateTime(TextBox8.Text)));
                cmd.Parameters.Add(new SqlParameter("@end_time", toDateTime(TextBox9.Text)));
                
                cmd.ExecuteNonQuery();
                conn.Close();
                Response.Redirect("SportsAssociationManager.aspx");
            }
            else
            {
                Response.Write("Invalid entry!");
            }
        }

        protected void ShowUpcomingMatches()
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT CH.name AS host_club, CG.name AS guest_club, M.start_time, M.end_time " +
                                             "FROM Match M, Club CH, Club CG WHERE M.start_time > CURRENT_TIMESTAMP " +
                                             "AND M.host_club_id = CH.id AND M.guest_club_id = CG.id", conn);

            cmd.CommandType = System.Data.CommandType.Text;

            SqlDataReader sdr = cmd.ExecuteReader();
            GridView1.DataSource = sdr;
            GridView1.DataBind();
            conn.Close();
        }

        protected void ShowPlayedMatches()
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT CH.name AS host_club, CG.name AS guest_club, M.start_time, M.end_time " +
                                            "FROM Match M, Club CH, Club CG WHERE M.end_time < CURRENT_TIMESTAMP " +
                                            "AND M.host_club_id = CH.id AND M.guest_club_id = CG.id", conn);

            cmd.CommandType = System.Data.CommandType.Text;

            SqlDataReader sdr = cmd.ExecuteReader();
            GridView2.DataSource = sdr;
            GridView2.DataBind();
            conn.Close();
        }

        protected void ShowClubsNeverPlayed()
        {
            conn.Open();
            SqlCommand cmd = new SqlCommand("SELECT * FROM clubsNeverScheduled", conn);
            cmd.CommandType = System.Data.CommandType.Text;

            SqlDataReader sdr = cmd.ExecuteReader();
            GridView3.DataSource = sdr;
            GridView3.DataBind();
            conn.Close();
        }
    }
}