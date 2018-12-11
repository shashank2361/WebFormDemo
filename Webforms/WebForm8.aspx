<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm8.aspx.cs" Inherits="Webforms.WebForm8" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <script>
         function toggleSelectionUsingHeaderCheckBox(source) {
        $("#GridView4 input[name$='cbDelete1']").each(function () {
            $(this).attr('checked', source.checked);
        });

         }


        function toggleSelectionOfHeaderCheckBox() {
            if ($("#GridView4 input[name$='cbDelete1']").length ==
                $("#GridView4 input[name$='cbDelete1']:checked").length) {
                    $("#GridView4_cbDeleteHeader1").prop('checked', true);

            //$("input[name$='cbDeleteHeader1']").first().attr('checked', true);
        }
            else {
    $("#GridView4_cbDeleteHeader1").prop('checked', false);
             //$("#GridView4_cbDeleteHeader1']").first().attr('checked', false);

        }
    }



        $(document).ready(function () {
        $("#btnDelete1").click(function () {
            var rowsSelected = $("#GridView4 input[name$='cbDelete1']:checked").length;
            if (rowsSelected == 0) {
                alert('No rows selected');
                return false;
            }
            else
                return confirm(rowsSelected + ' row(s) will be deleted');
        });
        });




    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Crud operation using SQL Datasource Control
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                DataKeyNames="EmployeeId" DataSourceID="SqlDataSource1"
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
            <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                ConnectionString="<%$ ConnectionStrings:EmployeeDB %>"
                DeleteCommand="DELETE FROM [tblEmployee] WHERE [EmployeeId] = @EmployeeId"
                InsertCommand="INSERT INTO [tblEmployee] ([Name], [Gender], [City]) 
        VALUES (@Name, @Gender, @City)"
                SelectCommand="SELECT * FROM [tblEmployee]"
                UpdateCommand="UPDATE [tblEmployee] SET [Name] = @Name, [Gender] = @Gender,
        [City] = @City WHERE [EmployeeId] = @EmployeeId">
                <DeleteParameters>
                    <asp:Parameter Name="EmployeeId" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                    <asp:Parameter Name="City" Type="String" />
                </InsertParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Name" Type="String" />
                    <asp:Parameter Name="Gender" Type="String" />
                    <asp:Parameter Name="City" Type="String" />
                    <asp:Parameter Name="EmployeeId" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>


        </div>
        <br />
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:EmployeeDB %>" SelectCommand="SELECT * FROM [tblProduct]"></asp:SqlDataSource>
        <div style="display:flex;float:left">
            <div>
                <h2>Displaying Summary Data  Datasource Control</h2>
                <h3>Empty data template</h3>

                <asp:GridView ID="GridView2" runat="server"
                    AutoGenerateColumns="False" BackColor="White" BorderColor="#CC9966"
                    BorderStyle="None" BorderWidth="1px" CellPadding="4"
                    DataKeyNames="ProdcutId" ShowFooter="True"
                    EmptyDataText="There are no products to display"
                    DataSourceID="SqlDataSource2" OnRowDataBound="GridView2_RowDataBound">
                    <Columns>
                        <asp:BoundField DataField="ProdcutId" HeaderText="ProdcutId" InsertVisible="False" ReadOnly="True" SortExpression="ProdcutId" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" SortExpression="UnitPrice" />
                        <asp:BoundField DataField="QuantitySold" HeaderText="QuantitySold" SortExpression="QuantitySold" />
                        <asp:TemplateField></asp:TemplateField>
                    </Columns>
                    <EmptyDataTemplate>
                        <table cellspacing="2" cellpadding="3" rules="all" id="GridView1" style="background-color: #DEBA84; border-color: #DEBA84; border-width: 1px; border-style: None;">
                            <tr style="color: White; background-color: #A55129; font-weight: bold;">
                                <td scope="col">ProdcutId
                                </td>
                                <td scope="col">Name
                                </td>
                                <td scope="col">UnitPrice
                                </td>
                                <td scope="col">QuantitySold
                                </td>
                            </tr>
                            <tr style="color: #8C4510; background-color: #FFF7E7;">
                                <td colspan="4">There are no products to display
                                </td>
                            </tr>
                        </table>
                    </EmptyDataTemplate>
                    <FooterStyle BackColor="#FFFFCC" ForeColor="#330099" />
                    <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="#FFFFCC" />
                    <PagerStyle BackColor="#FFFFCC" ForeColor="#330099" HorizontalAlign="Center" />
                    <RowStyle BackColor="White" ForeColor="#330099" />
                    <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="#663399" />
                    <SortedAscendingCellStyle BackColor="#FEFCEB" />
                    <SortedAscendingHeaderStyle BackColor="#AF0101" />
                    <SortedDescendingCellStyle BackColor="#F6F0C0" />
                    <SortedDescendingHeaderStyle BackColor="#7E0000" />
                </asp:GridView>
            </div>
            <div>
                <br />
                <h2>Delete multiple rows from asp.net gridview</h2>
                <h2>
                    <asp:Button ID="btnDelete" runat="server" Text="Delete" OnClick="btnDelete_Click" />
                    &nbsp;</h2>
                <p>
                    <asp:GridView ID="GridView3" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None" AutoGenerateColumns="False">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="cbDeleteHeader" runat="server" AutoPostBack="True" OnCheckedChanged="cbDeleteHeader_CheckedChanged" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbDelete" runat="server" AutoPostBack="True" OnCheckedChanged="cbDelete_CheckedChanged" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EmployeeId">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmployeeId" runat="server"
                                        Text='<%# Bind("EmployeeId") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Name" HeaderText="Name" />
                            <asp:BoundField DataField="Gender" HeaderText="Gender" />
                            <asp:BoundField DataField="City" HeaderText="City" />
                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#E3EAEB" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>
                </p>
                <asp:Label ID="lblMessage" runat="server" Text="Label"></asp:Label>
            </div>


             <div>
                <br />
                <h2>Delete multiple rows from asp.net gridview using Jquery</h2>
                <h2>
                    <asp:Button ID="btnDelete1" runat="server" Text="Delete" 
                        OnClick="btnDelete1_Click" />
                    &nbsp;</h2>
                <p>
                    <asp:GridView ID="GridView4" runat="server" CellPadding="4" ForeColor="Black" GridLines="Vertical" AutoGenerateColumns="False" BackColor="White" BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="cbDeleteHeader1" OnClick="toggleSelectionUsingHeaderCheckBox(this)" runat="server" 
                                        
                                        AutoPostBack="false"  />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="cbDelete1" runat="server" AutoPostBack="false"
                                        OnClick =" toggleSelectionOfHeaderCheckBox();"/>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="EmployeeId">
                                <ItemTemplate>
                                    <asp:Label ID="lblEmployeeId1" runat="server"
                                        Text='<%# Bind("EmployeeId") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="Name" HeaderText="Name" />
                            <asp:BoundField DataField="Gender" HeaderText="Gender" />
                            <asp:BoundField DataField="City" HeaderText="City" />
                        </Columns>
                        <FooterStyle BackColor="#CCCC99" />
                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                        <RowStyle BackColor="#F7F7DE" />
                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#FBFBF2" />
                        <SortedAscendingHeaderStyle BackColor="#848384" />
                        <SortedDescendingCellStyle BackColor="#EAEAD3" />
                        <SortedDescendingHeaderStyle BackColor="#575357" />
                    </asp:GridView>
                </p>
                <asp:Label ID="lblMessage1" runat="server" Text="Label"></asp:Label>
            </div>

        </div>

    </form>
</body>
</html>
