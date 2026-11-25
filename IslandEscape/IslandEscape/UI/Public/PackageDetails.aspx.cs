using IslandEscape.Core.App_Code.DataAccess;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IslandEscape.UI.Public
{
    public partial class PackageDetails : System.Web.UI.Page
    {
        private int packageId;
        private DataRow packageRow;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out packageId))
            {
                ShowError("Invalid package ID.");
                return;
            }

            string query = "SELECT p.*, c.Name AS CategoryName FROM Packages p " +
                           "INNER JOIN Categories c ON p.CategoryID = c.CategoryID " +
                           "WHERE p.PackageID = @id AND p.IsActive = 1";

            var param = DatabaseHelper.CreateParameter("@id", packageId);
            DataTable dt = DatabaseHelper.ExecuteDataTable(query, new[] { param });

            if (dt.Rows.Count == 0)
            {
                ShowError("Package not found.");
                return;
            }

            packageRow = dt.Rows[0];
            pnlPackage.Visible = true;

            if (!IsPostBack)
            {
                BindPackageData();
            }
        }

        private void BindPackageData()
        {
            lblName.Text = packageRow["Name"].ToString();
            lblCategory.Text = packageRow["CategoryName"].ToString();
            lblLocation.Text = packageRow["Location"].ToString();
            lblDescription.Text = packageRow["Description"].ToString();
            lblPrice.Text = Convert.ToDecimal(packageRow["Price"]).ToString("N0");
            lblDuration.Text = packageRow["Duration"]?.ToString() ?? "N/A";
            lblMaxPersons.Text = packageRow["MaxPersons"]?.ToString() ?? "2";

            bool isActive = Convert.ToBoolean(packageRow["IsActive"]);
            lblStatus.Text = isActive ? "Available" : "Unavailable";
            lblStatus.CssClass = isActive ? "badge bg-success" : "badge bg-danger";

            string imageUrl = packageRow["ImageURL"]?.ToString();
            if (!string.IsNullOrEmpty(imageUrl))
            {
                imgPackage.ImageUrl = "~/Assets/Images/Packages/" + imageUrl;
            }
            else
            {
                imgPackage.ImageUrl = "~/Assets/Images/Packages/default-package.jpg";
            }
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            decimal price = Convert.ToDecimal(packageRow["Price"]);

            string checkQuery = "SELECT COUNT(*) FROM Cart WHERE UserID = @userId AND PackageID = @packageId";
            SqlParameter[] checkParams = new SqlParameter[]
            {
                DatabaseHelper.CreateParameter("@userId", userId),
                DatabaseHelper.CreateParameter("@packageId", packageId)
            };
            int count = Convert.ToInt32(DatabaseHelper.ExecuteScalar(checkQuery, checkParams));

            if (count > 0)
            {
                string updateQuery = "UPDATE Cart SET Quantity = Quantity + 1 WHERE UserID = @userId AND PackageID = @packageId";
                DatabaseHelper.ExecuteNonQuery(updateQuery, checkParams);
            }
            else
            {
                string insertQuery = "INSERT INTO Cart (UserID, PackageID, Quantity, Price) VALUES (@userId, @packageId, 1, @price)";
                SqlParameter[] insertParams = new SqlParameter[]
                {
                    DatabaseHelper.CreateParameter("@userId", userId),
                    DatabaseHelper.CreateParameter("@packageId", packageId),
                    DatabaseHelper.CreateParameter("@price", price)
                };
                DatabaseHelper.ExecuteNonQuery(insertQuery, insertParams);
            }

            ShowSuccess("Package added to cart successfully!");
            Response.Redirect("~/UI/Public/Packages.aspx?added=true");
        }

        protected void btnBookNow_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            Response.Redirect("~/UI/Secure/Checkout.aspx?packageId=" + packageId);
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