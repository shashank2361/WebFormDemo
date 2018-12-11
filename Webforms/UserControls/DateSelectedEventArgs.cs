using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Webforms.UserControls
{
    public delegate void DateSelectedEventHandler(object sender, DateSelectedEventArgs e);


    public class DateSelectedEventArgs : EventArgs
    {
        private DateTime _selectedDate;

        public DateSelectedEventArgs(DateTime selectedDate)
        {
            this._selectedDate = selectedDate;
        }

        public DateTime SelectedDate
        {
            get
            {
                return this._selectedDate;
            }
        }
    }
}