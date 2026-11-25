using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using IslandEscape.Core.App_Code.DataAccess;
using IslandEscape.Core.App_Code.Helpers;

namespace IslandEscape.UI.Secure
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/UI/Public/Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }
        }

        protected void btnChange_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string currentPassword = txtCurrentPassword.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();

            if (!SiteUtility.IsStrongPassword(newPassword))
            {
                ShowError("New password must be at least 6 characters with uppercase, lowercase, and a digit.");
                return;
            }

            string query = "SELECT PasswordHash, Salt FROM Users WHERE UserID = @userId";
            var param = DatabaseHelper.CreateParameter("@userId", userId);
            DataTable dt = DatabaseHelper.ExecuteDataTable(query, new[] { param });

            if (dt.Rows.Count == 0)
            {
                ShowError("User not found.");
                return;
            }

            DataRow row = dt.Rows[0];
            string storedHash = row["PasswordHash"].ToString();
            string salt = row["Salt"].ToString();
            string computedHash = SiteUtility.HashPassword(currentPassword, salt);

            if (storedHash != computedHash)
            {
                ShowError("Current password is incorrect.");
                return;
            }

            string newSalt = SiteUtility.GenerateSalt();
            string newHash = SiteUtility.HashPassword(newPassword, newSalt);

            string updateQuery = "UPDATE Users SET PasswordHash = @hash, Salt = @salt WHERE UserID = @userId";
            SqlParameter[] updateParams = new SqlParameter[]
            {
                DatabaseHelper.CreateParameter("@hash", newHash),
                DatabaseHelper.CreateParameter("@salt", newSalt),
                DatabaseHelper.CreateParameter("@userId", userId)
            };

            try
            {
                DatabaseHelper.ExecuteNonQuery(updateQuery, updateParams);
                ShowSuccess("Password changed successfully.");
                Response.Redirect("Profile.aspx?updated=true");
            }
            catch (Exception ex)
            {
                ShowError("An error occurred: " + ex.Message);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("Profile.aspx");
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