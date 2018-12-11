using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Webforms
{
    public partial class WebForm3 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ButtonUserctrl.Click += new EventHandler(ButtonUserctrl_Click);
            CalendarUserControl.CalendarVisibilityChanged += new UserControls.CalendarVisibilityChangedEventHandler(CalendarUserControl_CalendarVisibilityChanged);
            CalendarUserControl.DateSelected += new UserControls.DateSelectedEventHandler(CalendarUserControl_DateSelected);


            //<%@ OutputCache Duration = "60"  Location = "ServerAndClient" VaryByParam = "DropDownList3" %>

            //Response.Cache.SetExpires(DateTime.Now.AddSeconds(60));
            //Response.Cache.VaryByParams["None"] = true;
            //Response.Cache.SetCacheability(HttpCacheability.Server);

            Label1.Text = DateTime.Now.ToString();
            Label2.Text = DateTime.Now.ToString();
            Label3.Text = DateTime.Now.ToString();
            if (!IsPostBack)
            {
                LoadYears();
                LoadMonths();
                LoadGridView();
                GetProductByGender("All");
              
            }
        }

        private void GetProductByGender(string gender)
        {
            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("spGetEmployeesByGender", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;

                SqlParameter paramGender = new SqlParameter();
                paramGender.ParameterName = "@Gender";
                paramGender.Value = gender;
                da.SelectCommand.Parameters.Add(paramGender);
                DataSet DS = new DataSet();
                da.Fill(DS);
                GridView1.DataSource = DS;
                GridView1.DataBind();
            }
                    }

        private void LoadGridView()
        {
            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("spGetEmployess", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataSet DS = new DataSet();
                da.Fill(DS);
                GridViewEmployee.DataSource = DS;
                GridViewEmployee.DataBind();
            }
            Label1.Text = DateTime.Now.ToString();
        }

        private void CalendarUserControl_DateSelected(object sender, UserControls.DateSelectedEventArgs e)
        {
            Response.Write("calender selected value = " + e.SelectedDate + "<br/>");
        }

        private void CalendarUserControl_CalendarVisibilityChanged(object sender, UserControls.CalendarVisibilityChangedEventArgs e)
        {
            Response.Write("Calender visible = " + e.IsCalendarVisible + "<br/>");
        }

        protected void ButtonUserctrl_Click(object sender, EventArgs e)
        {
            Response.Write(CalendarUserControl.SelectedDate + "<br/>");
        }

        private void LoadMonths()
        {
            DataSet dsMonths = new DataSet();
            dsMonths.ReadXml(Server.MapPath("~/Data/Months.xml"));

            DropDownList2.DataTextField = "Name";
            DropDownList2.DataValueField = "Number";

            DropDownList2.DataSource = dsMonths;
            DropDownList2.DataBind();
        }

        private void LoadYears()
        {
            DataSet dsYears = new DataSet();
            dsYears.ReadXml(Server.MapPath("~/Data/Years.xml"));

            DropDownList1.DataTextField = "Number";
            DropDownList1.DataValueField = "Number";

            DropDownList1.DataSource = dsYears;
            DropDownList1.DataBind();
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            int year = Convert.ToInt16(DropDownList1.SelectedValue);
            int month = Convert.ToInt16(DropDownList2.SelectedValue);
            Calendar2.VisibleDate = new DateTime(year, month, 1);
            Calendar2.SelectedDate = new DateTime(year, month, 1);
        }

        protected void DropDownList2_SelectedIndexChanged(object sender, EventArgs e)
        {
            int year = Convert.ToInt16(DropDownList1.SelectedValue);
            int month = Convert.ToInt16(DropDownList2.SelectedValue);
            Calendar2.VisibleDate = new DateTime(year, month, 1);
            Calendar2.SelectedDate = new DateTime(year, month, 1);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            Response.Write(Calendar2.SelectedDate.ToShortDateString() + "<br />");
        }

        protected void ButtonCustomServerControl_Click(object sender, EventArgs e)
        {
            Response.Write(CustomCalendar1.SelectedDate.ToShortDateString() + "<br />");
        }

        protected void CustomCalendar1_DateSelected(object sender, CustomControls.DateSelectedEventArgs e)
        {
            Response.Write("Selected date Event from custom control " + e.SelectedDate.ToShortDateString() + "<br />");

        }
         
        protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
        {
            GetProductByGender(DropDownList3.SelectedValue);
        }
    }
}