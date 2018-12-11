using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Webforms
{
    public partial class WebForm7 : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            Response.Write("Content Page init event" + "<br/>");
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Write("Content Page Load event" + "<br/>");
            if (!IsPostBack)
            {
                GetTreeViewItems();
                lblMessage.Visible = false;
                hyperlink.Visible = false;
                //read Image
                BindDataSetData();
                BindDataReaderData();
                if (Request.QueryString["Id"] != null)
                {

               
                string cs = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("spGetImageById", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter paramId = new SqlParameter()
                    {
                        ParameterName = "@Id",
                        Value = Request.QueryString["Id"]
                    };
                    cmd.Parameters.Add(paramId);

                    con.Open();
                    byte[] bytes = (byte[])cmd.ExecuteScalar();
                    string strBase64 = Convert.ToBase64String(bytes);
                    Image1.ImageUrl = "data:Image/png;base64," + strBase64;
                }

                }

            }

        }

        private void BindDataReaderData()
        {
            string cs = ConfigurationManager
                .ConnectionStrings["EmployeeDB"].ConnectionString;
            using (SqlConnection con = new SqlConnection(cs))
            {
                SqlCommand cmd = new SqlCommand("Select * from tblRates", con);
                con.Open();
                SqlDataReader rdr = cmd.ExecuteReader();
                while (rdr.Read())
                {
                    ListItem li = new ListItem(rdr["Currency"] + " "  + rdr["Rate"], rdr["Id"].ToString());
                    ddlPrice1.Items.Add(li);
                }
            }
        }

        private void BindDataSetData()
        {
            string cs = ConfigurationManager
                 .ConnectionStrings["EmployeeDB"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);
            SqlDataAdapter da = new SqlDataAdapter("Select * from tblRates", con);
            DataSet ds = new DataSet();
            da.Fill(ds);
            ds.Tables[0].Columns
                .Add("CurrencyAndRate", typeof(string), "Currency + ' ' + Rate");

            ddlPrice.DataTextField = "CurrencyAndRate";
            ddlPrice.DataValueField = "Id";
            ddlPrice.DataSource = ds;
            ddlPrice.DataBind();
        }
    

        protected void Page_PreRender(object sender, EventArgs e)
        {
            Response.Write("Content Page Pre Render event" + "<br/>");
        }

        protected void TextBox_Init(object sender, EventArgs e)
        {
            Response.Write("TextBox_Init event" + "<br/>");
        }


        protected void TextBox_Load(object sender, EventArgs e)
        {
            Response.Write("TextBox_Load Load event" + "<br/>");
        }

        protected void TextBox_PreRender(object sender, EventArgs e)
        {
            Response.Write("TextBox Page Pre Render event" + "<br/>");
        }

        protected void TestUser_Init(object sender, EventArgs e)
        {
            Response.Write("User Control_Init event" + "<br/>");
        }
        protected void TestUser_Load(object sender, EventArgs e)
        {
            Response.Write("User Control_Load Load event" + "<br/>");
        }

        protected void TestUser_PreRender(object sender, EventArgs e)
        {
            Response.Write("User Control Page Pre Render event" + "<br/>");
        }
        private void GetTreeViewItems()
        {
            string cs = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
            SqlConnection con = new SqlConnection(cs);
            SqlDataAdapter da = new SqlDataAdapter("spGetTreeViewItems", con);
            DataSet ds = new DataSet();
            da.Fill(ds);

            ds.Relations.Add("ChildRows", ds.Tables[0].Columns["ID"],
                ds.Tables[0].Columns["ParentId"]);

            foreach (DataRow level1DataRow in ds.Tables[0].Rows)
            {
                if (string.IsNullOrEmpty(level1DataRow["ParentId"].ToString()))
                {
                    TreeNode parentTreeNode = new TreeNode();
                    parentTreeNode.Text = level1DataRow["TreeViewText"].ToString();
                    parentTreeNode.NavigateUrl = level1DataRow["NavigateURL"].ToString();
                    parentTreeNode.Value = level1DataRow["Id"].ToString();
                    GetChildRows(level1DataRow, parentTreeNode);
                    //DataRow[] level2DataRows = level1DataRow.GetChildRows("ChildRows");
                    //foreach (DataRow level2DataRow in level2DataRows)
                    //{
                    //    TreeNode childTreeNode = new TreeNode();
                    //    childTreeNode.Text = level2DataRow["TreeViewText"].ToString();
                    //    childTreeNode.NavigateUrl = level2DataRow["NavigateURL"].ToString();
                    //    parentTreeNode.ChildNodes.Add(childTreeNode);
                    //}

                    // Call  a recrusive fxn
                    TreeView4.Nodes.Add(parentTreeNode);
                }
            }
        }

        private void GetChildRows(DataRow dataRow , TreeNode treeNode)
        {
            DataRow[] childRows =  dataRow.GetChildRows("ChildRows");
            foreach (DataRow childRow in childRows)
            {
                TreeNode childTreeNode = new TreeNode();
                childTreeNode.Text = childRow["TreeViewText"].ToString();
                childTreeNode.NavigateUrl = childRow["NavigateURL"].ToString();
                childTreeNode.Value = childRow["Id"].ToString();
                treeNode.ChildNodes.Add(childTreeNode);
                if (childRow.GetChildRows("ChildRows").Length > 0 )
                {
                    GetChildRows(childRow, childTreeNode);
                }
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            ListBox1.Items.Clear();
            GetSelectedTreeNodes(TreeView4.Nodes[0]);
        }

        private void GetSelectedTreeNodes(TreeNode parentTreeNode)
        {
            if (parentTreeNode.Checked)
            {
                ListBox1.Items.Add(parentTreeNode.Text + " - " + parentTreeNode.Value);
            }
            if (parentTreeNode.ChildNodes.Count > 0)
            {
                foreach (TreeNode childTreeNode in parentTreeNode.ChildNodes)
                {
                    GetSelectedTreeNodes(childTreeNode);
                }
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            HttpPostedFile postedFile = FileUpload1.PostedFile;
            string filename = Path.GetFileName(postedFile.FileName);
            string fileExtension = Path.GetExtension(filename);
            int fileSize = postedFile.ContentLength;

            if (fileExtension.ToLower() == ".jpg" || fileExtension.ToLower() == ".gif"
                || fileExtension.ToLower() == ".png" || fileExtension.ToLower() == ".bmp")
            {
                Stream stream = postedFile.InputStream;
                BinaryReader binaryReader = new BinaryReader(stream);
                Byte[] bytes = binaryReader.ReadBytes((int)stream.Length);


                string cs = ConfigurationManager.ConnectionStrings["EmployeeDB"].ConnectionString;
                using (SqlConnection con = new SqlConnection(cs))
                {
                    SqlCommand cmd = new SqlCommand("spUploadImage", con);
                    cmd.CommandType = CommandType.StoredProcedure;

                    SqlParameter paramName = new SqlParameter()
                    {
                        ParameterName = @"Name",
                        Value = filename
                    };
                    cmd.Parameters.Add(paramName);

                    SqlParameter paramSize = new SqlParameter()
                    {
                        ParameterName = "@Size",
                        Value = fileSize
                    };
                    cmd.Parameters.Add(paramSize);

                    SqlParameter paramImageData = new SqlParameter()
                    {
                        ParameterName = "@ImageData",
                        Value = bytes
                    };
                    cmd.Parameters.Add(paramImageData);

                    SqlParameter paramNewId = new SqlParameter()
                    {
                        ParameterName = "@NewId",
                        Value = -1,
                        Direction = ParameterDirection.Output
                    };
                    cmd.Parameters.Add(paramNewId);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();

                    lblMessage.Visible = true;
                    lblMessage.ForeColor = System.Drawing.Color.Green;
                    lblMessage.Text = "Upload Successful";
                    hyperlink.Visible = true;
                    hyperlink.NavigateUrl = "~/WebForm7.aspx?Id=" +
                        cmd.Parameters["@NewId"].Value.ToString();
                }
            }
            else
            {
                lblMessage.Visible = true;
                lblMessage.ForeColor = System.Drawing.Color.Red;
                lblMessage.Text = "Only images (.jpg, .png, .gif and .bmp) can be uploaded";
                hyperlink.Visible = false;
            }
        }
    }
}

 