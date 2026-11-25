using IslandEscape.Core.App_Code.DataAccess;
using IslandEscape.Core.App_Code.Helpers;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;

namespace IslandEscape.UI.Public
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string subject = txtSubject.Text.Trim();
            string message = txtMessage.Text.Trim();

            if (!SiteUtility.IsValidEmail(email))
            {
                ShowError("Please enter a valid email address.");
                return;
            }

            object userId = Session["UserID"] ?? DBNull.Value;

            string query = @"INSERT INTO Queries (UserID, Name, Email, Subject, Message, SubmittedDate, Status) 
                     VALUES (@userId, @name, @email, @subject, @message, GETDATE(), 'New')";

            SqlParameter[] parameters = new SqlParameter[]
            {
                DatabaseHelper.CreateParameter("@userId", userId),
                DatabaseHelper.CreateParameter("@name", name),
                DatabaseHelper.CreateParameter("@email", email),
                DatabaseHelper.CreateParameter("@subject", subject),
                DatabaseHelper.CreateParameter("@message", message)
            };

            try
            {
                DatabaseHelper.ExecuteNonQuery(query, parameters);
                ShowSuccess("Your message has been sent successfully! We'll get back to you soon.");

                txtName.Text = "";
                txtEmail.Text = "";
                txtSubject.Text = "";
                txtMessage.Text = "";
            }
            catch
            {
                ShowError("An error occurred while sending your message.");
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