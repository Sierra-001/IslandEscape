using IslandEscape.Core.App_Code.DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IslandEscape.UI.Public
{
    public partial class Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeaturedPackages();
                LoadCategories();
                LoadLocations();
            }
        }

        private void LoadFeaturedPackages()
        {
            string query = "SELECT TOP 6 * FROM Packages WHERE IsFeatured = 1 AND IsActive = 1 ORDER BY CreatedDate DESC";
            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            rptFeaturedPackages.DataSource = dt;
            rptFeaturedPackages.DataBind();
        }

        private void LoadCategories()
        {
            string query = "SELECT * FROM Categories WHERE IsActive = 1 ORDER BY DisplayOrder";
            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "Name";
            ddlCategory.DataValueField = "CategoryID";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All Categories", ""));
        }

        private void LoadLocations()
        {
            string query = "SELECT DISTINCT Location FROM Packages WHERE IsActive = 1 ORDER BY Location";
            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            ddlLocation.DataSource = dt;
            ddlLocation.DataTextField = "Location";
            ddlLocation.DataValueField = "Location";
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, new System.Web.UI.WebControls.ListItem("All Locations", ""));
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            Response.Redirect("Packages.aspx?search=" + txtSearch.Text.Trim() +
                "&category=" + ddlCategory.SelectedValue +
                "&location=" + ddlLocation.SelectedValue);
        }
    }
}