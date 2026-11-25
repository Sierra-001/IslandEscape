using IslandEscape.Core.App_Code.DataAccess;
using IslandEscape.Core.App_Code.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IslandEscape.UI.Public
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string fullName = txtFullName.Text.Trim();
            string username = txtUsername.Text.Trim();
            string email = txtEmail.Text.Trim();
            string password = txtPassword.Text.Trim();
            string phone = txtPhone.Text.Trim();

            if (!SiteUtility.IsValidEmail(email))
            {
                ShowError("Please enter a valid email address.");
                return;
            }

            if (!SiteUtility.IsStrongPassword(password))
            {
                ShowError("Password must be at least 6 characters with uppercase, lowercase, and a digit.");
                return;
            }

            string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username = @username OR Email = @email";
            SqlParameter[] checkParams = new SqlParameter[]
            {
                DatabaseHelper.CreateParameter("@username", username),
                DatabaseHelper.CreateParameter("@email", email)
            };
            int count = Convert.ToInt32(DatabaseHelper.ExecuteScalar(checkQuery, checkParams));

            if (count > 0)
            {
                ShowError("Username or email already exists. Please try another.");
                return;
            }

            string salt = SiteUtility.GenerateSalt();
            string passwordHash = SiteUtility.HashPassword(password, salt);

            string insertQuery = @"INSERT INTO Users (Username, Email, PasswordHash, Salt, FullName, Phone, Role, IsActive) 
                                   VALUES (@username, @email, @passwordHash, @salt, @fullName, @phone, 'Customer', 1)";

            SqlParameter[] insertParams = new SqlParameter[]
            {
                DatabaseHelper.CreateParameter("@username", username),
                DatabaseHelper.CreateParameter("@email", email),
                DatabaseHelper.CreateParameter("@passwordHash", passwordHash),
                DatabaseHelper.CreateParameter("@salt", salt),
                DatabaseHelper.CreateParameter("@fullName", fullName),
                DatabaseHelper.CreateParameter("@phone", string.IsNullOrEmpty(phone) ? DBNull.Value : (object)phone)
            };

            try
            {
                DatabaseHelper.ExecuteNonQuery(insertQuery, insertParams);
                ShowSuccess("Registration successful! You will be redirected to Login page.");
                txtFullName.Text = "";
                txtUsername.Text = "";
                txtEmail.Text = "";
                txtPassword.Text = "";
                txtConfirmPassword.Text = "";
                txtPhone.Text = "";

                string script = "setTimeout(function(){ window.location.href = 'Login.aspx'; }, 5000);";
                ClientScript.RegisterStartupScript(this.GetType(), "Redirect", script, true);
            }
            catch (Exception ex)
            {
                ShowError("An error occurred during registration." + ex.Message);
            }
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