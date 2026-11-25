using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IslandEscape.Core.App_Code.DataAccess;
using System.Data;
using System.Data.SqlClient;

namespace IslandEscape.UI.Admin
{
    public partial class ManageQueries : System.Web.UI.Page
    {
        private int currentQueryId
        {
            get
            {
                if (ViewState["CurrentQueryId"] == null)
                    return 0;
                return (int)ViewState["CurrentQueryId"];
            }
            set
            {
                ViewState["CurrentQueryId"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadQueries();
                pnlQueryDetails.Visible = false;
            }
        }

        private void LoadQueries()
        {
            string query = "SELECT * FROM Queries ORDER BY SubmittedDate DESC";
            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            gvQueries.DataSource = dt;
            gvQueries.DataBind();
        }

        protected void gvQueries_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                string arg = e.CommandArgument.ToString();
                //ClientScript.RegisterStartupScript(this.GetType(), "DebugView", "alert('View clicked. CommandArgument: " + arg + "');", true);

                currentQueryId = Convert.ToInt32(arg);

                //ClientScript.RegisterStartupScript(this.GetType(), "DebugView2", "alert('currentQueryId set to: " + currentQueryId + "');", true);

                LoadQueryDetails(currentQueryId);
                pnlQueryDetails.Visible = true;
            }
        }

        private void LoadQueryDetails(int queryId)
        {
            string query = "SELECT * FROM Queries WHERE QueryID = @queryId";
            var param = DatabaseHelper.CreateParameter("@queryId", queryId);
            DataTable dt = DatabaseHelper.ExecuteDataTable(query, new[] { param });

            if (dt.Rows.Count > 0)
            {
                DataRow row = dt.Rows[0];
                lblName.Text = row["Name"].ToString();
                lblEmail.Text = row["Email"].ToString();
                lblSubject.Text = row["Subject"].ToString();
                lblDate.Text = Convert.ToDateTime(row["SubmittedDate"]).ToString("dd MMM yyyy HH:mm");
                lblMessage.Text = row["Message"].ToString();

                string status = row["Status"].ToString();
                if (ddlStatus.Items.FindByValue(status) != null)
                {
                    ddlStatus.SelectedValue = status;
                }

                if (row["AdminReply"] != DBNull.Value)
                {
                    txtReply.Text = row["AdminReply"].ToString();
                }
                else
                {
                    txtReply.Text = "";
                }
            }
        }

        protected void btnUpdateStatus_Click(object sender, EventArgs e)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "DebugUpdate", "alert('Update clicked. currentQueryId = " + currentQueryId + "');", true);

            if (currentQueryId > 0)
            {
                string newStatus = ddlStatus.SelectedValue;

                string query = "UPDATE Queries SET Status = @status WHERE QueryID = @queryId";
                SqlParameter[] parameters = new SqlParameter[]
                {
                    DatabaseHelper.CreateParameter("@status", newStatus),
                    DatabaseHelper.CreateParameter("@queryId", currentQueryId)
                };

                try
                {
                    int rowsAffected = DatabaseHelper.ExecuteNonQuery(query, parameters);

                    ClientScript.RegisterStartupScript(this.GetType(), "DebugInfo",
                        "alert('Rows affected: " + rowsAffected + "\\nQueryID: " + currentQueryId + "\\nNew Status: " + newStatus + "');", true);

                    if (rowsAffected > 0)
                    {
                        LoadQueries();
                        LoadQueryDetails(currentQueryId);

                        //ClientScript.RegisterStartupScript(this.GetType(), "StatusUpdate", "alert('Status updated to: " + newStatus + "');", true);
                    }
                    else
                    {
                        //ClientScript.RegisterStartupScript(this.GetType(), "NoUpdate", "alert('No rows were updated. Please check if the QueryID is correct.');", true);
                    }
                }
                catch (Exception ex)
                {
                    //ClientScript.RegisterStartupScript(this.GetType(), "StatusError", "alert('Error: " + ex.Message + "');", true);
                }
            }
            else
            {
                //ClientScript.RegisterStartupScript(this.GetType(), "NoQuery", "alert('No query selected. Please select a query first.');", true);
            }
        }

        protected void btnSendReply_Click(object sender, EventArgs e)
        {
            if (currentQueryId <= 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "NoQuery",
                    "alert('Please select a query first.');", true);
                return;
            }

            string reply = txtReply.Text.Trim();
            if (string.IsNullOrEmpty(reply))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ReplyError",
                    "alert('Please enter a reply message.');", true);
                return;
            }

            try
            {
                string getInfoQuery = "SELECT Email, Name FROM Queries WHERE QueryID = @queryId";
                var infoParam = DatabaseHelper.CreateParameter("@queryId", currentQueryId);
                DataTable infoDt = DatabaseHelper.ExecuteDataTable(getInfoQuery, new[] { infoParam });

                string customerEmail = "";
                string customerName = "";
                if (infoDt.Rows.Count > 0)
                {
                    customerEmail = infoDt.Rows[0]["Email"].ToString();
                    customerName = infoDt.Rows[0]["Name"].ToString();
                }

                string query = @"UPDATE Queries 
                         SET AdminReply = @reply, 
                             Status = 'Resolved', 
                             RepliedDate = GETDATE() 
                         WHERE QueryID = @queryId";

                SqlParameter[] parameters = new SqlParameter[]
                {
                    DatabaseHelper.CreateParameter("@reply", reply),
                    DatabaseHelper.CreateParameter("@queryId", currentQueryId)
                };

                int rowsAffected = DatabaseHelper.ExecuteNonQuery(query, parameters);

                if (rowsAffected > 0)
                {
                    string message = "Reply sent successfully to " + customerName + " (" + customerEmail + ")";
                    ClientScript.RegisterStartupScript(this.GetType(), "ReplySuccess", "alert('" + message + "');", true);

                    LoadQueries();
                    LoadQueryDetails(currentQueryId);
                    txtReply.Text = "";
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "NoUpdate", "alert('No rows were updated. Query ID: " + currentQueryId + "');", true);
                }
            }
            catch (Exception ex)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "ReplyError", "alert('Error: " + ex.Message + "');", true);
            }
        }

        protected void btnCloseDetails_Click(object sender, EventArgs e)
        {
            pnlQueryDetails.Visible = false;
            currentQueryId = 0;
        }
    }
}