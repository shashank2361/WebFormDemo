using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Webforms
{
    public class ProductDataAccessLayer
    {
        public static List<tblProduct> GetAllProducts()
        {
            List<tblProduct> listProducts = new List<tblProduct>();

            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlCommand cmd = new SqlCommand("select * from tblProducts", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    tblProduct product = new tblProduct();
                    product.Id = Convert.ToInt32(rdr["Id"]);
                    product.Name = rdr["Name"].ToString();
                    product.ProductDescription = rdr["ProductDescription"].ToString();

                    listProducts.Add(product);
                }
            }

            return listProducts;
        }
    }
}