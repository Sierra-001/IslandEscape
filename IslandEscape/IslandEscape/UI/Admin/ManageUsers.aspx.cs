using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using IslandEscape.Core.App_Code.DataAccess;
namespace IslandEscape.UI.Admin 
{ 
    public partial class ManageUsers : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadUsers();
            }
        }

        private void LoadUsers()
        {
            string query = "SELECT * FROM Users ORDER BY CreatedDate DESC";
            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            gvUsers.DataSource = dt;
            gvUsers.DataBind();
        }

        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int userId = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);
            string query = "DELETE FROM Users WHERE UserID = @userId AND Role != 'Admin'";
            var param = DatabaseHelper.CreateParameter("@userId", userId);

            try
            {
                int rowsAffected = DatabaseHelper.ExecuteNonQuery(query, new[] { param });
                if (rowsAffected == 0)
                {
                    // User might be admin or doesn't exist
                }
                LoadUsers();
            }
            catch
            {
                LoadUsers();
            }
        }

        protected void gvUsers_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "ToggleStatus")
            {
                string[] args = e.CommandArgument.ToString().Split('|');
                int userId = Convert.ToInt32(args[0]);
                bool currentStatus = Convert.ToBoolean(args[1]);
                bool newStatus = !currentStatus;

                string query = "UPDATE Users SET IsActive = @isActive WHERE UserID = @userId";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    DatabaseHelper.CreateParameter("@isActive", newStatus),
                    DatabaseHelper.CreateParameter("@userId", userId)
                };

                try
                {
                    DatabaseHelper.ExecuteNonQuery(query, parameters);
                    LoadUsers();
                }
                catch
                {
                    LoadUsers();
                }
            }
        }
    }
}