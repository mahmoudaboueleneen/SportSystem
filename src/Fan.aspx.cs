using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Security.Cryptography;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Database_Project___Milestone_3
{
    public partial class Fan : System.Web.UI.Page
    {
        static string connStr = WebConfigurationManager.ConnectionStrings["dbproj"].ToString();
        SqlConnection conn = new SqlConnection(connStr);
        // 2D array to store information of each match in the dropdown list to be used when executing purchaseTicket
        static String[ , ] tmpStorage = new String[1000, 3];

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null && Session["Username"] != null)
            {
                String type = (Session["UserType"]).ToString();

                if (Int16.Parse(type) != 5)
                {
                    Response.Redirect("Unauthorized.aspx");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }

            Message_Box.Enabled = false;

            if (Request.QueryString["Parameter"] != null)
            {
                String par = Request.QueryString["Parameter"].ToString();

                if (par == "buySuccess")
                {
                    Message_Box.Text = "Purchase successful!";
                }
                else if (par == "buyBlocked")
                {
                    Message_Box.Text = "You are blocked.";
                    Message_Box.CssClass = "border border-white text-danger bg-white";
                }
            }

            if (!IsPostBack) {
                PopulateAvailableMatches();
            }

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

        
        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {

        }

        protected void logout_button_click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Session["UserType"] = null;
            Response.Redirect("Login.aspx");
        }

        protected void ShowStadiums_button_click(object sender, EventArgs e)
        {
            conn.Open();

            String dateTime = TextBox2.Text;
            if (dateTime != null && dateTime != "" && isDateTime(dateTime) && toDateTime(dateTime) >= new DateTime(1754, 1, 1, 1, 0, 0))
            {
                SqlCommand cmd = new SqlCommand("showAvailableMatchesToAttend", conn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cmd.Parameters.Add(new SqlParameter("@datetime", toDateTime(dateTime)));
                SqlDataReader sdr = cmd.ExecuteReader();
                GridView1.DataSource = sdr;
                GridView1.DataBind();
            }
            else
            {
                Response.Write("Invalid date!");
            }

            conn.Close();
        }

        protected void PopulateAvailableMatches()
        {
            conn.Open();
            DateTime dateTime = DateTime.Now;

            SqlCommand cmd = new SqlCommand("showAvailableMatchesToAttend2", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@datetime", dateTime));

            SqlDataReader sdr = cmd.ExecuteReader();

            DataTable dt = new DataTable();

            ddl.DataSource = dt;
            ddl.DataBind();
            ddl.Items.Insert(0, new ListItem("------- Select a match -------", "0"));

            int i = 1;
            while (sdr.Read())
            {
                tmpStorage.SetValue((String)sdr.GetValue(0), i, 0); // Host club name
                tmpStorage.SetValue((String)sdr.GetValue(1), i, 1); // Guest club name
                tmpStorage.SetValue(sdr.GetValue(4).ToString(), i, 2); // Match start time
                ddl.Items.Insert(i, new ListItem( (String)sdr.GetValue(0) + " vs " + (String)sdr.GetValue(1) + " | Stadium: " + (String)sdr.GetValue(2) + " | Location: " + (String)sdr.GetValue(3) + " | Start time: " + sdr.GetValue(4).ToString() ));
                i++;
            }

            conn.Close();
        }

        protected void PurchaseTicket_button_click(object sender, EventArgs e)
        {
            conn.Open();

            // Get fan national ID
            String username = Session["Username"].ToString();
            SqlCommand cmd = new SqlCommand("getNatIDofFan", conn);
            cmd.CommandType = System.Data.CommandType.StoredProcedure;
            cmd.Parameters.Add(new SqlParameter("@username", username));
            String natID = (String) cmd.ExecuteScalar();

            // Get other needed information
            int i = ddl.SelectedIndex;

            if (i != 0 && i != -1)  // Row Index 0 is reserved for the "Select a match" statement.
            {
                String chname = tmpStorage[i, 0];
                String cgname = tmpStorage[i, 1];
                String datetime = tmpStorage[i, 2];

                // Purchase ticket procedure
                SqlCommand purchaseProc = new SqlCommand("purchaseTicket", conn);
                purchaseProc.CommandType = System.Data.CommandType.StoredProcedure;
                purchaseProc.Parameters.Add(new SqlParameter("@national_id", natID));
                purchaseProc.Parameters.Add(new SqlParameter("@chname", chname));
                purchaseProc.Parameters.Add(new SqlParameter("@cgname", cgname));
                purchaseProc.Parameters.Add(new SqlParameter("@datetime", datetime));
                SqlParameter isBlocked = purchaseProc.Parameters.Add("@isblocked", System.Data.SqlDbType.Int);

                isBlocked.Direction = ParameterDirection.Output;

                purchaseProc.ExecuteNonQuery();

                if (isBlocked.Value.ToString() == "0")
                {
                    Response.Redirect("Fan.aspx?Parameter=buySuccess");
                }
                else
                {
                    Response.Redirect("Fan.aspx?Parameter=buyBlocked");
                }
            }
            else
            {
                Response.Write("Invalid match selection!");
            }
            conn.Close();
        }
    }
}