using IslandEscape.Core.App_Code.DataAccess;
using System;
using System.Data;
using System.Data.SqlClient;

namespace IslandEscape.UI.Admin
{
    public partial class Reports : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSummaryCards();
                LoadStatusBreakdown();
                LoadRevenueSummary();
                LoadTopPackages();
                LoadRecentActivity();
            }
        }

        protected string GetStatusBadge(string status)
        {
            switch (status)
            {
                case "Pending": return "badge-warning";
                case "Confirmed": return "badge-success";
                case "Completed": return "badge-info";
                case "Cancelled": return "badge-danger";
                default: return "badge-secondary";
            }
        }

        private void LoadSummaryCards()
        {
            string bookingQuery = "SELECT COUNT(*) FROM Bookings WHERE IsActive = 1";
            int totalBookings = Convert.ToInt32(DatabaseHelper.ExecuteScalar(bookingQuery));
            lblTotalBookings.Text = totalBookings.ToString();

            string revenueQuery = "SELECT ISNULL(SUM(TotalAmount), 0) FROM Bookings WHERE IsActive = 1";
            decimal totalRevenue = Convert.ToDecimal(DatabaseHelper.ExecuteScalar(revenueQuery));
            lblTotalRevenue.Text = totalRevenue.ToString("N0") + " MUR";

            string customerQuery = "SELECT COUNT(*) FROM Users WHERE IsActive = 1 AND Role = 'Customer'";
            int totalCustomers = Convert.ToInt32(DatabaseHelper.ExecuteScalar(customerQuery));
            lblTotalCustomers.Text = totalCustomers.ToString();

            string packageQuery = "SELECT COUNT(*) FROM Packages WHERE IsActive = 1";
            int totalPackages = Convert.ToInt32(DatabaseHelper.ExecuteScalar(packageQuery));
            lblTotalPackages.Text = totalPackages.ToString();
        }

        private void LoadStatusBreakdown()
        {
            string query = @"
                SELECT 
                    ISNULL((SELECT COUNT(*) FROM Bookings WHERE Status = 'Pending' AND IsActive = 1), 0) AS Pending,
                    ISNULL((SELECT COUNT(*) FROM Bookings WHERE Status = 'Confirmed' AND IsActive = 1), 0) AS Confirmed,
                    ISNULL((SELECT COUNT(*) FROM Bookings WHERE Status = 'Completed' AND IsActive = 1), 0) AS Completed,
                    ISNULL((SELECT COUNT(*) FROM Bookings WHERE Status = 'Cancelled' AND IsActive = 1), 0) AS Cancelled
            ";

            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                lblPending.Text = row["Pending"].ToString();
                lblConfirmed.Text = row["Confirmed"].ToString();
                lblCompleted.Text = row["Completed"].ToString();
                lblCancelled.Text = row["Cancelled"].ToString();
            }
        }

        private void LoadRevenueSummary()
        {
            string query = @"SELECT 
                                DATENAME(month, BookingDate) AS Month,
                                COUNT(*) AS TotalBookings,
                                ISNULL(SUM(TotalAmount), 0) AS TotalRevenue
                             FROM Bookings
                             WHERE BookingDate >= DATEADD(month, -6, GETDATE())
                             AND IsActive = 1
                             GROUP BY DATEPART(month, BookingDate), DATENAME(month, BookingDate)
                             ORDER BY DATEPART(month, BookingDate) DESC";

            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            rptRevenueSummary.DataSource = dt;
            rptRevenueSummary.DataBind();

            if (dt.Rows.Count > 0)
            {
                phRevenueSummary.Visible = true;
                lblRevenueEmpty.Visible = false;
            }
            else
            {
                phRevenueSummary.Visible = false;
                lblRevenueEmpty.Visible = true;
            }
        }

        private void LoadTopPackages()
        {
            string query = @"SELECT TOP 5
                                p.Name AS PackageName,
                                COUNT(b.BookingID) AS TotalBookings,
                                ISNULL(SUM(b.TotalAmount), 0) AS TotalRevenue
                             FROM Bookings b
                             INNER JOIN Packages p ON b.PackageID = p.PackageID
                             WHERE b.IsActive = 1
                             GROUP BY p.Name
                             ORDER BY TotalBookings DESC";

            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            rptTopPackages.DataSource = dt;
            rptTopPackages.DataBind();

            if (dt.Rows.Count > 0)
            {
                phTopPackages.Visible = true;
                lblTopEmpty.Visible = false;
            }
            else
            {
                phTopPackages.Visible = false;
                lblTopEmpty.Visible = true;
            }
        }

        private void LoadRecentActivity()
        {
            string query = @"SELECT TOP 10
                                b.BookingDate AS Timestamp,
                                b.BookingNumber,
                                p.Name AS PackageName,
                                u.FullName AS CustomerName,
                                b.TotalAmount,
                                b.Status
                             FROM Bookings b
                             INNER JOIN Users u ON b.UserID = u.UserID
                             INNER JOIN Packages p ON b.PackageID = p.PackageID
                             WHERE b.IsActive = 1
                             ORDER BY b.BookingDate DESC";

            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            rptActivity.DataSource = dt;
            rptActivity.DataBind();

            if (dt.Rows.Count > 0)
            {
                phActivity.Visible = true;
                lblActivityEmpty.Visible = false;
            }
            else
            {
                phActivity.Visible = false;
                lblActivityEmpty.Visible = true;
            }
        }
    }
}