using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Xml.Linq;
using IslandEscape.Core.App_Code.DataAccess;

namespace IslandEscape.UI.Admin
{
    public partial class AddPackage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadCategories();
            }
        }

        private void LoadCategories()
        {
            string query = "SELECT CategoryID, Name FROM Categories WHERE IsActive = 1 ORDER BY DisplayOrder";
            DataTable dt = DatabaseHelper.ExecuteDataTable(query);
            ddlCategory.DataSource = dt;
            ddlCategory.DataTextField = "Name";
            ddlCategory.DataValueField = "CategoryID";
            ddlCategory.DataBind();
            ddlCategory.Items.Insert(0, new System.Web.UI.WebControls.ListItem("-- Select Category --", ""));
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlCategory.SelectedValue) ||
                string.IsNullOrEmpty(txtName.Text.Trim()) ||
                string.IsNullOrEmpty(txtDescription.Text.Trim()) ||
                string.IsNullOrEmpty(txtPrice.Text.Trim()) ||
                string.IsNullOrEmpty(txtLocation.Text.Trim()))
            {
                ShowError("Please fill in all required fields.");
                return;
            }

            decimal price;
            if (!decimal.TryParse(txtPrice.Text.Trim(), out price))
            {
                ShowError("Please enter a valid price.");
                return;
            }

            int categoryId = Convert.ToInt32(ddlCategory.SelectedValue);
            string name = txtName.Text.Trim();
            string description = txtDescription.Text.Trim();
            decimal discountedPrice = 0;
            decimal? discount = null;

            if (!string.IsNullOrEmpty(txtDiscountedPrice.Text.Trim()))
            {
                if (decimal.TryParse(txtDiscountedPrice.Text.Trim(), out discountedPrice))
                {
                    discount = discountedPrice;
                }
            }

            string duration = txtDuration.Text.Trim();
            string location = txtLocation.Text.Trim();

            int maxPersons = 2;
            if (!string.IsNullOrEmpty(txtMaxPersons.Text.Trim()))
            {
                int.TryParse(txtMaxPersons.Text.Trim(), out maxPersons);
            }

            string imageUrl = txtImageURL.Text.Trim();
            bool isFeatured = chkIsFeatured.Checked;
            bool isActive = chkIsActive.Checked;

            string query = @"INSERT INTO Packages (CategoryID, Name, Description, Price, DiscountedPrice, 
                               Duration, Location, MaxPersons, ImageURL, IsFeatured, IsActive, CreatedDate)
                               VALUES (@categoryId, @name, @description, @price, @discountedPrice, 
                               @duration, @location, @maxPersons, @imageUrl, @isFeatured, @isActive, GETDATE())";

            SqlParameter[] parameters = new SqlParameter[]
            {
                DatabaseHelper.CreateParameter("@categoryId", categoryId),
                DatabaseHelper.CreateParameter("@name", name),
                DatabaseHelper.CreateParameter("@description", description),
                DatabaseHelper.CreateParameter("@price", price),
                DatabaseHelper.CreateParameter("@discountedPrice", discount.HasValue ? (object)discount.Value : DBNull.Value),
                DatabaseHelper.CreateParameter("@duration", duration ?? ""),
                DatabaseHelper.CreateParameter("@location", location),
                DatabaseHelper.CreateParameter("@maxPersons", maxPersons),
                DatabaseHelper.CreateParameter("@imageUrl", imageUrl ?? ""),
                DatabaseHelper.CreateParameter("@isFeatured", isFeatured),
                DatabaseHelper.CreateParameter("@isActive", isActive)
            };

            try
            {
                DatabaseHelper.ExecuteNonQuery(query, parameters);
                ShowSuccess("Package added successfully!");
                lblMessage.Visible = false;

                ddlCategory.SelectedIndex = 0;
                txtName.Text = "";
                txtDescription.Text = "";
                txtPrice.Text = "";
                txtDiscountedPrice.Text = "";
                txtDuration.Text = "";
                txtLocation.Text = "";
                txtMaxPersons.Text = "";
                txtImageURL.Text = "";
                chkIsFeatured.Checked = false;
                chkIsActive.Checked = true;
            }
            catch (Exception ex)
            {
                ShowError("An error occurred: " + ex.Message);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("ManagePackages.aspx");
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