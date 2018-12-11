using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Webforms
{
    public class EmployeeDataAccessLayer
    {
        public class Employee
        {
            public int EmployeeId { get; set; }
            public string Name { get; set; }
            public string Gender { get; set; }
            public string City { get; set; }
        }

        public static List<Employee> GetAllEmployees()
        {
            List<Employee> listEmployees = new List<Employee>();

            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("Select * from tblEmployee", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    Employee employee = new Employee();
                    employee.EmployeeId = Convert.ToInt32(rdr["EmployeeId"]);
                    employee.Name = rdr["Name"].ToString();
                    employee.Gender = rdr["Gender"].ToString();
                    employee.City = rdr["City"].ToString();

                    listEmployees.Add(employee);
                }
            }

            return listEmployees;
        }

        public static void DeleteEmployee(int EmployeeId)
        {
            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("Delete from tblEmployee where EmployeeId = @EmployeeId", con);
                SqlParameter param = new SqlParameter("@EmployeeId", EmployeeId);
                cmd.Parameters.Add(param);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public static void DeleteEmployee(int original_EmployeeId, string original_Name,
        string original_Gender, string original_City)
        {
            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                string deleteQuery = "DELETE FROM tblEmployee WHERE EmployeeId = @original_EmployeeId " + "AND Name = @original_Name AND Gender = @original_Gender AND City = @original_City";
                SqlCommand cmd = new SqlCommand(deleteQuery, con);
                SqlParameter paramEmployeeId = new SqlParameter("@original_EmployeeId", original_EmployeeId);
                cmd.Parameters.Add(paramEmployeeId);
                SqlParameter paramName = new SqlParameter("@original_Name", original_Name);
                cmd.Parameters.Add(paramName);
                SqlParameter paramGender = new SqlParameter("@original_Gender", original_Gender);
                cmd.Parameters.Add(paramGender);
                SqlParameter paramCity = new SqlParameter("@original_City", original_City);
                cmd.Parameters.Add(paramCity);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public static void UpdateEmployee(int EmployeeId, string Name,
                                    string Gender, string City)
        {
            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                string updateQuery = "Update tblEmployee SET Name = @Name,  " +
                    "Gender = @Gender, City = @City WHERE EmployeeId = @EmployeeId ";
                SqlCommand cmd = new SqlCommand(updateQuery, con);
                SqlParameter paramEmployeeId = new SqlParameter("@EmployeeId", EmployeeId);
                cmd.Parameters.Add(paramEmployeeId);
                SqlParameter paramName = new SqlParameter("@Name", Name);
                cmd.Parameters.Add(paramName);
                SqlParameter paramGender = new SqlParameter("@Gender", Gender);
                cmd.Parameters.Add(paramGender);
                SqlParameter paramCity = new SqlParameter("@City", City);
                cmd.Parameters.Add(paramCity);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }


        public static void DeleteEmployees(List<string> EmployeeIds)
        {
            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                List<string> parameters = EmployeeIds.Select((s, i) => "@Parameter" + i.ToString()).ToList();
                string inClause = string.Join(",", parameters);
                string deleteCommandText = "Delete from tblEmployee where EmployeeId IN (" + inClause + ")";
                SqlCommand cmd = new SqlCommand(deleteCommandText, con);

                for (int i = 0; i < parameters.Count; i++)
                {
                    cmd.Parameters.AddWithValue(parameters[i], EmployeeIds[i]);
                }

                con.Open();
                cmd.ExecuteNonQuery();
            }
        }


        public static void UpdateEmployee(int original_EmployeeId, string original_Name, string original_Gender, string original_City, string Name, string Gender, string City)
        {
            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                string updateQuery = "Update tblEmployee SET Name = @Name,  " +
                    "Gender = @Gender, City = @City WHERE EmployeeId = @original_EmployeeId " +
                    "AND Name = @original_Name AND Gender = @original_Gender AND City = @original_City";
                SqlCommand cmd = new SqlCommand(updateQuery, con);
                SqlParameter paramOriginalEmployeeId = new SqlParameter("@original_EmployeeId", original_EmployeeId);
                cmd.Parameters.Add(paramOriginalEmployeeId);
                SqlParameter paramOriginalName = new SqlParameter("@original_Name", original_Name);
                cmd.Parameters.Add(paramOriginalName);
                SqlParameter paramOriginalGender = new SqlParameter("@original_Gender", original_Gender);
                cmd.Parameters.Add(paramOriginalGender);
                SqlParameter paramOriginalCity = new SqlParameter("@original_City", original_City);
                cmd.Parameters.Add(paramOriginalCity);
                SqlParameter paramName = new SqlParameter("@Name", Name);
                cmd.Parameters.Add(paramName);
                SqlParameter paramGender = new SqlParameter("@Gender", Gender);
                cmd.Parameters.Add(paramGender);
                SqlParameter paramCity = new SqlParameter("@City", City);
                cmd.Parameters.Add(paramCity);
                con.Open();
                cmd.ExecuteNonQuery();
            }
        }

        public static int InsertEmployee(string Name, string Gender, string City)
        {
            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                string updateQuery = "Insert into tblEmployee (Name, Gender, City)" +
                    " values (@Name, @Gender, @City)";
                SqlCommand cmd = new SqlCommand(updateQuery, con);
                SqlParameter paramName = new SqlParameter("@Name", Name);
                cmd.Parameters.Add(paramName);
                SqlParameter paramGender = new SqlParameter("@Gender", Gender);
                cmd.Parameters.Add(paramGender);
                SqlParameter paramCity = new SqlParameter("@City", City);
                cmd.Parameters.Add(paramCity);
                con.Open();
                return cmd.ExecuteNonQuery();
            }
        }


    }
}