using IslandEscape.Core.App_Code.DataAccess;
using IslandEscape.Core.App_Code.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IslandEscape.UI.Public
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        protected void btnReset_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            if (!SiteUtility.IsValidEmail(email))
            {
                ShowError("Please enter a valid email address.");
                return;
            }

            string query = "SELECT UserID FROM Users WHERE Email = @email AND IsActive = 1";
            var param = DatabaseHelper.CreateParameter("@email", email);
            DataTable dt = DatabaseHelper.ExecuteDataTable(query, new[] { param });

            if (dt.Rows.Count == 0)
            {
                ShowError("No active account found with that email address.");
                return;
            }

            int userId = Convert.ToInt32(dt.Rows[0]["UserID"]);
            string token = SiteUtility.GenerateToken();
            DateTime expiry = DateTime.Now.AddHours(24);

            string insertQuery = "INSERT INTO PasswordResetTokens (UserID, Token, ExpiryDate) VALUES (@userId, @token, @expiry)";
            SqlParameter[] insertParams = new SqlParameter[]
            {
                DatabaseHelper.CreateParameter("@userId", userId),
                DatabaseHelper.CreateParameter("@token", token),
                DatabaseHelper.CreateParameter("@expiry", expiry)
            };
            DatabaseHelper.ExecuteNonQuery(insertQuery, insertParams);

            string resetLink = "ResetPassword.aspx?token=" + token;
            
            ShowSuccess("Password reset link has been sent to your email. <br/><br/>" + "<strong>Demo:</strong> <a href='" + resetLink + "'>Click here to reset your password</a>");
            txtEmail.Text = "";
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