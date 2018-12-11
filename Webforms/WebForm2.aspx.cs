using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Webforms
{
    public partial class WebForm2 : System.Web.UI.Page
    {
        private bool IsPageRefresh = false;

        public string CS { get; set; } =

                ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
             

        protected void Page_Load(object sender, EventArgs e)
        {

            // Get variables for previous form Using Page , Context handler
            // Cookies Sessions
            System.Collections.Specialized.NameValueCollection previousFormcollection = Request.Form;

            Label9.Text = previousFormcollection["TextBoxName"];
            Label10.Text = previousFormcollection["TextBoxPlace"];

            Page previousPage = this.PreviousPage;
            if (previousPage != null && previousPage.IsCrossPagePostBack)
            {
                Label11.Text = ((TextBox)previousPage.FindControl("TextBoxName")).Text;
                Label12.Text = ((TextBox)previousPage.FindControl("TextBoxPlace")).Text;
            }
            else
            {
                lblStatus.Text =  "Landed on this page using a technique other than cross page post back";
            }


            // this is ti stop post back after refresh
            if (Page.IsPostBack)
            {
                if (Session["postid"] is null)
                {
                    Session["postid"] = System.Guid.NewGuid().ToString();
                    ViewState["postid"] = Session["postid"];
                }

                if (ViewState["postid"].ToString() != Session["postid"].ToString())
                    IsPageRefresh = true;
            }
            Session["postid"] = System.Guid.NewGuid().ToString();
            ViewState["postid"] = Session["postid"];


            if (!IsPostBack)
            {
                refreshdata();
                Literal1.Text = "<b><font color='Red'>Literal Control Text</font></b>";
                multiViewEmployee.ActiveViewIndex = 0;
                using (SqlConnection con = new SqlConnection(CS))
                {
                    SqlCommand cmd = new SqlCommand("select * from [dbo].[Employees] where Id = 4", con);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        txtFirstName.Text = rdr["FirstName"].ToString();
                        txtLastName.Text = rdr["LastName"].ToString();
                        txtGender.Text = rdr["Gender"].ToString();
                        txtSalary.Text = rdr["Salary"].ToString();
                        HiddenField1.Value = rdr["ID"].ToString();
                    }
                }

                using (SqlConnection con = new SqlConnection(CS))
                {
                    SqlCommand cmd = new SqlCommand("select * from [dbo].[Employees] where Id = 5", con);
                    con.Open();
                    SqlDataReader rdr = cmd.ExecuteReader();
                    while (rdr.Read())
                    {
                        TextBox1.Text = rdr["FirstName"].ToString();
                        TextBox2.Text = rdr["LastName"].ToString();
                        ddlGender.SelectedValue = rdr["Gender"].ToString();
                        HiddenField2.Value = rdr["ID"].ToString();
                    }
                }


                
                Button btnNext = (Button)Wizard1.FindControl("StepNavigationTemplateContainerID").FindControl("StepNextButton");
                btnNext.Attributes.Add("onclick", "return confirm('Are you sure you want to move to the next step');");


                AdminPanel.Visible = false;
                NonAdminPanel.Visible = false;


                Page lastpage = (Page)Context.Handler;
                if (lastpage is WebForm1)
                {
                    //Use FindControl() if public properties does not exist on the 
                    //previous page(WebForm1). FindControl() may cause 
                    //NullRefernceExceptions due to mis-spelled conrol Id's

                    //Label15.Text = ((TextBox)lastpage.FindControl("TextBoxName")).Text;
                    //Label16.Text = ((TextBox)lastpage.FindControl("TextBoxPlace")).Text;

                    //Using public properties can eliminate NullRefernceExceptions 
                    Label15.Text = ((WebForm1)lastpage).Name;
                    Label16.Text = ((WebForm1)lastpage).Place;
                }


                Label13.Text = Request.QueryString["Name"];
                Label14.Text = Request.QueryString["Place"];
                // Label13.Text = Request.QueryString[0];
                // Label14.Text = Request.QueryString[1];

                var cookie = Request.Cookies["UserInfo"];
                if (cookie != null)
                {
                    Label17.Text = cookie["Name"];
                    Label18.Text = cookie["Place"];
                }
                if ( Session["Name"] != null && Session["Place"] != null)
                {
                    Label19.Text = Session["Name"].ToString();
                    Label20.Text = Session["Place"].ToString();
                }


            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (!IsPageRefresh)
                {
                    //string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;

                    using (SqlConnection con = new SqlConnection(CS))
                    {
                        string sqlQuery = "Update [Employees] set FirstName=@FirstName, LastName =@LastName , Gender=@Gender, Salary=@Salary where Id=@Id";
                        SqlCommand cmd = new SqlCommand(sqlQuery, con);

                        cmd.Parameters.AddWithValue("@FirstName", txtFirstName.Text);
                        cmd.Parameters.AddWithValue("@LastName", txtLastName.Text);
                        cmd.Parameters.AddWithValue("@Gender", txtGender.Text);
                        cmd.Parameters.AddWithValue("@Salary", Convert.ToInt32(txtSalary.Text));
                        cmd.Parameters.AddWithValue("@Id", HiddenField1.Value);
                        con.Open();
                        cmd.ExecuteNonQuery();
                        con.Close();

                        txtFirstName.Text = "";
                        txtLastName.Text = "";
                        txtGender.Text = "";
                        txtSalary.Text = "";

                        Response.Write("<script>alert('Data inserted successfully')</script>");
                    }
                }
            }
            catch (Exception ex)
            {
                //ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "alertMessage", "alert('Error Record Not Updated')" + ex.Message, true);

                Response.Write("<script>alert('Inserted Failed!')</script>"); //works great


            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

        }

        protected void btnGoToStep2_Click(object sender, EventArgs e)
        {
            multiViewEmployee.ActiveViewIndex = 1;


            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("select * from [dbo].[Employees] where Id = 5", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    txtSal.Text = rdr["Salary"].ToString();
                   
                }
            }
        }


        protected void btnBackToStep1_Click(object sender, EventArgs e)
        {
            multiViewEmployee.ActiveViewIndex = 0;
        }

        protected void btnGoToStep3_Click(object sender, EventArgs e)
        {
            multiViewEmployee.ActiveViewIndex = 2;
            lblFirstName.Text = txtFirstName.Text;
            lblLastName.Text = txtLastName.Text;
            lblGender.Text = ddlGender.SelectedValue;
            lblSal.Text = txtSal.Text;
        }

        protected void Button3_Click(object sender, EventArgs e)
        {
            multiViewEmployee.ActiveViewIndex = 1;
        }
        protected void Button4_Click(object sender, EventArgs e)
        {
            Response.Write("Data saved");
            multiViewEmployee.ActiveViewIndex = 0;
        }
        protected void Wizard2_NextButtonClick(object sender, WizardNavigationEventArgs e)
        {
            if (e.NextStepIndex == 3)
            {
                refreshdata();
            }

        }
        private void refreshdata()
        {
            Label1.Text = TextBox1.Text;
            Label2.Text = TextBox2.Text;
            Label3.Text = TextBox3.Text;
            Label4.Text = TextBox4.Text;
            Label5.Text = TextBox5.Text;
            Label6.Text = TextBox6.Text;
            Label7.Text = TextBox7.Text;


        }

        protected void Wizard1_ActiveStepChanged(object sender, EventArgs e)
        {
            Response.Write("Active Step Changed to " + Wizard1.ActiveStepIndex.ToString() + "<br/>");
        }
        // CancelButtonClick - Fires when the cancel button of the wizard control is clicked. 
        // To display the cancel button, set DisplayCancelButton=True.

        protected void Wizard1_CancelButtonClick(object sender, EventArgs e)
        {
            Response.Write("Cancel Button Clicked");
        }
        


        // NextButtonClick - Fires when the next button of the wizard control is clicked. 
        protected void Wizard1_NextButtonClick(object sender, WizardNavigationEventArgs e)
        {
            Response.Write("Current Step Index = " + e.CurrentStepIndex.ToString() + "<br/>");
            Response.Write("Next Step Index = " + e.NextStepIndex.ToString() + "<br/>");
            if (chkBoxCancel.Checked)
            {
                Response.Write("Navigation to next step will be cancelled");
                e.Cancel = true;
            }
        }
        // FinishButtonClick - Fires when the finish button is clicked
        protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
        {
            Response.Write("Finish button clicked <br/>");
            Response.Write("Current Step Index = " + e.CurrentStepIndex.ToString() + "<br/>");
            Response.Write("Next Step Index = " + e.NextStepIndex.ToString());
        }
        // PreviousButtonClick - Fires when the previous button is clicked
        protected void Wizard1_PreviousButtonClick(object sender, WizardNavigationEventArgs e)
        {
            Response.Write("Previous button clicked<br/>");
        }
        // SideBarButtonClick - Fires when the sidebar button is clicked
        protected void Wizard1_SideBarButtonClick(object sender, WizardNavigationEventArgs e)
        {
            Response.Write("Sidebar button clicked<br/>");
        }

        protected void Wizard1_PreRender(object sender, EventArgs e)
        {
           
        }

        protected void Page_PreRender(object sender, EventArgs e)
        {
            if (Wizard1.ActiveStepIndex == 0)
            {
                Step1TextBox.Focus();
            }
            else if (Wizard1.ActiveStepIndex == 1)
            {
                Step2TextBox.Focus();
            }
            else if (Wizard1.ActiveStepIndex == 2)
            {
                Step3TextBox.Focus();
            }
        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (DropDownList1.SelectedValue == "Admin")
            {
                AdminPanel.Visible = true;
                NonAdminPanel.Visible = false;
            }
            else if (DropDownList1.SelectedValue == "Non-Admin")
            {
                AdminPanel.Visible = false;
                NonAdminPanel.Visible = true;
            }
            else
            {
                AdminPanel.Visible = false;
                NonAdminPanel.Visible = false;
            }
        }

        protected void btnGenerateControl_Click(object sender, EventArgs e)
        {
            int Count = Convert.ToInt16(txtControlsCount.Text);
            foreach (ListItem li in chkBoxListControlType.Items)
            {
                if (li.Selected)
                {
                    if (li.Value == "Label")
                    {
                        for (int i = 0; i < Count; i++)
                        {
                            Label lbl = new Label();
                            lbl.Text = "Label - " + i.ToString();
                            //   tdLabels.Controls.Add(lbl);
                            //   pnlLabels.Controls.Add(lbl);
                            //   this.form1.Controls.Add(lbl);
                            phLabels.Controls.Add(lbl);
                        }
                    }
                    else if (li.Value == "TextBox")
                    {
                        for (int i = 0; i < Count; i++)
                        {
                            TextBox textbox = new TextBox();
                            textbox.Text = "Textbox - " + i.ToString();
                            // pnlTextBoxes.Controls.Add(textbox);
                            //tdTextBoxes.Controls.Add(textbox);
                            phTextBoxes.Controls.Add(textbox);
                            //this.form1.Controls.Add(pnlTextBoxes);
                        }
                    }
                    else 
                    {
                        for (int i = 0; i < Count; i++)
                        {
                            Button btn = new Button();
                            btn.Text = "Button - " + i.ToString();
                            //   pnlButtons.Controls.Add(btn);
                            //   tdButtons.Controls.Add(btn);
                            phButtons.Controls.Add(btn);
                            //   this.form1.Controls.Add(pnlButtons);
                        }
                    }
                }
            }
        }
    }
}