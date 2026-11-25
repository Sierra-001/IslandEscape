using IslandEscape.Core.App_Code.DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IslandEscape.UI.Secure
{
    public partial class Profile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/UI/Public/Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            if (Request.QueryString["updated"] == "true")
            {
              ShowSuccess("Password changed successfully!");
            }

            if (!IsPostBack)
            {
                LoadProfile();
            }
        }

        private void LoadProfile()
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string query = "SELECT * FROM Users WHERE UserID = @userId";
            var param = DatabaseHelper.CreateParameter("@userId", userId);
            DataTable dt = DatabaseHelper.ExecuteDataTable(query, new[] { param });

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                txtFullName.Text = row["FullName"].ToString();
                lblUsername.Text = row["Username"].ToString();
                lblEmail.Text = row["Email"].ToString();
                txtPhone.Text = row["Phone"]?.ToString() ?? "";
                lblMemberSince.Text = Convert.ToDateTime(row["CreatedDate"]).ToString("dd MMMM yyyy");

                string fullName = row["FullName"].ToString();
                string[] nameParts = fullName.Split(' ');
                string initials = "";
                if (nameParts.Length >= 2)
                {
                    initials = nameParts[0][0].ToString().ToUpper() + nameParts[nameParts.Length - 1][0].ToString().ToUpper();
                }
                else
                {
                    initials = fullName.Substring(0, Math.Min(2, fullName.Length)).ToUpper();
                }
                lblInitials.Text = initials;
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int userId = Convert.ToInt32(Session["UserID"]);
            string fullName = txtFullName.Text.Trim();
            string phone = txtPhone.Text.Trim();

            if (string.IsNullOrEmpty(fullName))
            {
                ShowError("Full name is required.");
                return;
            }

            string query = "UPDATE Users SET FullName = @fullName, Phone = @phone WHERE UserID = @userId";
            SqlParameter[] parameters = new SqlParameter[]
            {
                DatabaseHelper.CreateParameter("@fullName", fullName),
                DatabaseHelper.CreateParameter("@phone", string.IsNullOrEmpty(phone) ? (object)DBNull.Value : (object)phone),
                DatabaseHelper.CreateParameter("@userId", userId)
            };

            try
            {
                DatabaseHelper.ExecuteNonQuery(query, parameters);

                Session["FullName"] = fullName;

                ShowSuccess("Profile updated successfully!");
            }
            catch (Exception ex)
            {
                ShowError("An error occurred: " + ex.Message);
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