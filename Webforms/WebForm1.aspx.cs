using FormAuthentication.UserControls;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Webforms.UserControls;

namespace Webforms
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        public string Name
        {
            get
            {
                return TextBoxName.Text;
            }
        }

        public string Place
        {
            get
            {
                return TextBoxPlace.Text;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write(System.Security.Principal.WindowsIdentity.GetCurrent().Name + "<br/>");
            //Dynamc UserControl
            CalendarUserControl CuC = (CalendarUserControl)LoadControl("~/UserControls/CalendarUserControl.ascx");
            CuC.ID = "CU1";
            PlaceHolder1.Controls.Add(CuC);
            CuC.DateSelected += new DateSelectedEventHandler(CuC_DateSelected);
            Panel1.Controls.Add(LoadControl("~/UserControls/CalendarUserControl.ascx"));

            if (Application["UsersOnline"] != null)
            {
                Response.Write("Number of Users Online = " +
                    Application["UsersOnline"].ToString() + "<br/>");
            }
            TextBox2.Focus();
            HyperLink2.Focus();
            if (!IsPostBack)
            {
                if (Request.Browser.Cookies)
                {
                    if (Request.QueryString["CheckCookie"] == null)
                    {
                        // Create the test cookie object
                        HttpCookie cookie = new HttpCookie("TestCookie", "1");
                        Response.Cookies.Add(cookie);
                        // Redirect to the same webform
                        Response.Redirect("WebForm1.aspx?CheckCookie=1");
                    }
                    else
                    {
                        //Check the existence of the test cookie
                        HttpCookie cookie = Request.Cookies["TestCookie"];
                        if (cookie == null)
                        {
                            lblCookieMessage.Text = "We have detected that, the cookies are disabled on your browser. Please enable cookies.";
                        }
                    }

       
                  

                }



                LoadCityDropDownList();
                PopulateContinentsDropDownList();
                PostGraduateCheckBox.Checked = true;
                Calendar1.Visible = false;

                checkboxListEducation.SelectedValue = "2";
                AdRotator1.KeywordFilter = "Google";

                Response.Write("Page Loaded for the first time" + "<br/>");
                Button6.Click += new EventHandler(Button6_Click);
                Button6.Command += new CommandEventHandler(Button6_Command);


                string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(CS))
                {
                    SqlCommand cmd = new SqlCommand("select a.id as Id ,  a.Name  as City ,  b.Name as Country from tblCity a join tblCountry b  on a.CountryId = b.Id ", con);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    DropDownList2.DataSource = rdr;

                    DropDownList2.DataTextField = "City";
                    DropDownList2.DataValueField = "Id";
                    DropDownList2.DataBind();
                }
                // EnityFramework
                using (var ctx = new DBCS())
                {
                    var cites = ctx.tblCities.ToList(); ;
                    DropDownList3.DataSource = cites;
                    DropDownList3.DataTextField = "CityName";
                    DropDownList3.DataValueField = "CityId";
                    DropDownList3.DataBind();
                }

                DataSet DS = new DataSet();
                //Read the xml data from the XML file using ReadXml() method

                DS.ReadXml(Server.MapPath("Countries.xml"));
                DropDownList4.DataTextField = "CountryName";
                DropDownList4.DataValueField = "CountryId";
                DropDownList4.DataSource = DS;
                DropDownList4.DataBind();
                ListItem li = new ListItem("Select", "-1");
                DropDownList4.Items.Insert(0, li);

                ddlCountries.Enabled = false;
                ddlCities.Enabled = false;

                //----List box fill
                using (var ctx = new DBCS())
                {
                    var cites = ctx.tblCities.Select(x => x.CityName).ToList(); ;
                    ListBox2.DataSource = cites;
                    ListBox2.DataBind();
                }
                ///// Add to list controls  : 

                AddListItems(DropDownList5);
                AddListItems(CheckBoxList1);
                AddListItems(RadioButtonList1);
                AddListItems(ListBox4);
                AddListItems(BulletedList3);
            }



            // Adding controls Dynamically

            DropDownList DDL = new DropDownList();
            DDL.ID = "DDL1";
            DDL.Items.Add("New York");
            DDL.Items.Add("New Jeresy");
            DDL.Items.Add("Washington");
            DDL.Visible = false;
            PlaceHolder2.Controls.Add(DDL);


            TextBox TB = new TextBox();
            TB.ID = "TB1";
            PlaceHolder2.Controls.Add(TB);
            TB.Visible = false;

            if (DropDownList7.SelectedValue == "TB")
            {
                TB.Visible = true;
                //DDL.Visible = false;
            }
            else if (DropDownList7.SelectedValue == "DDL")
            {
                DDL.Visible = true;
                //TB.Visible = false;
            }

        }

       

        private void CuC_DateSelected(object sender, DateSelectedEventArgs e)
        {
            Response.Write("Date slected form Event Handler " + e.SelectedDate.ToShortDateString() + "<br/>");
        }

        private void PopulateContinentsDropDownList()
        {
            ddlContinents.DataSource = GetData("spGetContinents", null);
            ddlContinents.DataTextField = "ContinentName";
            ddlContinents.DataValueField = "ContinentId";
            ddlContinents.DataBind();
            ListItem liContinent = new ListItem("Select Continent", "-1");
            ddlContinents.Items.Insert(0, liContinent);
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            Response.Write("Button Clicked" + "<br/>");
        }


        public void LoadCityDropDownList()
        {
            ListItem li1 = new ListItem("London");
            ddlCity.Items.Add(li1);

            ListItem li2 = new ListItem("Sydney");
            ddlCity.Items.Add(li2);

            ListItem li3 = new ListItem("Mumbai");
            ddlCity.Items.Add(li3);
        }



        private DataSet GetData(string SPName, SqlParameter SPParameter)
        {
            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            SqlConnection con = new SqlConnection(CS);
            SqlDataAdapter da = new SqlDataAdapter(SPName, con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            if (SPParameter != null)
            {
                da.SelectCommand.Parameters.Add(SPParameter);
            }
            DataSet DS = new DataSet();
            da.Fill(DS);
            return DS;
        }




        protected void Page_PreInit(object sender, EventArgs e)
        {
            Response.Write("Page_PreInit" + "<br/>");
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            Response.Write("Page_Init" + "<br/>");
        }
        protected void Page_InitComplete(object sender, EventArgs e)
        {
            Response.Write("Page_InitComplete" + "<br/>");
        }
        protected void Page_PreLoad(object sender, EventArgs e)
        {
            Response.Write("Page_PreLoad" + "<br/>");
        }
        protected void Page_LoadComplete(object sender, EventArgs e)
        {
            Response.Write("Page_LoadComplete" + "<br/>");
        }
        protected void Page_PreRender(object sender, EventArgs e)
        {
            Response.Write("Page_PreRender" + "<br/>");
        }
        protected void Page_PreRenderComplete(object sender, EventArgs e)
        {
            Response.Write("Page_PreRenderComplete" + "<br/>");
        }
        protected void TextBox1_TextChanged(object sender, EventArgs e)
        {
            Response.Write("Text Changed Event" + "<br/>");
        }

        protected void ddlCity_SelectedIndexChanged(object sender, EventArgs e)
        {
            Response.Write("index changed" + ddlCity.Text + "<br/>");
        }

        protected void TextBox2_TextChanged(object sender, EventArgs e)
        {
            Response.Write("First name Changed Event " + TextBox2.Text + "<br/>");
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
            if (MaleRadioButton.Checked == true)
            {
                Response.Write("Male radio button checked " + MaleRadioButton.Checked + MaleRadioButton.Text + " " + "<br/>");
            }
            else if (FemaleRadioButton.Checked == true)
            {
                Response.Write("Female radio button checked " + FemaleRadioButton.Checked + FemaleRadioButton.Text + " " + "<br/>");
            }
            else if (UnknownRadioButton.Checked)
            {
                Response.Write("Unknown radio button checked " + UnknownRadioButton.Checked + UnknownRadioButton.Text + " " + "<br/>");
            }


        }

        protected void FemaleRadioButton_CheckedChanged(object sender, EventArgs e)
        {
            Response.Write("Female radio button Changed " + FemaleRadioButton.Checked +
                FemaleRadioButton.Text + " " + "<br/>");
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            StringBuilder sbUserChoises = new StringBuilder();
            if (GraduateCheckBox.Checked)
            {
                sbUserChoises.Append(" , " + GraduateCheckBox.Text);
            }
            if (PostGraduateCheckBox.Checked)
            {
                sbUserChoises.Append(" , " + PostGraduateCheckBox.Text);
            }
            if (DoctrateCheckBox.Checked)
            {
                sbUserChoises.Append(" , " + DoctrateCheckBox.Text);
            }
            Response.Write(sbUserChoises.ToString() + "<br/>");

        }

        protected void GraduateCheckBox_CheckedChanged(object sender, EventArgs e)
        {
            Response.Write("Gadualte Check Box Changed " + GraduateCheckBox.Checked +
    GraduateCheckBox.Text + " " + "<br/>");
        }

        protected void Button4_Click(object sender, EventArgs e)
        {
            Response.Write("Submit button Clicked" + "<br/>");
        }

        protected void LinkButton1_Click(object sender, EventArgs e)
        {

            Response.Write("Submit Link button Clicked" + "<br/>");
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {

            Response.Write("Image Button Clicked" + "<br/>");

        }

        protected void Button5_Click(object sender, EventArgs e)
        {
            Response.Write("Button 5  Clicked" + "<br/>");
        }

        protected void Button5_Command(object sender, CommandEventArgs e)
        {
            Response.Write("Button 5  Command" + "<br/>");
        }

        protected void Button6_Click(object sender, EventArgs e)
        {
            Response.Write("Button 6  Clicked" + "<br/>");
        }
        protected void Button6_Command(object sender, CommandEventArgs e)
        {
            Response.Write("Button 6  Command" + "<br/>");
        }

        protected void CommandButton_Click(object sender, CommandEventArgs e)
        {
            switch (e.CommandName)
            {
                case "Print":
                    OutputLabel.Text = "You clicked Print Button";
                    break;
                case "Delete":
                    OutputLabel.Text = "You clicked Delete Button";
                    break;
                case "Show":
                    if (e.CommandArgument.ToString() == "Top10")
                    {
                        OutputLabel.Text = "You clicked Show Top 10 Employees Button";
                    }
                    else
                    {
                        OutputLabel.Text = "You clicked Show Bottom 10 Employees Button";
                    }
                    break;
                default:
                    OutputLabel.Text = "We don't know which button you clicked";
                    break;
            }
        }

        protected void ddlContinents_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlContinents.SelectedIndex == 0)
            {
                ddlCities.SelectedIndex = 0;
                ddlCountries.SelectedIndex = 0;
                ddlCities.Enabled = false;
                ddlCountries.Enabled = false;
            }
            else
            {
                ddlCountries.Enabled = true;
                if (ddlCities.Items.Count > 0)
                {
                    ddlCities.SelectedIndex = 0;
                }
                SqlParameter parameter = new SqlParameter("@ContinentId", ddlContinents.SelectedValue);

                ddlCountries.DataSource = GetData("spGetCountriesByContinentId", parameter);
                ddlCountries.DataTextField = "CountryName";
                ddlCountries.DataValueField = "CountryId";
                ddlCountries.DataBind();
                ListItem liCountries = new ListItem("Select Countries", "-1");
                ddlCountries.Items.Insert(0, liCountries);

                ddlCountries.SelectedIndex = 0;
            }
        }


        protected void ddlCountries_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCountries.SelectedValue == "-1")
            {
                ddlCities.SelectedIndex = 0;
                ddlCities.Enabled = false;
            }
            else
            {
                ddlCities.Enabled = true;

                SqlParameter parameter = new SqlParameter("@CountryId", ddlCountries.SelectedValue);

                ddlCities.DataSource = GetData("spGetCitiesByCountryId", parameter);
                ddlCities.DataTextField = "CityName";
                ddlCities.DataValueField = "CityId";
                ddlCities.DataBind();
                ListItem liCities = new ListItem("Select Cities", "-1");
                ddlCities.Items.Insert(0, liCities);

            }
        }

        protected void Button7_Click(object sender, EventArgs e)
        {
            foreach (ListItem item in checkboxListEducation.Items)
            {
                if (item.Selected)
                {
                    Response.Write(" Text = " + item.Text + ", " + "<br/>");
                    Response.Write(" Value = " + item.Value + ", " + "<br/>");
                    Response.Write(" Index = " + checkboxListEducation.Items.IndexOf(item) + ", " + "<br/>");
                }
            }
        }

        protected void Button8_Click(object sender, EventArgs e)
        {
            foreach (ListItem item in checkboxListEducation.Items)
            {
                item.Selected = true;
            }
        }

        protected void Button9_Click(object sender, EventArgs e)
        {
            if (ListBox1.SelectedIndex != -1)
            {
                Response.Write("Text = " + ListBox1.SelectedItem.Text + ", ");
                Response.Write("Value = " + ListBox1.SelectedItem.Value + ", ");
                Response.Write("Index = " + ListBox1.SelectedIndex.ToString());
                Response.Write("<br/>");

            }
            foreach (ListItem li in ListBox2.Items)
            {
                if (li.Selected)
                {
                    Response.Write("Text = " + li.Text + ", ");
                    Response.Write("Value = " + li.Value + ", ");
                    Response.Write("Index = " + ListBox2.Items.IndexOf(li).ToString());
                    Response.Write("<br/>");
                }
            }
        }



        protected void checkboxListEducation_SelectedIndexChanged(object sender, EventArgs e)
        {
            ListBox3.Items.Clear();
            foreach (ListItem item in checkboxListEducation.Items)
            {
                if (item.Selected)
                {
                    ListBox3.Items.Add(item.Text);
                }

            }
            Label1.Text = ListBox3.Items.Count.ToString() + "Items Selected";
            if (checkboxListEducation.SelectedIndex == -1)
            {
                Label1.ForeColor = System.Drawing.Color.Red;
            }

        }

        protected void Button10_Click(object sender, EventArgs e)
        {
            if (ColorRadioButtonList.SelectedIndex != -1)
            {
                Response.Write("Text = " + ColorRadioButtonList.SelectedItem.Text + "<br/>");
                Response.Write("Value = " + ColorRadioButtonList.SelectedItem.Value + "<br/>");
                Response.Write("Index = " + ColorRadioButtonList.SelectedIndex.ToString());
            }

        }

        protected void Button11_Click(object sender, EventArgs e)
        {
            ColorRadioButtonList.SelectedIndex = -1;
        }

        protected void BulletedList1_Click(object sender, BulletedListEventArgs e)
        {
            ListItem li = BulletedList1.Items[e.Index];
            Response.Write("bulleted list Text " + li.Text + ", <br/>");
            Response.Write("bulleted list Value " + li.Value + ", <br/>");
            Response.Write("bulleted list Index " + e.Index.ToString() + ", <br/>");
        }


        private void AddListItems(ListControl listControl)
        {
            ListItem li2 = new ListItem("Item2", "2");
            ListItem li3 = new ListItem("Item3", "3");

            listControl.Items.Add(li2);
            listControl.Items.Add(li3);

        }

        private void RetrieveMultipleSelections(ListControl listControl)
        {
            foreach (ListItem li in listControl.Items)
            {
                if (li.Selected)
                {
                    Response.Write("Text = " + li.Text + ", Value = " + li.Value +
                        ", Index = " + listControl.Items.IndexOf(li).ToString() + "<br/>");
                }
            }
        }
        private void RetrieveSelectedItemTextValueandIndex(ListControl listControl)
        {
            if (listControl.SelectedIndex != -1)
            {
                Response.Write("Text = " + listControl.SelectedItem.Text + "<br/>");
                Response.Write("Value = " + listControl.SelectedItem.Value + "<br/>");
                Response.Write("Index = " + listControl.SelectedIndex.ToString());
            }
        }


        protected void Button12_Click(object sender, EventArgs e)
        {
            RetrieveMultipleSelections(ListBox4);
            RetrieveSelectedItemTextValueandIndex(DropDownList5);
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                string fileExtension = System.IO.Path.GetExtension(FileUpload1.FileName);
                if (fileExtension.ToLower() != ".doc" && fileExtension.ToLower() != ".docx")
                {
                    lblMessage.Text = "File should only be a word document";
                    lblMessage.ForeColor = System.Drawing.Color.Red;
                }
                else
                {
                    int intsize = FileUpload1.PostedFile.ContentLength;
                    if (intsize < 2097152)
                    {
                        FileUpload1.SaveAs(Server.MapPath("~/Uploads/" + FileUpload1.FileName));
                        lblMessage.Text = "File Uploaded";
                        lblMessage.ForeColor = System.Drawing.Color.Green;
                    }
                    else
                    {
                        lblMessage.Text = "File should only be less than 2MB";
                        lblMessage.ForeColor = System.Drawing.Color.Red;
                    }

                }
            }
            else
            {
                lblMessage.Text = "Please select a file to Upload";
                lblMessage.ForeColor = System.Drawing.Color.Red;

            }
        }

        protected void ImageButton2_Click(object sender, ImageClickEventArgs e)
        {
            if (Calendar1.Visible)
                Calendar1.Visible = false;
            else
                Calendar1.Visible = true;
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {

            foreach (DateTime selectedDate in Calendar1.SelectedDates)
            {
                Response.Write(selectedDate.ToShortDateString() + "<br/>");
            }

            TextBox4.Text = Calendar1.SelectedDate.ToShortDateString();
            Calendar1.Visible = false;


        }
        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            if (e.Day.IsWeekend || e.Day.IsOtherMonth)
            {
                e.Day.IsSelectable = false;
                e.Cell.BackColor = System.Drawing.Color.LightGray;
            }
        }
        protected void Calendar2_DayRender(object sender, DayRenderEventArgs e)
        {
            if (!e.Day.IsOtherMonth && e.Day.Date.Day % 2 == 0)
            {
                e.Cell.Text = "x";
                e.Cell.Font.Bold = true;
                e.Cell.ForeColor = System.Drawing.Color.White;
                e.Cell.BackColor = System.Drawing.Color.Red;
                e.Cell.ToolTip = "Booked";
            }
            else
            {
                e.Cell.ToolTip = "Available";
            }
        }

        protected void Calendar2_SelectionChanged(object sender, EventArgs e)
        {
            foreach (DateTime selectedDate in Calendar2.SelectedDates)
            {
                Response.Write(selectedDate.ToShortDateString() + "<br/>");
            }
        }

        protected void Calendar2_VisibleMonthChanged(object sender, MonthChangedEventArgs e)
        {
            Response.Write("Month Changed from " + e.PreviousDate + " to " + e.NewDate + "<br/>");
            Response.Write("Month is " + e.NewDate.Month + "<br/>");

        }

        protected void Button13_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                Label2.ForeColor = System.Drawing.Color.Green;

                Label2.Text = "page is valid";
            }
            else
            {
                Label2.ForeColor = System.Drawing.Color.Red;
                Label2.Text = "page is in valid";

            }
        }

        protected void CustomValidatorEvenNumber_ServerValidate(object source, ServerValidateEventArgs args)
        {
            if (args.Value == "")
            {
                args.IsValid = false;
            }
            else
            {
                int Number;
                bool isNumber = int.TryParse(args.Value, out Number);
                if (isNumber && Number >= 0 && (Number % 2) == 0)
                {
                    args.IsValid = true;
                }
                else
                {
                    args.IsValid = false;
                }
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtEmail.Text = "";
            TextBox1.Text = "";
            txtPassword.Text = "";
            txtRetypePassword.Text = "";
        }

        protected void Button14_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Webform2.aspx?Name=" + Server.UrlEncode(TextBoxName.Text) + "&Place=" +
               Server.UrlEncode(TextBoxPlace.Text));

            //Response.Redirect("WebForm2.aspx?Name=" + TextBoxName.Text.Replace("&", "%26") +     "&Place=" + TextBoxPlace.Text.Replace("&", "%26"));
        }

        protected void Button15_Click(object sender, EventArgs e)
        {
            Server.Transfer("~/Webform2.aspx");
        }

        protected void Button16_Click(object sender, EventArgs e)
        {
            Server.Execute("~/Webform2.aspx");
            Label3.Text = "Server Execute Finished";
        }

        protected void Button18_Click(object sender, EventArgs e)
        {
            Button18.Attributes.Add("onclick", "OpenNewWindow()");
        }

        protected void Button19_Click(object sender, EventArgs e)
        {
            string strJavascript = "<script type='text/javascript'>window.open('WebForm2.aspx?Name=";
            strJavascript += TextBoxName.Text + "&Place=" + TextBoxPlace.Text + "','_blank');</script>";
            Response.Write(strJavascript);
        }

        protected void Button20_Click(object sender, EventArgs e)
        {
            Server.Transfer("~/WebForm2.aspx");
        }

        protected void Button21_Click(object sender, EventArgs e)
        {
            HttpCookie cookie = new HttpCookie("UserInfo");
            cookie["Name"] = TextBoxName.Text;
            cookie["Place"] = TextBoxPlace.Text;
            cookie.Expires = DateTime.Now.AddDays(3);
            Response.Cookies.Add(cookie);


            Session["Name"] = TextBoxName.Text;
            Session["Place"] = TextBoxPlace.Text;
            //    Response.Write("Browser Supports cookies : " + Request.Browser.Cookies);
            Response.Redirect("WebForm2.aspx");
        }

        protected void Button22_Click(object sender, EventArgs e)
        {
            try
            {
                throw new HttpException(500, "Internal Server Error.");

            }
            catch (Exception ex)
            {

                Logger.Log(ex);
                Response.Redirect("Error.aspx");
            }

        }
        protected void Page_Error(object sender, EventArgs e)
        {
            // Get the exception details and log it in the database or event viewer
            //Exception ex = Server.GetLastError();

            //Server.ClearError();

            //Response.Redirect("Error.aspx");
        }

        protected void Button23_Click(object sender, EventArgs e)
        {
            if (Trace.IsEnabled)
            {
                Trace.Warn("Writing Trace warning Message");
            }
        }
        protected void ButtonDUserControl_Click(object sender, EventArgs e)
        {
            if (DropDownList7.SelectedValue == "DDL")
            {
                 Response.Write(  ((DropDownList)PlaceHolder2.FindControl("DDL1")).SelectedItem + "<br/>");
            }
            else if (DropDownList7.SelectedValue == "TB") 
            { 
                 Response.Write(((TextBox)PlaceHolder2.FindControl("TB1")).Text + "<br/>");

            }
        }

        protected void DropDownList7_SelectedIndexChanged(object sender, EventArgs e)
        {


        }



        protected void ButtonUserControl_Click(object sender, EventArgs e)
        {
            Response.Write(" the selected date webform1 " + ((CalendarUserControl)PlaceHolder1.FindControl("CU1")).SelectedDate + "<br/>");
        }

       
    }
}