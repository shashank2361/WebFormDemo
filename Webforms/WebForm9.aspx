<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm9.aspx.cs" Inherits="Webforms.WebForm9" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h1>CRUD usign object data source</h1>
            <div>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
              DataKeyNames="EmployeeId" DataSourceID="ObjectDataSource1" 
              ShowFooter="True" BackColor="#DEBA84" BorderColor="#DEBA84"
              BorderStyle="None" BorderWidth="1px" CellPadding="3" 
              CellSpacing="2">
    <Columns>
        <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
        <asp:TemplateField HeaderText="EmployeeId" InsertVisible="False" 
                           SortExpression="EmployeeId">
            <EditItemTemplate>
                <asp:Label ID="Label1" runat="server" 
                           Text='<%# Eval("EmployeeId") %>'>
                </asp:Label>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label1" runat="server" 
                           Text='<%# Bind("EmployeeId") %>'>
                </asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:LinkButton ID="lbInsert" ValidationGroup="Insert" 
                    runat="server" OnClick="lbInsert_Click">Insert
                </asp:LinkButton>
            </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Name" SortExpression="Name">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox1" runat="server" 
                             Text='<%# Bind("Name") %>'>
                </asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditName" runat="server" 
                    ErrorMessage="Name is a required field"
                    ControlToValidate="TextBox1" Text="*" ForeColor="Red">
                </asp:RequiredFieldValidator>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label2" runat="server" 
                    Text='<%# Bind("Name") %>'>
                </asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvInsertName" runat="server" 
                    ErrorMessage="Name is a required field" 
                    ControlToValidate="txtName" Text="*" ForeColor="Red"
                    ValidationGroup="Insert">
                </asp:RequiredFieldValidator>
            </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="Gender" SortExpression="Gender">
            <EditItemTemplate>
                <asp:DropDownList ID="DropDownList1" runat="server" 
                    SelectedValue='<%# Bind("Gender") %>'>
                    <asp:ListItem>Select Gender</asp:ListItem>
                    <asp:ListItem>Male</asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvEditGender" runat="server" 
                    ErrorMessage="Gender is a required field" Text="*"
                    ControlToValidate="DropDownList1" ForeColor="Red" 
                    InitialValue="Select Gender">
                </asp:RequiredFieldValidator>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label3" runat="server" 
                    Text='<%# Bind("Gender") %>'>
                </asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:DropDownList ID="ddlInsertGender" runat="server">
                    <asp:ListItem>Select Gender</asp:ListItem>
                    <asp:ListItem>Male</asp:ListItem>
                    <asp:ListItem>Female</asp:ListItem>
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvInsertGender" runat="server" 
                    ErrorMessage="Gender is a required field" Text="*"
                    ControlToValidate="ddlInsertGender" ForeColor="Red" 
                    InitialValue="Select Gender" ValidationGroup="Insert">
                </asp:RequiredFieldValidator>
            </FooterTemplate>
        </asp:TemplateField>
        <asp:TemplateField HeaderText="City" SortExpression="City">
            <EditItemTemplate>
                <asp:TextBox ID="TextBox3" runat="server" 
                    Text='<%# Bind("City") %>'></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvEditCity" runat="server" 
                    ErrorMessage="City is a required field" Text="*"
                    ControlToValidate="TextBox3" ForeColor="Red">
                </asp:RequiredFieldValidator>
            </EditItemTemplate>
            <ItemTemplate>
                <asp:Label ID="Label4" runat="server" 
                    Text='<%# Bind("City") %>'></asp:Label>
            </ItemTemplate>
            <FooterTemplate>
                <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
                <asp:RequiredFieldValidator ID="rfvInsertCity" runat="server" 
                    ErrorMessage="City is a required field" Text="*" 
                    ControlToValidate="txtCity" ForeColor="Red" 
                    ValidationGroup="Insert">
                </asp:RequiredFieldValidator>
            </FooterTemplate>
        </asp:TemplateField>
    </Columns>
    <FooterStyle BackColor="#F7DFB5" ForeColor="#8C4510" />
    <HeaderStyle BackColor="#A55129" Font-Bold="True" ForeColor="White" />
    <PagerStyle ForeColor="#8C4510" HorizontalAlign="Center" />
    <RowStyle BackColor="#FFF7E7" ForeColor="#8C4510" />
    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="White" />
    <SortedAscendingCellStyle BackColor="#FFF1D4" />
    <SortedAscendingHeaderStyle BackColor="#B95C30" />
    <SortedDescendingCellStyle BackColor="#F1E5CE" />
    <SortedDescendingHeaderStyle BackColor="#93451F" />
</asp:GridView>
<asp:ValidationSummary ID="ValidationSummary1" ValidationGroup="Insert" 
    ForeColor="Red" runat="server" />
<asp:ValidationSummary ID="ValidationSummary2" ForeColor="Red" 
    runat="server" />



    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="DeleteEmployee" InsertMethod="InsertEmployee" SelectMethod="GetAllEmployees" TypeName="Webforms.EmployeeDataAccessLayer" UpdateMethod="UpdateEmployee">
        <DeleteParameters>
            <asp:Parameter Name="EmployeeId" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Gender" Type="String" />
            <asp:Parameter Name="City" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="EmployeeId" Type="Int32" />
            <asp:Parameter Name="Name" Type="String" />
            <asp:Parameter Name="Gender" Type="String" />
            <asp:Parameter Name="City" Type="String" />
        </UpdateParameters>
                </asp:ObjectDataSource>

</div>
        </div>
    </form>
</body>
</html>
