using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.UI;

namespace IslandEscape
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            RouteTable.Routes.MapPageRoute("Home", "", "~/UI/Public/Default.aspx");
            RouteTable.Routes.MapPageRoute("Packages", "packages", "~/UI/Public/Packages.aspx");
            RouteTable.Routes.MapPageRoute("Login", "login", "~/UI/Public/Login.aspx");
            RouteTable.Routes.MapPageRoute("Register", "register", "~/UI/Public/Register.aspx");

            ScriptManager.ScriptResourceMapping.AddDefinition(
            "jquery",
            new ScriptResourceDefinition
            {
                Path = "~/Assets/JS/jquery-3.7.1.min.js",
                DebugPath = "~/Assets/JS/jquery-3.7.1.min.js",
                CdnPath = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js",
                CdnDebugPath = "https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"
            });
        }
        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {
            if (HttpContext.Current.User != null &&
                HttpContext.Current.User.Identity.IsAuthenticated &&
                HttpContext.Current.Session != null)
            {
                string role = HttpContext.Current.Session["Role"] as string;

                if (!string.IsNullOrEmpty(role))
                {
                    GenericIdentity identity = new GenericIdentity(HttpContext.Current.User.Identity.Name);
                    string[] roles = new string[] { role };
                    GenericPrincipal principal = new GenericPrincipal(identity, roles);

                    HttpContext.Current.User = principal;
                    System.Threading.Thread.CurrentPrincipal = principal;
                }
            }
        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}