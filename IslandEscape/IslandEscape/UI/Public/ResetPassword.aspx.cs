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
    public partial class ResetPassword : System.Web.UI.Page
    {
        private string token;
        private int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            token = Request.QueryString["token"];

            if (string.IsNullOrEmpty(token))
            {
                ShowError("Invalid or missing reset token.");
                btnReset.Enabled = false;
                return;
            }

            string query = "SELECT UserID FROM PasswordResetTokens WHERE Token = @token AND Used = 0 AND ExpiryDate > GETDATE()";
            var param = DatabaseHelper.CreateParameter("@token", token);
            DataTable dt = DatabaseHelper.ExecuteDataTable(query, new[] { param });

            if (dt.Rows.Count == 0)
            {
                ShowError("Invalid or expired reset token.");
                btnReset.Enabled = false;
                return;
            }

            userId = Convert.ToInt32(dt.Rows[0]["UserID"]);
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            string password = txtPassword.Text.Trim();

            if (!SiteUtility.IsStrongPassword(password))
            {
                ShowError("Password must be at least 6 characters with uppercase, lowercase, and a digit.");
                return;
            }

            string salt = SiteUtility.GenerateSalt();
            string passwordHash = SiteUtility.HashPassword(password, salt);

            string updateQuery = "UPDATE Users SET PasswordHash = @hash, Salt = @salt WHERE UserID = @userId";
            SqlParameter[] updateParams = new SqlParameter[]
            {
                DatabaseHelper.CreateParameter("@hash", passwordHash),
                DatabaseHelper.CreateParameter("@salt", salt),
                DatabaseHelper.CreateParameter("@userId", userId)
            };
            DatabaseHelper.ExecuteNonQuery(updateQuery, updateParams);

            string tokenQuery = "UPDATE PasswordResetTokens SET Used = 1 WHERE Token = @token";
            var tokenParam = DatabaseHelper.CreateParameter("@token", token);
            DatabaseHelper.ExecuteNonQuery(tokenQuery, new[] { tokenParam });

            ShowSuccess("Password reset successfully! <a href='Login.aspx'>Click here to login</a>");
            txtPassword.Text = "";
            txtConfirmPassword.Text = "";
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