using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IslandEscape.Core.App_Code.DataAccess;
using System.Data;
using System.Data.SqlClient;

namespace IslandEscape.UI.Admin
{
    public partial class ManageBookings : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadBookings();
            }
        }

        private void LoadBookings()
        {
            string query = @"SELECT b.*, u.FullName, p.Name AS PackageName 
                             FROM Bookings b 
                             INNER JOIN Users u ON b.UserID = u.UserID 
                             INNER JOIN Packages p ON b.PackageID = p.PackageID 
                             WHERE b.IsActive = 1 
                             ORDER BY b.BookingDate DESC";

            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            gvBookings.DataSource = dt;
            gvBookings.DataBind();
        }

        protected void gvBookings_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdateStatus")
            {
                int bookingId = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = (GridViewRow)((Button)e.CommandSource).NamingContainer;
                DropDownList ddlStatus = (DropDownList)row.FindControl("ddlStatus");

                string newStatus = ddlStatus.SelectedValue;

                string query = "UPDATE Bookings SET Status = @status WHERE BookingID = @bookingId";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    DatabaseHelper.CreateParameter("@status", newStatus),
                    DatabaseHelper.CreateParameter("@bookingId", bookingId)
                };

                try
                {
                    DatabaseHelper.ExecuteNonQuery(query, parameters);
                    LoadBookings();
                }
                catch
                {
                    LoadBookings();
                }
            }
        }
    }
}