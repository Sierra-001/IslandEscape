using IslandEscape.Core.App_Code.Helpers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IslandEscape.UI.UserControls.Package
{
    public partial class PackageCard : System.Web.UI.UserControl
    {
        public int PackageID { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public string ImageURL { get; set; }
        public string BadgeText { get; set; }
        public string BadgeClass { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
            }
        }

        private void BindData()
        {
            lblName.Text = Name;
            lblDescription.Text = SiteUtility.TruncateText(Description, 100);
            lblPrice.Text = Price.ToString("N0");

            if (!string.IsNullOrEmpty(ImageURL))
            {
                imgPackage.ImageUrl = "~/Assets/Images/Packages/" + ImageURL;
            }

            hlDetails.NavigateUrl = "~/UI/Public/PackageDetails.aspx?id=" + PackageID;

            if (!string.IsNullOrEmpty(BadgeText))
            {
                lblBadge.Text = BadgeText;
                lblBadge.Visible = true;
                if (!string.IsNullOrEmpty(BadgeClass))
                {
                    lblBadge.CssClass = "package-badge " + BadgeClass;
                }
            }
        }
    }
}