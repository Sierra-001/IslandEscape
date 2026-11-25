using IslandEscape.Core.App_Code.DataAccess;
using IslandEscape.UI.Public;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IslandEscape.UI.Admin
{
    public partial class ManagePackages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadPackages();
            }
        }

        private void LoadPackages()
        {
            string query = "SELECT * FROM Packages ORDER BY CreatedDate DESC";
            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            gvPackages.DataSource = dt;
            gvPackages.DataBind();
        }

        protected void btnAddNew_Click(object sender, EventArgs e)
        {
            Response.Redirect("AddPackage.aspx");
        }

        protected void gvPackages_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPackages.EditIndex = e.NewEditIndex;
            LoadPackages();
        }

        protected void gvPackages_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPackages.EditIndex = -1;
            LoadPackages();
        }

        protected void gvPackages_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int packageId = Convert.ToInt32(gvPackages.DataKeys[e.RowIndex].Value);

            GridViewRow row = gvPackages.Rows[e.RowIndex];
            string name = (row.Cells[1].Controls[0] as TextBox).Text;
            string location = (row.Cells[2].Controls[0] as TextBox).Text;
            decimal price = Convert.ToDecimal((row.Cells[3].Controls[0] as TextBox).Text);
            bool isActive = (row.Cells[4].Controls[0] as CheckBox).Checked;

            string query = @"UPDATE Packages 
                             SET Name = @name, Location = @location, Price = @price, 
                                 IsActive = @isActive, UpdatedDate = GETDATE() 
                             WHERE PackageID = @id";

            SqlParameter[] parameters = new SqlParameter[]
            {
                DatabaseHelper.CreateParameter("@name", name),
                DatabaseHelper.CreateParameter("@location", location),
                DatabaseHelper.CreateParameter("@price", price),
                DatabaseHelper.CreateParameter("@isActive", isActive),
                DatabaseHelper.CreateParameter("@id", packageId)
            };

            try
            {
                DatabaseHelper.ExecuteNonQuery(query, parameters);
                gvPackages.EditIndex = -1;
                LoadPackages();
            }
            catch
            {
                gvPackages.EditIndex = -1;
                LoadPackages();
            }
        }

        protected void gvPackages_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int packageId = Convert.ToInt32(gvPackages.DataKeys[e.RowIndex].Value);

            string query = "DELETE FROM Packages WHERE PackageID = @id";
            var param = DatabaseHelper.CreateParameter("@id", packageId);

            try
            {
                DatabaseHelper.ExecuteNonQuery(query, new[] { param });
                LoadPackages();
            }
            catch
            {
                LoadPackages();
            }
        }
    }
}