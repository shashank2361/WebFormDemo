<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm10.aspx.cs" Inherits="Webforms.WebForm10" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <div>
                <h1>CRUD usign object without any  data source</h1>
                <p>&nbsp;</p>
                <%--Remove Command field and replace with template field--%>

                <div>
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="EmployeeId"
                        ShowFooter="True" BackColor="#DEBA84" BorderColor="#DEBA84"
                        BorderStyle="None" BorderWidth="1px" CellPadding="3"
                        CellSpacing="2" OnRowCommand="GridView1_RowCommand"  >
                        <Columns>

                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbEdit" CommandArgument='<%# Eval("EmployeeId") %>' 
                                        CommandName="EditRow" ForeColor="#8C4510" runat="server">Edit</asp:LinkButton>
                                    <asp:LinkButton ID="lbDelete" CommandArgument='<%# Eval("EmployeeId") %>' 
                                        CommandName="DeleteRow" ForeColor="#8C4510" runat="server" 
                                        CausesValidation="false">Delete</asp:LinkButton>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:LinkButton ID="lbUpdate" CommandArgument='<%# Eval("EmployeeId") %>' 
                                        CommandName="UpdateRow" ForeColor="#8C4510" runat="server">Update</asp:LinkButton>
                                    <asp:LinkButton ID="lbCancel" CommandArgument='<%# Eval("EmployeeId") %>' 
                                        CommandName="CancelUpdate" ForeColor="#8C4510" runat="server" 
                                        CausesValidation="false">Cancel</asp:LinkButton>
                                </EditItemTemplate>
                            </asp:TemplateField>



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
                                    <asp:LinkButton ID="lbInsert" 
                                         CommandName="InsertRow"   
                                        ValidationGroup="Insert"
                                        runat="server">Insert
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



                </div>
            </div>
        </div>
    </form>
</body>
</html>
