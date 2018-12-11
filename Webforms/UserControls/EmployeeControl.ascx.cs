using System;
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
    public partial class EmployeeControl : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Label1.Text = DateTime.Now.ToString();

            if (!IsPostBack)
            {
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
    }
}