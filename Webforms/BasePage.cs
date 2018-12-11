using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Webforms
{
    public class BasePage : System.Web.UI.Page
    {
        protected override void OnPreInit(EventArgs e)
        {
            if (Session["Selected_MasterPage"] != null)
            {
                this.MasterPageFile = Session["Selected_MasterPage"].ToString();
            }
        }
        
    }
}