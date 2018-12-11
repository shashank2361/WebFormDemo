using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Optimization;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace Webforms
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            Application["UsersOnline"] = 0;
        }
        
        void Session_Start(object sender, EventArgs e)
        {
            // Code that runs when a new user session is started
            Application.Lock();
            Application["UsersOnline"] = (int)Application["UsersOnline"] + 1;
            Application.UnLock();
        }
        void Session_End(object sender, EventArgs e)
        {
            // Code that runs when an existing user session ends. 
            Application.Lock();
            Application["UsersOnline"] = (int)Application["UsersOnline"] - 1;
            Application.UnLock();
        }



        protected void Application_Error(object sender, EventArgs e)
        {

            //If the redirection is done in Application_Error() event handler in Global.asax, custom error pages will have no effect. This is mostly used

            // Get the exception details and log it in the database or event viewer
            Exception ex = Server.GetLastError();
             if (ex != null )
            {
               // Logger.Log(ex);
                Server.ClearError();
                //Server.Transfer("~/Error.aspx");
            }
        }
    }
}