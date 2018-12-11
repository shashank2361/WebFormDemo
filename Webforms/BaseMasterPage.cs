using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

namespace Webforms
{
    public abstract class BaseMasterPage : System.Web.UI.MasterPage    
    {
        public abstract Panel SearchPanel { get; }
        public abstract string SearchTerm { get; }
        public abstract Button SearchButton { get; }
    }
}