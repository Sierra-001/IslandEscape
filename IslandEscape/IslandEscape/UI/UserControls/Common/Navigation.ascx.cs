using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IslandEscape.UI.UserControls.Common
{
    public partial class Navigation : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
            {
                accountDropdown.Visible = true;
                registerItem.Visible = false;
                loginItem.Visible = false;

                string role = Session["Role"]?.ToString();
                if (role == "Admin")
                {
                    adminItem.Visible = true;
                }
                else
                {
                    adminItem.Visible = false;
                }
            }
            else
            {
                accountDropdown.Visible = false;
                registerItem.Visible = true;
                loginItem.Visible = true;
                adminItem.Visible = false;
            }
        }
    }
}