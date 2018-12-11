using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Webforms.UserControls
{

    public delegate void CalendarVisibilityChangedEventHandler(object sender, CalendarVisibilityChangedEventArgs e);

    public class CalendarVisibilityChangedEventArgs : EventArgs
    {

        private bool _isCalendarVisible;
        public CalendarVisibilityChangedEventArgs(bool  isCalendarVisible )
        {
            this._isCalendarVisible = isCalendarVisible;
        }
        public bool IsCalendarVisible
        {
            get
            {
                return this._isCalendarVisible;
            }
        }
    }

 





}