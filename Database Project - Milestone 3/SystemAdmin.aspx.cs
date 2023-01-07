using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace Database_Project___Milestone_3
{
    public partial class SystemAdmin : System.Web.UI.Page
    {
        static string connStr = WebConfigurationManager.ConnectionStrings["dbproj"].ToString();
        SqlConnection conn = new SqlConnection(connStr);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserType"] != null && Session["Username"] != null)
            {
                String type = (Session["UserType"]).ToString();

                if (Int16.Parse(type) != 1)
                {
                    Response.Redirect("Unauthorized.aspx");
                }
            }
            else
            {
                Response.Redirect("Login.aspx");
            }
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

        protected void logout_button_click(object sender, EventArgs e)
        {
            Session["Username"] = null;
            Session["UserType"] = null;
            Response.Redirect("Login.aspx");
        }

        protected void addClub_button_click(object sender, EventArgs e)
        {
            // ADD CLUB PROCEDURE
            String addClubName = addClub_name.Text;
            String addClubLocation = addClub_location.Text;

            if(addClubName != null && addClubName != "" && !isNumeric(addClubName) && addClubName.Length <= 20 &&
               addClubLocation != null && addClubLocation != "" && !isNumeric(addClubLocation) && addClubLocation.Length <=20)
            {
                SqlCommand addClub = new SqlCommand("addClub", conn);
                addClub.CommandType = System.Data.CommandType.StoredProcedure;
                addClub.Parameters.Add(new SqlParameter("@cname", addClubName));
                addClub.Parameters.Add(new SqlParameter("@cl", addClubLocation));

                conn.Open();
                addClub.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("SystemAdmin.aspx");
            }
            else
            {
                Response.Write("Invalid entry!");
            }
        }

        protected void deleteClub_button_click(object sender, EventArgs e)
        {
            String deleteClubName = deleteClub_name.Text;

            if(deleteClubName != null && deleteClubName != "" && !isNumeric(deleteClubName) && deleteClubName.Length <= 20)
            {
                SqlCommand deleteClub = new SqlCommand("deleteClub", conn);
                deleteClub.CommandType = System.Data.CommandType.StoredProcedure;
                deleteClub.Parameters.Add(new SqlParameter("@cname", deleteClubName));

                conn.Open();
                deleteClub.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("SystemAdmin.aspx");
            }
            else
            {
                Response.Write("Invalid entry!");
            }
        }

        protected void addStadium_button_click(object sender, EventArgs e)
        {
            String addStadiumName = addStadium_name.Text;
            String addStadiumLocation = addStadium_location.Text;
            String addStadiumCapacity = addStadium_capacity.Text;

            if(addStadiumName != null && addStadiumName != "" && !isNumeric(addStadiumName) && addStadiumName.Length <= 20 &&
               addStadiumLocation != null && addStadiumLocation != "" && !isNumeric(addStadiumLocation) && addStadiumLocation.Length <= 20 &&
               addStadiumCapacity != null && addStadiumCapacity != "" && isNumeric(addStadiumCapacity))
            {
                SqlCommand addStadium = new SqlCommand("addStadium", conn);
                addStadium.CommandType = System.Data.CommandType.StoredProcedure;
                addStadium.Parameters.Add(new SqlParameter("@sname", addStadiumName));
                addStadium.Parameters.Add(new SqlParameter("@sl", addStadiumLocation));
                addStadium.Parameters.Add(new SqlParameter("@sc", toNumeric(addStadiumCapacity)));

                conn.Open();
                addStadium.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("SystemAdmin.aspx");
            }
            else
            {
               Response.Write(isNumeric(addStadiumLocation));

                /*Response.Write(addStadiumName + " " + !isNumeric(addStadiumName) + " " + addStadiumName.Length + " " 
                             + addStadiumLocation + " " + !isNumeric(addStadiumLocation) + " " + addStadiumLocation.Length 
                             + addStadiumCapacity + " " + isNumeric(addStadiumCapacity)
                             );
                */

                //Response.Write("Invalid entry!");
            }
        }

        protected void deleteStadium_button_click(object sender, EventArgs e)
        {
            String deleteStadiumName = deleteStadium_name.Text;
            
            if(deleteStadiumName != null && deleteStadiumName != "" && !isNumeric(deleteStadiumName) && deleteStadiumName.Length <= 20)
            {
                SqlCommand deleteStadium = new SqlCommand("deleteStadium", conn);
                deleteStadium.CommandType = System.Data.CommandType.StoredProcedure;
                deleteStadium.Parameters.Add(new SqlParameter("@sname", deleteStadiumName));

                conn.Open();
                deleteStadium.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("SystemAdmin.aspx");
            }
            else
            {
                Response.Write("Invalid entry!");
            }
        }

        protected void blockFan_button_click(object sender, EventArgs e)
        {
            String blockFanNationalID = blockFan_nationalID.Text;

            if(blockFanNationalID != null && blockFanNationalID != "" && blockFanNationalID.Length <= 20)
            {
                SqlCommand blockFan = new SqlCommand("blockFan", conn);
                blockFan.CommandType = System.Data.CommandType.StoredProcedure;
                blockFan.Parameters.Add(new SqlParameter("@f_n", blockFanNationalID));

                conn.Open();
                blockFan.ExecuteNonQuery();
                conn.Close();

                Response.Redirect("SystemAdmin.aspx");
            }
            else
            {
                Response.Write("Invalid entry!");
            }
        }
    }
}