﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Webforms.UserControls
{
    //[PartialCaching(60, VaryByParams = "ProductName")]
    public partial class UCProductsControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            GetProductByName(Request.QueryString["ProductName"]);
            Label1.Text = DateTime.Now.ToString();
        }


        private void GetProductByName(string ProductName)
        {
            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            SqlConnection con = new SqlConnection(CS);
            SqlDataAdapter da = new SqlDataAdapter("spGetProductByName", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            SqlParameter paramProductName = new SqlParameter();
            paramProductName.ParameterName = "@ProductName";
            paramProductName.Value = ProductName;
            da.SelectCommand.Parameters.Add(paramProductName);

            DataSet DS = new DataSet();
            da.Fill(DS);
            GridView1.DataSource = DS;
            GridView1.DataBind();
        }

    }
}