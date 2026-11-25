using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IslandEscape.Core.App_Code.DataAccess;
using IslandEscape.Core.App_Code.Helpers;
using System.Data;
using System.Data.SqlClient;

namespace IslandEscape.UI.Secure
{
    public partial class Checkout : System.Web.UI.Page
    {
        private int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/UI/Public/Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            userId = Convert.ToInt32(Session["UserID"]);

            if (!IsPostBack)
            {
                if (!string.IsNullOrEmpty(Request.QueryString["packageId"]))
                {
                    int packageId;
                    if (int.TryParse(Request.QueryString["packageId"], out packageId))
                    {
                        string checkQuery = "SELECT COUNT(*) FROM Cart WHERE UserID = @userId AND PackageID = @packageId";
                        SqlParameter[] checkParams = new SqlParameter[]
                        {
                            DatabaseHelper.CreateParameter("@userId", userId),
                            DatabaseHelper.CreateParameter("@packageId", packageId)
                        };
                        int count = Convert.ToInt32(DatabaseHelper.ExecuteScalar(checkQuery, checkParams));

                        if (count == 0)
                        {
                            string priceQuery = "SELECT Price FROM Packages WHERE PackageID = @packageId";
                            var priceParam = DatabaseHelper.CreateParameter("@packageId", packageId);
                            decimal price = Convert.ToDecimal(DatabaseHelper.ExecuteScalar(priceQuery, new[] { priceParam }));

                            string insertQuery = "INSERT INTO Cart (UserID, PackageID, Quantity, Price) VALUES (@userId, @packageId, 1, @price)";
                            SqlParameter[] insertParams = new SqlParameter[]
                            {
                                DatabaseHelper.CreateParameter("@userId", userId),
                                DatabaseHelper.CreateParameter("@packageId", packageId),
                                DatabaseHelper.CreateParameter("@price", price)
                            };
                            DatabaseHelper.ExecuteNonQuery(insertQuery, insertParams);
                        }
                    }
                }

                LoadCartItems();
                CalculateTotal();
            }
        }

        private void LoadCartItems()
        {
            string query = @"SELECT c.*, p.Name AS PackageName 
                             FROM Cart c
                             INNER JOIN Packages p ON c.PackageID = p.PackageID
                             WHERE c.UserID = @userId";

            var param = DatabaseHelper.CreateParameter("@userId", userId);
            DataTable dt = DatabaseHelper.ExecuteDataTable(query, new[] { param });

            if (dt.Rows.Count == 0)
            {
                Response.Redirect("~/UI/Public/Packages.aspx");
                return;
            }

            rptCartItems.DataSource = dt;
            rptCartItems.DataBind();
        }

        private void CalculateTotal()
        {
            string query = "SELECT SUM(Price * Quantity) AS Subtotal FROM Cart WHERE UserID = @userId";
            var param = DatabaseHelper.CreateParameter("@userId", userId);
            object result = DatabaseHelper.ExecuteScalar(query, new[] { param });

            decimal subtotal = result != DBNull.Value ? Convert.ToDecimal(result) : 0;
            decimal tax = subtotal * 0.15m;
            decimal total = subtotal + tax;

            lblSubtotal.Text = subtotal.ToString("N0");
            lblTax.Text = tax.ToString("N0");
            lblTotal.Text = total.ToString("N0");
        }

        protected void btnPlaceOrder_Click(object sender, EventArgs e)
        {
            string paymentMethod = ddlPaymentMethod.SelectedValue;

            if (paymentMethod == "CreditCard" || paymentMethod == "DebitCard")
            {
                if (string.IsNullOrEmpty(txtCardNumber.Text.Trim()) ||
                    string.IsNullOrEmpty(txtExpiry.Text.Trim()) ||
                    string.IsNullOrEmpty(txtCVV.Text.Trim()) ||
                    string.IsNullOrEmpty(txtCardholderName.Text.Trim()))
                {
                    ShowError("Please fill in all card details.");
                    return;
                }

                string cardNumber = txtCardNumber.Text.Trim().Replace(" ", "");
                if (cardNumber.Length != 16 || !IsNumeric(cardNumber))
                {
                    ShowError("Please enter a valid 16-digit card number.");
                    return;
                }

                string expiry = txtExpiry.Text.Trim();
                string[] expiryParts = expiry.Split('/');
                if (expiryParts.Length != 2 ||
                    !int.TryParse(expiryParts[0], out int month) ||
                    !int.TryParse(expiryParts[1], out int year) ||
                    month < 1 || month > 12 ||
                    year < DateTime.Now.Year % 100 ||
                    (year == DateTime.Now.Year % 100 && month < DateTime.Now.Month))
                {
                    ShowError("Please enter a valid expiry date (MM/YY).");
                    return;
                }

                string cvv = txtCVV.Text.Trim();
                if (cvv.Length < 3 || cvv.Length > 4 || !IsNumeric(cvv))
                {
                    ShowError("Please enter a valid 3 or 4 digit CVV.");
                    return;
                }
            }
            else if (paymentMethod == "BankTransfer")
            {
                if (string.IsNullOrEmpty(txtBankName.Text.Trim()) ||
                    string.IsNullOrEmpty(txtAccountNumber.Text.Trim()) ||
                    string.IsNullOrEmpty(txtBranch.Text.Trim()))
                {
                    ShowError("Please fill in all bank transfer details.");
                    return;
                }
            }
            else
            {
                ShowError("Please select a valid payment method.");
                return;
            }

            try
            {
                string transactionId = SiteUtility.GenerateTransactionId();

                string cartQuery = "SELECT * FROM Cart WHERE UserID = @userId";
                var cartParam = DatabaseHelper.CreateParameter("@userId", userId);
                DataTable cartItems = DatabaseHelper.ExecuteDataTable(cartQuery, new[] { cartParam });

                if (cartItems.Rows.Count == 0)
                {
                    ShowError("Your cart is empty.");
                    return;
                }

                foreach (DataRow cartRow in cartItems.Rows)
                {
                    int packageId = Convert.ToInt32(cartRow["PackageID"]);
                    int quantity = Convert.ToInt32(cartRow["Quantity"]);
                    decimal price = Convert.ToDecimal(cartRow["Price"]);
                    decimal itemTotal = price * quantity;

                    string bookingNumber = SiteUtility.GenerateBookingNumber();

                    string insertQuery = @"INSERT INTO Bookings 
                        (UserID, BookingNumber, PackageID, NumPersons, TotalAmount, 
                         PaymentMethod, TransactionID, SpecialRequests, 
                         Status, PaymentStatus, BookingDate)
                         VALUES 
                        (@userId, @bookingNumber, @packageId, @numPersons, @totalAmount, 
                         @paymentMethod, @transactionId, @specialRequests, 
                         'Confirmed', 'Paid', GETDATE())";

                    SqlParameter[] insertParams = new SqlParameter[]
                    {
                        DatabaseHelper.CreateParameter("@userId", userId),
                        DatabaseHelper.CreateParameter("@bookingNumber", bookingNumber),
                        DatabaseHelper.CreateParameter("@packageId", packageId),
                        DatabaseHelper.CreateParameter("@numPersons", quantity),
                        DatabaseHelper.CreateParameter("@totalAmount", itemTotal),
                        DatabaseHelper.CreateParameter("@paymentMethod", paymentMethod),
                        DatabaseHelper.CreateParameter("@transactionId", transactionId),
                        DatabaseHelper.CreateParameter("@specialRequests", txtSpecialRequests.Text.Trim() ?? "")
                    };

                    DatabaseHelper.ExecuteNonQuery(insertQuery, insertParams);
                }

                string clearQuery = "DELETE FROM Cart WHERE UserID = @userId";
                var clearParam = DatabaseHelper.CreateParameter("@userId", userId);
                DatabaseHelper.ExecuteNonQuery(clearQuery, new[] { clearParam });

                Response.Redirect("BookingConfirmation.aspx?transaction=" + transactionId);
            }
            catch (Exception ex)
            {
                ShowError("An error occurred while processing your order: " + ex.Message);
            }
        }

        private bool IsNumeric(string value)
        {
            foreach (char c in value)
                if (!char.IsDigit(c)) return false;
            return true;
        }

        private void ShowError(string message)
        {
            lblError.Text = message;
            lblError.Visible = true;
        }
    }
}