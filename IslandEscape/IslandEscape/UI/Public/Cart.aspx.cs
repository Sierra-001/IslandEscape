using IslandEscape.Core.App_Code.DataAccess;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;

namespace IslandEscape.UI.Public
{
    public partial class Cart : System.Web.UI.Page
    {
        private int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx?ReturnUrl=" + Server.UrlEncode(Request.RawUrl));
                return;
            }

            userId = Convert.ToInt32(Session["UserID"]);

            if (!IsPostBack)
            {
                LoadCart();
            }
        }

        private void LoadCart()
        {
            string query = @"SELECT c.*, p.Name AS PackageName, p.ImageURL 
                             FROM Cart c
                             INNER JOIN Packages p ON c.PackageID = p.PackageID
                             WHERE c.UserID = @userId";

            var param = DatabaseHelper.CreateParameter("@userId", userId);
            DataTable dt = DatabaseHelper.ExecuteDataTable(query, new[] { param });

            if (dt.Rows.Count == 0)
            {
                divEmpty.Visible = true;
                divCart.Visible = false;
                return;
            }

            divEmpty.Visible = false;
            divCart.Visible = true;

            gvCart.DataSource = dt;
            gvCart.DataBind();

            CalculateTotals();
        }

        private void CalculateTotals()
        {
            string query = "SELECT SUM(Price * Quantity) AS Subtotal FROM Cart WHERE UserID = @userId";
            var param = DatabaseHelper.CreateParameter("@userId", userId);
            object result = DatabaseHelper.ExecuteScalar(query, new[] { param });

            decimal subtotal = result != DBNull.Value ? Convert.ToDecimal(result) : 0;
            decimal tax = subtotal * 0.15m;
            decimal total = subtotal + tax;

            lblSubtotal.Text = subtotal.ToString("N0");
            lblTax.Text = tax.ToString("N0");
            lblTotal.Text = total.ToString("N0");
        }

        protected void gvCart_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int cartId = Convert.ToInt32(gvCart.DataKeys[e.RowIndex].Value);
            string query = "DELETE FROM Cart WHERE CartID = @cartId";
            var param = DatabaseHelper.CreateParameter("@cartId", cartId);
            DatabaseHelper.ExecuteNonQuery(query, new[] { param });

            LoadCart();
        }

        protected void gvCart_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Format price and total columns
                // Custom formatting can be added here
            }
        }

        protected void txtQuantity_TextChanged(object sender, EventArgs e)
        {
            TextBox txtQuantity = (TextBox)sender;
            GridViewRow row = (GridViewRow)txtQuantity.NamingContainer;
            int cartId = Convert.ToInt32(gvCart.DataKeys[row.RowIndex].Value);

            int quantity;
            if (!int.TryParse(txtQuantity.Text, out quantity) || quantity < 1)
            {
                quantity = 1;
                txtQuantity.Text = "1";
            }

            string query = "UPDATE Cart SET Quantity = @quantity WHERE CartID = @cartId";
            SqlParameter[] parameters = new SqlParameter[]
            {
                DatabaseHelper.CreateParameter("@quantity", quantity),
                DatabaseHelper.CreateParameter("@cartId", cartId)
            };
            DatabaseHelper.ExecuteNonQuery(query, parameters);

            LoadCart();
        }

        protected void btnCheckout_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/UI/Secure/Checkout.aspx");
        }
    }
}