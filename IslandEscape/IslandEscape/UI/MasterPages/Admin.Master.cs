using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Security.Principal;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IslandEscape.UI.MasterPages
{
    public partial class Admin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           if (Session["UserID"] == null)
            {
                FormsAuthentication.RedirectToLoginPage();
                return;
            }

            string role = Session["Role"]?.ToString();
            if (role != "Admin")
            {
                FormsAuthentication.RedirectToLoginPage();
                return;
            }
        }
    }
}