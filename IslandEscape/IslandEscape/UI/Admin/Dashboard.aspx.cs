using IslandEscape.Core.App_Code.DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IslandEscape.UI.Admin
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStats();
                LoadRecentBookings();
            }
        }

        private void LoadStats()
        {
            string packageQuery = "SELECT COUNT(*) FROM Packages WHERE IsActive = 1";
            lblTotalPackages.Text = DatabaseHelper.ExecuteScalar(packageQuery).ToString();

            string userQuery = "SELECT COUNT(*) FROM Users WHERE IsActive = 1";
            lblTotalUsers.Text = DatabaseHelper.ExecuteScalar(userQuery).ToString();

            string bookingQuery = "SELECT COUNT(*) FROM Bookings WHERE IsActive = 1";
            lblTotalBookings.Text = DatabaseHelper.ExecuteScalar(bookingQuery).ToString();

            string revenueQuery = "SELECT ISNULL(SUM(TotalAmount), 0) FROM Bookings WHERE Status = 'Confirmed' AND IsActive = 1";
            decimal revenue = Convert.ToDecimal(DatabaseHelper.ExecuteScalar(revenueQuery));
            lblTotalRevenue.Text = revenue.ToString("N0") + " MUR";
        }

        private void LoadRecentBookings()
        {
            string query = @"SELECT TOP 5 b.*, u.FullName, p.Name AS PackageName 
                             FROM Bookings b 
                             INNER JOIN Users u ON b.UserID = u.UserID 
                             INNER JOIN Packages p ON b.PackageID = p.PackageID 
                             WHERE b.IsActive = 1 
                             ORDER BY b.BookingDate DESC";

            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            gvRecentBookings.DataSource = dt;
            gvRecentBookings.DataBind();
        }
    }
}