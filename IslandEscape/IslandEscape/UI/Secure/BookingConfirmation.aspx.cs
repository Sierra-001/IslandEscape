using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using IslandEscape.Core.App_Code.DataAccess;

namespace IslandEscape.UI.Secure
{
    public partial class BookingConfirmation : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/UI/Public/Login.aspx");
                return;
            }

            string transactionId = Request.QueryString["transaction"];

            if (string.IsNullOrEmpty(transactionId))
            {
                Response.Redirect("~/UI/Public/Default.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadConfirmation(transactionId);
            }
        }

        private void LoadConfirmation(string transactionId)
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            string query = @"SELECT TOP 1 BookingNumber, BookingDate 
                             FROM Bookings 
                             WHERE UserID = @userId AND TransactionID = @transactionId 
                             ORDER BY BookingID DESC";

            SqlParameter[] parameters = new SqlParameter[]
            {
                DatabaseHelper.CreateParameter("@userId", userId),
                DatabaseHelper.CreateParameter("@transactionId", transactionId)
            };

            DataTable dt = DatabaseHelper.ExecuteDataTable(query, parameters);

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                lblTransactionId.Text = transactionId;
                lblBookingNumber.Text = row["BookingNumber"].ToString();
                lblBookingDate.Text = Convert.ToDateTime(row["BookingDate"]).ToString("dd MMMM yyyy HH:mm");
            }
            else
            {
                lblTransactionId.Text = transactionId;
                lblBookingNumber.Text = "N/A";
                lblBookingDate.Text = DateTime.Now.ToString("dd MMMM yyyy HH:mm");
            }
        }
    }
}