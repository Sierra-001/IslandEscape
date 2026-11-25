using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using IslandEscape.Core.App_Code.DataAccess;

namespace IslandEscape.UI.Secure
{
    public partial class MyQueries : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/UI/Public/Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            if (!IsPostBack)
            {
                LoadQueries();
            }
        }

        private void LoadQueries()
        {
            int userId = Convert.ToInt32(Session["UserID"]);

            string query = @"SELECT QueryID, Subject, Message, SubmittedDate, Status, AdminReply 
                             FROM Queries 
                             WHERE UserID = @userId 
                             ORDER BY SubmittedDate DESC";

            var param = DatabaseHelper.CreateParameter("@userId", userId);
            DataTable dt = DatabaseHelper.ExecuteDataTable(query, new[] { param });

            if (dt.Rows.Count == 0)
            {
                lblMessage.Text = "You have not submitted any queries.";
                lblMessage.Visible = true;
            }

            gvQueries.DataSource = dt;
            gvQueries.DataBind();
        }
    }
}