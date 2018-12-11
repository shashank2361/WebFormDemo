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
    public partial class WebForm6 : BasePage
    {
        protected void Page_Init (object sender, EventArgs e)
        {
            Master.SearchButton.Click += new EventHandler(SearchButton_Click);
        }

        private void SearchButton_Click(object sender, EventArgs e)
        {
            GetData(Master.SearchTerm);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetData(null);
            }
        }

        private void GetData(string searchTerm)
        {
            string cs = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("select * from [dbo].[tblStudents] where Name  like  @Name  ; ", con);

                cmd.Parameters.AddWithValue("@Name", "%" + searchTerm + "%");
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                GridView1.DataSource = rdr;
                GridView1.DataBind();
            }
        }

    }
}