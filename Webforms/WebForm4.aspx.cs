using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Caching;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Webforms
{
    public partial class WebForm4 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // datakey name for gridview Objectdata source
            GridView7.DataKeyNames = new string[1] { "EmployeeID" };

            if (Request.QueryString["ProductName"] == null)
            {
                Response.Redirect("WebForm4?ProductName=All");
            }

            if (!IsPostBack)
            {
                GetStudents(null);
                LoadGridview1();
            }
            // Hidden the panel controls here
            ((SiteMaster)Master).SearchPanel.Visible = false;
        }

        private void LoadGridview1()
        {

            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(CS))
            {
                SqlDataAdapter da = new SqlDataAdapter("spGetEmployess", con);
                da.SelectCommand.CommandType = CommandType.StoredProcedure;
                DataSet DS = new DataSet();
                da.Fill(DS);
                GridView1.DataSource = DS;
                GridView1.DataBind();
            }

        }

        
            private void GetStudents(string studentName)
        {
            string cs = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("select Name from [dbo].[tblStudents] where Name  like  @Name  ; ", con);
                cmd.Parameters.AddWithValue("@Name", studentName + "%");
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
        
                gvStudents.DataSource = rdr;
                gvStudents.DataBind();
            }
         }


        private DataSet GetProductsData()
        {
            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            SqlConnection con = new SqlConnection(CS);
            SqlDataAdapter da = new SqlDataAdapter("spGetProducts", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;

            DataSet dsProducts = new DataSet();
            da.Fill(dsProducts);

            return dsProducts;
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

        protected void btnGetProducts_Click(object sender, EventArgs e)
        {
            DateTime dtStartDateTime = DateTime.Now;
            System.Text.StringBuilder sbMessage = new System.Text.StringBuilder();

            if (Cache["ProductsData"] != null)
            {

                DataSet ds = (DataSet)Cache["ProductsData"];
                gvProducts.DataSource = ds;
                gvProducts.DataBind();
                sbMessage.Append(ds.Tables[0].Rows.Count.ToString() + " rows retrieved from cache.");
            }
            else
            {
                DataSet ds = GetProductsData();
                Cache["ProductsData"] = ds;
                // Anything of it can be used
                //Cache.Insert("ProductsData", ds);
                // Cache.Add("ProductsData", ds, null, System.Web.Caching.Cache.NoAbsoluteExpiration, System.Web.Caching.Cache.NoSlidingExpiration, System.Web.Caching.CacheItemPriority.Default, null);

                gvProducts.DataSource = ds;
                gvProducts.DataBind();
                sbMessage.Append(ds.Tables[0].Rows.Count.ToString() + " rows retrieved from database.");
            }
            DateTime dtEndDateTime = DateTime.Now;

            sbMessage.Append((dtEndDateTime - dtStartDateTime).Seconds.ToString() + " Seconds Load Time");
            lblMessage.Text = sbMessage.ToString();

        }

        protected void btnGetCountries_Click(object sender, EventArgs e)
        {
            // Check if the data is already cached
            if (Cache["CountriesData"] != null)
            {
                // If data is cached, retrieve data from Cache
                DataSet ds = (DataSet)Cache["CountriesData"];
                // Set the dataset as the datasource
                gvCountries.DataSource = ds;
                gvCountries.DataBind();
                // Retrieve the total rows count
                msgLabel2.Text = ds.Tables[0].Rows.Count.ToString() + " rows retrieved from cache.";
            }
            // If the data is not cached
            else
            {
                // Get data from xml file
                DataSet ds = new DataSet();
                ds.ReadXml(Server.MapPath("~/Countries.xml"));

                CacheItemRemovedCallback onCacheItemRemoved =
   new CacheItemRemovedCallback(CacheItemRemovedCallbackMethod);

                //Cache Countries and set dependency on file
                //Cache.Insert("CountriesData", ds, null, DateTime.Now.AddSeconds(20), System.Web.Caching.Cache.NoSlidingExpiration);
                Cache.Insert("CountriesData", ds, new CacheDependency(Server.MapPath("~/Countries.xml")), DateTime.Now.AddSeconds(20), System.Web.Caching.Cache.NoSlidingExpiration, CacheItemPriority.Default,
                    onCacheItemRemoved);

                // Set the dataset as the datasource
                gvCountries.DataSource = ds;
                gvCountries.DataBind();
                msgLabel2.Text = ds.Tables[0].Rows.Count.ToString() + " rows retrieved from the file.";
            }
        }

        private void CacheItemRemovedCallbackMethod(string key, object value, CacheItemRemovedReason reason)
        {
            // Retrieve the key and reason for removal
            string dataToStore = "Cache item with key = \"" + key + "\" is no longer present. Reason = " + reason.ToString();
            // Cache the message
            Cache["CacheStatus"] = dataToStore;

            // ADO.NET code to store the message in database
            // string cs = ConfigurationManager.ConnectionStrings["EmployeesDB"].ConnectionString;
            // SqlConnection con = new SqlConnection(cs);
            // SqlCommand cmd = new SqlCommand("insert into tblAuditLog values('" + dataToStore + "')", con);
            // con.Open();
            // cmd.ExecuteNonQuery();
            // con.Close();

            // Reload data into cache
            // DataSet ds = new DataSet();
            // ds.ReadXml(Server.MapPath("~/Data/Countries.xml"));

            // CacheItemRemovedCallback onCacheItemRemoved = new CacheItemRemovedCallback(CacheItemRemovedCallbackMethod);
            // Cache.Insert("CountriesData", ds, new CacheDependency(Server.MapPath("~/Data/Countries.xml")), DateTime.Now.AddSeconds(60),
            //    System.Web.Caching.Cache.NoSlidingExpiration, CacheItemPriority.Default, onCacheItemRemoved);
        }

        protected void btnGetCacheStatus_Click(object sender, EventArgs e)
        {
            if (Cache["CountriesData"] != null)
            {
                msgCacheChanged.Text = "Cache item with key \"CountriesData\" is still present in cache";
            }
            else
            {
                if (Cache["CacheStatus"] != null)
                {
                    msgCacheChanged.Text = Cache["CacheStatus"].ToString();
                }
            }
        }

        protected void btnRemoveCachedItem_Click(object sender, EventArgs e)
        {
            // Remove cached item explicitly
            Cache.Remove("CountriesData");
        }

        protected void btnGetSQLData_Click(object sender, EventArgs e)
        {
            if (Cache["ProductsDataSQL"] != null)
            {
                // If data available in cache, retrieve and bind it to gridview control
                gvSQLProducts.DataSource = Cache["ProductsDataSQL"];
                gvSQLProducts.DataBind();

                lblSQLStatus.Text = "Data retrieved from cache @ " + DateTime.Now.ToString();
            }
            else
            {
                // Read connection string from web.config file
                string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;

                // Enable change notifications on the database, 
                // so that when the data changes the cached item will be removed
                System.Web.Caching.SqlCacheDependencyAdmin.EnableNotifications(CS);
                // Enable change notifications on the database table, 
                // so that when the data changes the cached item will be removed
                System.Web.Caching.SqlCacheDependencyAdmin.EnableTableForNotifications(CS, "tblProducts");

                SqlConnection con = new SqlConnection(CS);
                SqlDataAdapter da = new SqlDataAdapter("select * from tblProducts", con);
                DataSet ds = new DataSet();
                da.Fill(ds);

                CacheItemRemovedCallback oncacheItemRemovedSQL = new CacheItemRemovedCallback(CacheItemRemovedCallbackMethodSQL);
                // Build SqlCacheDependency object using the database and table names
                SqlCacheDependency sqlDependency = new SqlCacheDependency("EmployeeDB", "tblProducts");

                // Pass SqlCacheDependency object, when caching data
                Cache.Insert("ProductsDataSQL", ds, sqlDependency, DateTime.Now.AddHours(24), Cache.NoSlidingExpiration, CacheItemPriority.Default, oncacheItemRemovedSQL);

                gvSQLProducts.DataSource = ds;
                gvSQLProducts.DataBind();
                lblSQLStatus.Text = "Data retrieved from database @ " + DateTime.Now.ToString();
            }
        }


        public void CacheItemRemovedCallbackMethodSQL(string key, object value, CacheItemRemovedReason reason)
        {
            string CS = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            //System.Web.Caching.SqlCacheDependencyAdmin.EnableNotifications(CS);
            //System.Web.Caching.SqlCacheDependencyAdmin.EnableTableForNotifications(CS, "tblProducts");

            SqlConnection con = new SqlConnection(CS);
            SqlDataAdapter da = new SqlDataAdapter("select * from tblProducts", con);
            DataSet ds = new DataSet();
            da.Fill(ds);

            CacheItemRemovedCallback oncacheItemRemovedSQL = new CacheItemRemovedCallback(CacheItemRemovedCallbackMethodSQL);
            // Build SqlCacheDependency object using the database and table names
            SqlCacheDependency sqlDependency = new SqlCacheDependency("EmployeeDB", "tblProducts");

            // Pass SqlCacheDependency object, when caching data
            Cache.Insert("ProductsDataSQL", ds, sqlDependency, DateTime.Now.AddHours(24), Cache.NoSlidingExpiration, CacheItemPriority.Default, oncacheItemRemovedSQL);

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            GetStudents(txtStudentName.Text);
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }

        protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
        {

            if (e.Row.RowType == DataControlRowType.Header)
            {
                e.Row.Cells[6].Visible = false;
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                

                if (e.Row.Cells[6].Text.Trim() == "US")
                {
                    int salary = Convert.ToInt32(e.Row.Cells[4].Text);
                    string formattedString = string.Format(new System.Globalization.CultureInfo("en-US"), "{0:c}", salary);
                    e.Row.Cells[4].Text = formattedString;
                }
                else if (e.Row.Cells[6].Text.Trim() == "UK")
                {
                    int salary = Convert.ToInt32(e.Row.Cells[4].Text);
                    string formattedString = string.Format(new System.Globalization.CultureInfo("en-GB"), "{0:c}", salary);
                    e.Row.Cells[4].Text = formattedString;
                }
                else if (e.Row.Cells[6].Text.Trim() == "India")
                {
                    int salary = Convert.ToInt32(e.Row.Cells[4].Text);
                    string formattedString = string.Format(new System.Globalization.CultureInfo("en-IN"), "{0:c}", salary);
                    e.Row.Cells[4].Text = formattedString;
                }
                e.Row.Cells[6].Visible = false;

                int annsalary = Convert.ToInt32(DataBinder.Eval(e.Row.DataItem, "Salary"));
                if (annsalary > 70000)
                {
                    e.Row.BackColor = System.Drawing.Color.Red;
                }


            }
        }

        protected void GridView5_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                Control control = e.Row.Cells[0].Controls[0];
                if (control is LinkButton)
                {
                    ((LinkButton)control).OnClientClick = "return confirm('Are you sure you want to delete ?')";

                }
            }
        }

        protected void GridView5_RowDeleted(object sender, GridViewDeletedEventArgs e)
        {
            deletedlbl.Visible = true;
            // AffectedRows property will be zero, if no rows are deleted
            if (e.AffectedRows > 0)
            {
                deletedlbl.Text = "Employee row with EmployeeID = \""
                    + e.Keys[0].ToString() + "\" is successfully deleted";
                deletedlbl.ForeColor = System.Drawing.Color.Navy;
            }
            else
            {
                
                deletedlbl.Text = "Employee Row with EmployeeID = \""
                    + e.Keys[0].ToString() + "\" is not deleted due to data conflict";
                deletedlbl.ForeColor = System.Drawing.Color.Red;
            }
        }

        protected void GridView6_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
        //    if (e.AffectedRows < 1)
        //    {
        //        e.KeepInEditMode = true;
        //        lbleditStatus.Text = "Row with EmployeeId = " + e.Keys[0].ToString() +
        //            " is not update due to data conflict";
        //        lbleditStatus.ForeColor = System.Drawing.Color.Red;
        //    }
        //    else
        //    {
        //        lbleditStatus.Text = "Row with EmployeeId = " + e.Keys[0].ToString() +
        //            " is successfully updated";
        //        lbleditStatus.ForeColor = System.Drawing.Color.Navy;
        //    }
        }
    }
}