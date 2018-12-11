using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;

namespace Webforms
{
    /// <summary>
    /// Summary description for studentservice
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class studentservice : System.Web.Services.WebService
    {

        [WebMethod]
        public List<string> GetStudentNames(string searchItem)
        {

            List<string> studentNames = new List<string>();
            string cs = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("select Name from [dbo].[tblStudents] where Name  like  @Name  ; "   , con);
                cmd.Parameters.AddWithValue("@Name", "%" + searchItem + "%" );
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    studentNames.Add(rdr["Name"].ToString());
                }
            }
            return studentNames;
        }
    }
}
