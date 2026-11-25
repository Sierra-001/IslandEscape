using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.IO;
using IslandEscape.Core.App_Code.DataAccess;
using IslandEscape.Core.App_Code.Extension;

namespace IslandEscape.UI.Secure
{
    public partial class PurchaseHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/UI/Public/Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            if (!IsPostBack)
            {
                LoadPurchaseHistory();
            }
        }

        private void LoadPurchaseHistory()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string query = @"SELECT b.*, p.Name AS PackageName 
                             FROM Bookings b 
                             INNER JOIN Packages p ON b.PackageID = p.PackageID 
                             WHERE b.UserID = @userId 
                             AND b.BookingDate >= DATEADD(month, -3, GETDATE())
                             AND b.IsActive = 1
                             ORDER BY b.BookingDate DESC";

            var param = DatabaseHelper.CreateParameter("@userId", userId);
            DataTable dt = DatabaseHelper.ExecuteDataTable(query, new[] { param });

            if (dt.Rows.Count == 0)
            {
                ShowError("No purchases in the last 3 months.");
            }

            gvBookings.DataSource = dt;
            gvBookings.DataBind();
        }

        protected void lnkDownload_Click(object sender, EventArgs e)
        {
            System.Web.UI.WebControls.LinkButton lnk = (System.Web.UI.WebControls.LinkButton)sender;
            int bookingId = Convert.ToInt32(lnk.CommandArgument);

            int userId = Convert.ToInt32(Session["UserID"]);
            string query = @"SELECT b.*, p.Name AS PackageName, p.Description, u.FullName, u.Email, u.Phone
                     FROM Bookings b
                     INNER JOIN Packages p ON b.PackageID = p.PackageID
                     INNER JOIN Users u ON b.UserID = u.UserID
                     WHERE b.BookingID = @bookingId AND b.UserID = @userId";

            SqlParameter[] parameters = new SqlParameter[]
            {
        DatabaseHelper.CreateParameter("@bookingId", bookingId),
        DatabaseHelper.CreateParameter("@userId", userId)
            };

            DataTable dt = DatabaseHelper.ExecuteDataTable(query, parameters);
            if (dt.Rows.Count == 0)
            {
                lblMessage.Text = "Booking not found.";
                lblMessage.Visible = true;
                return;
            }

            DataRow row = dt.Rows[0];
            byte[] pdfBytes = PDFGenerator.GenerateInvoice(
                row["BookingNumber"].ToString(),
                row["FullName"].ToString(),
                row["Email"].ToString(),
                row["Phone"]?.ToString() ?? "N/A",
                row["PackageName"].ToString(),
                row["Description"].ToString(),
                Convert.ToInt32(row["NumPersons"]),
                Convert.ToDecimal(row["TotalAmount"]),
                Convert.ToDateTime(row["BookingDate"]),
                row["TravelDate"] != DBNull.Value ? (DateTime?)row["TravelDate"] : null,
                row["Status"].ToString()
            );

            Response.Clear();
            Response.ContentType = "application/pdf";
            Response.AddHeader("Content-Disposition", "attachment; filename=Invoice_" + row["BookingNumber"] + ".pdf");
            Response.BinaryWrite(pdfBytes);
            Response.End();
        }

        private void ShowSuccess(string message)
        {
            lblMessage.CssClass = "alert alert-success";
            lblMessage.Text = message;
            lblMessage.Visible = true;
        }

        private void ShowError(string message)
        {
            lblMessage.CssClass = "alert alert-danger";
            lblMessage.Text = message;
            lblMessage.Visible = true;
        }
    }
}