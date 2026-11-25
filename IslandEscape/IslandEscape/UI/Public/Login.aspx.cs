using IslandEscape.Core.App_Code.DataAccess;
using IslandEscape.Core.App_Code.Helpers;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Security.Principal;
namespace IslandEscape.UI.Public
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["logout"] == "true")
                {
                    FormsAuthentication.SignOut();
                    Session.Clear();
                    Session.Abandon();
                    Response.Redirect("Login.aspx");
                }
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            string query = "SELECT * FROM Users WHERE Username = @username OR Email = @username";
            var param = DatabaseHelper.CreateParameter("@username", username);
            DataTable dt = DatabaseHelper.ExecuteDataTable(query, new[] { param });

            if (dt.Rows.Count == 0)
            {
                ShowError("Invalid username or password.");
                return;
            }

            DataRow row = dt.Rows[0];

            if (!Convert.ToBoolean(row["IsActive"]))
            {
                ShowError("Your account has been deactivated.");
                return;
            }

            string storedHash = row["PasswordHash"].ToString();
            string salt = row["Salt"].ToString();
            string computedHash = SiteUtility.HashPassword(password, salt);

            if (storedHash == computedHash)
            {
                string updateQuery = "UPDATE Users SET LastLoginDate = GETDATE() WHERE UserID = " + row["UserID"];
                DatabaseHelper.ExecuteNonQuery(updateQuery);

                Session["UserID"] = row["UserID"];
                Session["Username"] = row["Username"];
                Session["FullName"] = row["FullName"];
                Session["Role"] = row["Role"];

                FormsAuthentication.SetAuthCookie(username, chkRemember.Checked);

                string returnUrl = Request.QueryString["ReturnUrl"];
                if (!string.IsNullOrEmpty(returnUrl))
                {
                    Response.Redirect(returnUrl);
                }
                else
                {
                    string role = Session["Role"]?.ToString();
                    if (role == "Admin")
                    {
                        Response.Redirect("~/UI/Admin/Dashboard.aspx");
                    }
                    else
                    {
                        Response.Redirect("Default.aspx");
                    }
                }
            }
            else
            {
                ShowError("Invalid username or password.");
            }
        }

        private void ShowError(string message)
        {
            lblMessage.Text = message;
            lblMessage.Visible = true;
        }
    }
}