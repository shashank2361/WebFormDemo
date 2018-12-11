<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="WebForm5.aspx.cs" Inherits="Webforms.WebForm5"   %>
  <%@ MasterType VirtualPath="~/Site.Master" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 style="position:relative;padding-top:100px">This is Content page</h1>
    <i>Data form Content to Master</i>
    <br />
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:Button ID="Button1" runat="server" Text="Button" OnClick="Button1_Click" />

<br />
    <hr />
    <i> Data from Master to Content</i>

    <br />
    <asp:GridView ID="GridView1" runat="server">
</asp:GridView>

    <br />
    <br />



</asp:Content>


