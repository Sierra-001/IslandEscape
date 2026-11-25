using IslandEscape.Core.App_Code.DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IslandEscape.UI.Public
{
    public partial class Packages : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFilterCategories();
                LoadPackages();
            }
        }

        private void LoadFilterCategories()
        {
            string query = "SELECT * FROM Categories WHERE IsActive = 1 ORDER BY DisplayOrder";
            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            rptFilterCategories.DataSource = dt;
            rptFilterCategories.DataBind();
        }

        private void LoadPackages()
        {
            string search = Request.QueryString["search"] ?? "";
            string category = Request.QueryString["category"] ?? "";
            string location = Request.QueryString["location"] ?? "";

            StringBuilder query = new StringBuilder();
            query.Append("SELECT p.*, c.Name AS CategoryName FROM Packages p ");
            query.Append("INNER JOIN Categories c ON p.CategoryID = c.CategoryID ");
            query.Append("WHERE p.IsActive = 1");

            if (!string.IsNullOrEmpty(search))
            {
                query.Append(" AND (p.Name LIKE '%" + search.Replace("'", "''") + "%' ");
                query.Append(" OR p.Description LIKE '%" + search.Replace("'", "''") + "%')");
            }

            if (!string.IsNullOrEmpty(category))
            {
                query.Append(" AND p.CategoryID = " + category);
            }

            if (!string.IsNullOrEmpty(location))
            {
                query.Append(" AND p.Location = '" + location.Replace("'", "''") + "'");
            }

            query.Append(" ORDER BY p.IsFeatured DESC, p.CreatedDate DESC");

            DataTable dt = DatabaseHelper.ExecuteDataTable(query.ToString());

            if (dt.Rows.Count == 0)
            {
                divNoResults.Visible = true;
                rptPackages.Visible = false;
                lblResultCount.Text = "0 packages found";
            }
            else
            {
                divNoResults.Visible = false;
                rptPackages.Visible = true;
                rptPackages.DataSource = dt;
                rptPackages.DataBind();
                lblResultCount.Text = dt.Rows.Count + " packages found";
            }
        }
    }
}