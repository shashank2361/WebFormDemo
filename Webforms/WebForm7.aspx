<%@ Page Title="" Language="C#" MasterPageFile="~/Site3.Master" AutoEventWireup="true" CodeBehind="WebForm7.aspx.cs" Inherits="Webforms.WebForm7" %>
 


<%@ Register src="UserControls/TestUserControl.ascx" tagname="TestUserControl" tagprefix="uc1" %>
 

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
 
    <asp:TextBox ID="TextBox1" runat="server"
         OnInit="TextBox_Init" OnLoad="TextBox_Load" OnPreRender="TextBox_PreRender"       >
       
    </asp:TextBox>
  
    <br />
    <uc1:TestUserControl ID="TestUserControl1" runat="server"          
        OnInit="TestUser_Init" OnLoad="TestUser_Load" OnPreRender="TestUser_PreRender"  />
    <br />
    <i>Tree View</i>
    <br />
    <div style="display:flex;float:left"> 
        <div>
        <asp:TreeView ID="TreeView1" runat="server">
      
             <HoverNodeStyle BackColor="#00CC00" Font-Bold="True" />
      
             <Nodes> 
        <asp:TreeNode Text="Home" NavigateUrl="~/Home.aspx" Target="_blank" />
        <asp:TreeNode Text="Employee" NavigateUrl="~/Employee.aspx" Target="_blank">
            <asp:TreeNode Text="Upload Resume" NavigateUrl="~/UploadResume.aspx" Target="_blank"/>
            <asp:TreeNode Text="Edit Resume" NavigateUrl="~/EditResume.aspx" Target="_blank"/>
            <asp:TreeNode Text="View Resume" NavigateUrl="~/ViewResume.aspx" Target="_blank"/>
        </asp:TreeNode>
        <asp:TreeNode Text="Employer" NavigateUrl="~/Employer.aspx" Target="_blank">
            <asp:TreeNode Text="Upload Job" NavigateUrl="~/UploadJob.aspx" Target="_blank"/>
            <asp:TreeNode Text="Edit Job" NavigateUrl="~/EditJob.aspx" Target="_blank"/>
            <asp:TreeNode Text="View Job" NavigateUrl="~/ViewJob.aspx" Target="_blank"/>
        </asp:TreeNode>
        <asp:TreeNode Text="Admin" NavigateUrl="~/Admin.aspx" Target="_blank">
            <asp:TreeNode Text="Add User" NavigateUrl="~/AddUser.aspx" Target="_blank"/>
            <asp:TreeNode Text="Edit User" NavigateUrl="~/EditUser.aspx" Target="_blank"/>
            <asp:TreeNode Text="View User" NavigateUrl="~/ViewUser.aspx" Target="_blank"/>
        </asp:TreeNode>
    </Nodes>
    


    </asp:TreeView>

    </div>

        <div>
            Tree view with XML
            <asp:XmlDataSource ID="XmlDataSource1" runat="server" DataFile="~/Data/TreeViewData.xml" XPath="/Items/TreeViewItem"></asp:XmlDataSource>

            <asp:TreeView ID="TreeView2"  DataSourceID="XmlDataSource1" runat="server">
                <DataBindings>
                    <asp:TreeNodeBinding DataMember="TreeViewItem" TextField="Text" NavigateUrlField="NavigateUrl" Target="_blank" />
                </DataBindings>


            </asp:TreeView>

        </div>
       <div>
           Tree view with Sitemap
           <asp:SiteMapDataSource ID="SiteMapDataSource1" ShowStartingNode="false" runat="server" />
           <asp:TreeView ID="Treeview3" Target="_blank" DataSourceID="SiteMapDataSource1" runat="server">
    </asp:TreeView>
       </div>
     
        <div>
            <i>Tree view Data base</i>
            <br />
                    <asp:TreeView ID="TreeView4" ShowCheckBoxes="All" runat="server"></asp:TreeView>
            <br />
             
                <asp:Button ID="Button1" runat="server" onclick="Button1_Click"     Text=">>" />            
            
           
                <asp:ListBox ID="ListBox1" ForeColor="Black" runat="server" Height="145px"   Width="100px">         </asp:ListBox>
        </div>


        <div>
            <asp:FileUpload ID="FileUpload1" runat="server" />
<br /><br />
<asp:Button ID="btnUpload" runat="server" Text="Upload" OnClick="btnUpload_Click" />
<br /><br />
<asp:Label ID="lblMessage" runat="server"></asp:Label>
<br /><br />
<asp:HyperLink ID="hyperlink" runat="server">View Uploaded Image</asp:HyperLink>
            <br />
            <asp:Image ID="Image1" Height="100px" Width="100px" runat="server" />
        </div>
    </div>
    
       <asp:DropDownList ID="ddlPrice" runat="server"></asp:DropDownList>
       <asp:DropDownList ID="ddlPrice1" runat="server"></asp:DropDownList>

 </asp:Content>

