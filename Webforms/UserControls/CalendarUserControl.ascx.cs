using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Webforms.UserControls;

namespace FormAuthentication.UserControls
{
    public partial class CalendarUserControl : System.Web.UI.UserControl
    {

        public string SelectedDate
        {
            get
            {
                return txtDate.Text;
            }
            set
            {
                txtDate.Text = value;
            }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Calendar1.Visible = false;
            }
        }

        protected void ImgBtn_Click(object sender, ImageClickEventArgs e)
        {
            if (Calendar1.Visible)
            {
                Calendar1.Visible = false;
            }
            else
            {
                Calendar1.Visible = true;      
            }
            CalendarVisibilityChangedEventArgs visibilityChangedEventData = new CalendarVisibilityChangedEventArgs(Calendar1.Visible);
            OnCalendarVisibilityChanged(visibilityChangedEventData);

        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            txtDate.Text = Calendar1.SelectedDate.ToShortDateString();
            Calendar1.Visible = false;
            CalendarVisibilityChangedEventArgs visibilityChangedEventData = new CalendarVisibilityChangedEventArgs(Calendar1.Visible);
            OnCalendarVisibilityChanged(visibilityChangedEventData);


            DateSelectedEventArgs dateSelectedEventData = new DateSelectedEventArgs(Calendar1.SelectedDate);

            OnDateSelected(dateSelectedEventData);

        }


        // create an event : events are variables of type deligate
        public event CalendarVisibilityChangedEventHandler CalendarVisibilityChanged;
        public event DateSelectedEventHandler DateSelected;

        protected virtual void OnCalendarVisibilityChanged (CalendarVisibilityChangedEventArgs e)
        {
            if (CalendarVisibilityChanged !=null)
            {
                CalendarVisibilityChanged(this, e);
            }

        }    protected virtual void OnDateSelected (DateSelectedEventArgs e)
        {
            if (DateSelected != null)
            {
                DateSelected(this, e);
            }

        }

    }
}
