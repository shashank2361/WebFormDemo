using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Webforms
{
    public partial class WebForm8 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGridViewData();
                BindGridView4Data();
            }

        }
        private void BindGridViewData()
        {
            GridView3.DataSource = EmployeeDataAccessLayer.GetAllEmployees();
            GridView3.DataBind();
        }

        private void BindGridView4Data()
        {
            GridView4.DataSource = EmployeeDataAccessLayer.GetAllEmployees();
            GridView4.DataBind();
        }




        protected void lbInsert_Click(object sender, EventArgs e)
        {
            SqlDataSource1.InsertParameters["Name"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("txtName")).Text;
            SqlDataSource1.InsertParameters["Gender"].DefaultValue =
                ((DropDownList)GridView1.FooterRow.FindControl("ddlInsertGender")).SelectedValue;
            SqlDataSource1.InsertParameters["City"].DefaultValue =
                ((TextBox)GridView1.FooterRow.FindControl("txtCity")).Text;
            SqlDataSource1.Insert();
        }

        int totalUnitPrice = 0;
        int totalQuanitySold = 0;

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                totalUnitPrice += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "UnitPrice"));
                totalQuanitySold += Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "QuantitySold"));
            }
            // Display totals in the gridview footer
            else if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.Cells[1].Text = "Grand Total";
                e.Row.Cells[1].Font.Bold = true;

                e.Row.Cells[2].Text = totalUnitPrice.ToString();
                e.Row.Cells[2].Font.Bold = true;

                e.Row.Cells[3].Text = totalQuanitySold.ToString();
                e.Row.Cells[3].Font.Bold = true;
            }
        }

        protected void cbDeleteHeader_CheckedChanged(object sender, EventArgs e)
        {
            var checkboxvalue = ((CheckBox)GridView3.HeaderRow.FindControl("cbDeleteHeader")).Checked;

            foreach (GridViewRow gridViewRow in GridView3.Rows)
            {
                ((CheckBox)(gridViewRow.FindControl("cbDelete"))).Checked = ((CheckBox)sender).Checked;

            }

        }

        protected void cbDelete_CheckedChanged(object sender, EventArgs e)
        {

            CheckBox headerCheckBox =
                (CheckBox)GridView3.HeaderRow.FindControl("cbDeleteHeader");
            if (headerCheckBox.Checked)
            {
                headerCheckBox.Checked = ((CheckBox)sender).Checked;
            }
            else
            {
                bool allCheckBoxesChecked = true;
                foreach (GridViewRow gridViewRow in GridView3.Rows)
                {
                    if (!((CheckBox)gridViewRow.FindControl("cbDelete")).Checked)
                    {
                        allCheckBoxesChecked = false;
                        break;
                    }
                }
                headerCheckBox.Checked = allCheckBoxesChecked;
            }

        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            List<string> lstEmployeeIdsToDelete = new List<string>();
            foreach (GridViewRow gridViewRow in GridView3.Rows)
            {
                if (((CheckBox)gridViewRow.FindControl("cbDelete")).Checked)
                {
                    string employeeId =
                        ((Label)gridViewRow.FindControl("lblEmployeeId")).Text;
                    lstEmployeeIdsToDelete.Add(employeeId);
                }
            }
            if (lstEmployeeIdsToDelete.Count > 0)
            {
                EmployeeDataAccessLayer.DeleteEmployees(lstEmployeeIdsToDelete);
                BindGridViewData();
                lblMessage.ForeColor = System.Drawing.Color.Navy;
                lblMessage.Text = lstEmployeeIdsToDelete.Count.ToString() +
                    " row(s) deleted";
            }
            else
            {
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "No rows selected to delete";
            }
        }

        protected void btnDelete1_Click(object sender, EventArgs e)
        {

        }
    }

}