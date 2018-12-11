<%@ Page Language="C#" AutoEventWireup="true"
    MasterPageFile="~/Site.Master" CodeBehind="WebForm4.aspx.cs"
    Inherits="Webforms.WebForm4" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">


    <%@ Register Src="~/UserControls/UCProductsControl.ascx" TagPrefix="uc1" TagName="UCProductsControl" %>

    <script src="Scripts/jquery-3.3.1.min.js"></script>
    <link href="Content/jquery-ui.theme.min.css" rel="stylesheet" />
    <link href="Content/jquery-ui.structure.min.css" rel="stylesheet" />
    <link href="Content/style.css" rel="stylesheet" />
    <link href="Content/style.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.10/css/dataTables.bootstrap.min.css " />
    <script src="https://cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js" type="text/javascript"></script>

    <script src="Scripts/jquery-ui.min.js"></script>
    <script type="text/javascript">



        $('#MainContent_GridView3').DataTable({
        });


        $(function () {
            $('#<%= txtStudentName.ClientID %>').autocomplete({
                source: function (request, response) {

                    $.ajax({
                        url: "studentservice.asmx/GetStudentNames",
                        data: "{ 'searchItem': '" + request.term + "' }",
                        type: "POST",
                        dataType: "json",
                        contentType: "application/json;charset=utf-8",
                        success: function (data) {
                            response(data.d);
                        },
                        error: function (result) {
                            alert('There is a problem processing your request');
                        }
                    });
                },
                minLength: 0
            });
        });
    </script>

    <div style="display: flex; float: left; width: 1200px;">

        <div style="font-family: Arial; width: 400px">
            <i>Catching user control by querystring by using VaryByParam
      use  ?ProductName=Laptop
            </i>
            <table style="border: 1px solid black">
                <tr>
                    <td>Page content that changes
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Page Server Time:
                    <asp:Label ID="msgLabel1" runat="server" Text="Label"></asp:Label>
                        </b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Page Client Time:
                    <script type="text/javascript">
                        document.write(Date());
                    </script>
                        </b>
                    </td>
                </tr>
                <tr>
                    <td>

                        <br />
                        <br />
                        <uc1:UCProductsControl runat="server" ID="UCProductsControl" />

                    </td>
                </tr>
            </table>
        </div>

        <div style="width: 350px; border: 1px dotted gray">
            <asp:Button ID="btnGetProducts" runat="server" Text="Get Products Data"
                OnClick="btnGetProducts_Click" />
            <br />
            <br />
            <asp:GridView ID="gvProducts" runat="server">
            </asp:GridView>
            <br />
            <asp:Label ID="lblMessage" Font-Bold="true" runat="server"></asp:Label>
        </div>

        <div style="width: 350px; border: 1px dotted gray">
            <i>Cache from XML file resolve Cache dependency </i>
            <div style="font-family: Arial">
                <asp:Button ID="btnGetCountries" runat="server" Text="Get Countries"
                    OnClick="btnGetCountries_Click" />
                <asp:Button ID="btnRemoveCachedItem" runat="server" Text="Remove Cached " OnClick="btnRemoveCachedItem_Click" />
                <br />
                <br />
                <asp:GridView ID="gvCountries" runat="server">
                </asp:GridView>
                <br />
                &nbsp;
    <asp:Button ID="btnGetCacheStatus" runat="server" Text="Get Cache Status"
        OnClick="btnGetCacheStatus_Click" />
                <br />
                &nbsp;

                <asp:Label ID="msgLabel2" Font-Bold="true" runat="server"></asp:Label>
                <br />
                <asp:Label ID="msgCacheChanged" Font-Bold="true" runat="server"></asp:Label>
            </div>
            <hr />
            <div>
                <i>Object data Source Delete </i>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server"
                    DeleteMethod="DeleteEmployee"
                    SelectMethod="GetAllEmployees"
                    TypeName="Webforms.EmployeeDataAccessLayer">
                    <DeleteParameters>
                        <asp:Parameter Name="EmployeeId" Type="Int32" />
                    </DeleteParameters>
                </asp:ObjectDataSource>

                <asp:GridView ID="GridView7" runat="server"
                    DataSourceID="ObjectDataSource2" AutoGenerateColumns="False"
                    DataKeyNames="EmployeeId" CellPadding="4" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="EmployeeId" HeaderText="EmployeeId" SortExpression="EmployeeId" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                        <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <SortedAscendingCellStyle BackColor="#F5F7FB" />
                    <SortedAscendingHeaderStyle BackColor="#6D95E1" />
                    <SortedDescendingCellStyle BackColor="#E9EBEF" />
                    <SortedDescendingHeaderStyle BackColor="#4870BE" />
                </asp:GridView>
                <hr />
                <br />
                <i>Optimistic concurrency Objectdatasourse</i>
                <asp:ObjectDataSource ID="ObjectDataSource3" runat="server"
                    DeleteMethod="DeleteEmployee" SelectMethod="GetAllEmployees"
                    ConflictDetection="CompareAllValues"
                    OldValuesParameterFormatString="original_{0}"
                    TypeName="Webforms.EmployeeDataAccessLayer">
                    <DeleteParameters>
                        <asp:Parameter Name="original_EmployeeId" Type="Int32" />
                        <asp:Parameter Name="original_Name" Type="String" />
                        <asp:Parameter Name="original_Gender" Type="String" />
                        <asp:Parameter Name="original_City" Type="String" />
                    </DeleteParameters>
                </asp:ObjectDataSource>
                <asp:GridView ID="GridView8" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource3">
                    <Columns>
                        <asp:CommandField ShowDeleteButton="True" />
                        <asp:BoundField DataField="EmployeeId" HeaderText="EmployeeId" SortExpression="EmployeeId" />
                        <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                        <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                        <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                    </Columns>
                </asp:GridView>

                <br />



            </div>
        </div>

        <div style="font-family: Arial; width: 480px; border: 1px dotted gray">

            <asp:Button ID="btnGetSQLData" runat="server" Text="Get Data"
                OnClick="btnGetSQLData_Click" />
            <br />
            <br />
            <asp:GridView ID="gvSQLProducts" runat="server">
            </asp:GridView>
            <br />
            <asp:Label ID="lblSQLStatus" runat="server" Font-Bold="true">
            </asp:Label>
            <hr />

        </div>

        <div style="font-family: Arial; width: 380px; border: 1px groove gray">
            <i>AutoComplet TextBox</i>
            <asp:TextBox ID="txtStudentName" runat="server"></asp:TextBox>
            <asp:Button ID="btnSubmit" runat="server" Text="Button" OnClick="btnSubmit_Click" />

            <br />
            <asp:GridView ID="gvStudents" runat="server"></asp:GridView>
            <hr />
            <br />

            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:EmployeeDB %>" SelectCommand="spGetContinents"
                SelectCommandType="StoredProcedure"></asp:SqlDataSource>

            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:EmployeeDB %>" SelectCommand="spGetCountriesByContinentId" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="DropDownList1" Name="ContinentId" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <i>Bind Dropdown and GridView using SQL datasource</i>
            <asp:DropDownList ID="DropDownList1"
                runat="server" DataSourceID="SqlDataSource2"
                DataTextField="ContinentName" DataValueField="ContinentId" AutoPostBack="True">
            </asp:DropDownList>
            <br />
            <asp:GridView ID="GridView4" runat="server"
                AutoGenerateColumns="False" DataSourceID="SqlDataSource3" DataKeyNames="CountryId">
                <Columns>
                    <asp:BoundField DataField="CountryId" HeaderText="CountryId" InsertVisible="False" ReadOnly="True" SortExpression="CountryId" />
                    <asp:BoundField DataField="CountryName" HeaderText="CountryName" SortExpression="CountryName" />
                </Columns>
            </asp:GridView>
            <br />
            <hr />
            <i>Delete using datasource RowDataBound</i>
            <asp:SqlDataSource ID="SqlDataSource4" runat="server"
                ConnectionString="<%$ ConnectionStrings:EmployeeDB %>"
                SelectCommand="SELECT [EmployeeId], [Name], [Gender], [City] FROM [tblEmployee]"
                DeleteCommand="DELETE FROM [tblEmployee] WHERE [EmployeeId] = @original_EmployeeId AND (([Name] = @original_Name) OR ([Name] IS NULL AND @original_Name IS NULL)) AND (([Gender] = @original_Gender) OR ([Gender] IS NULL AND @original_Gender IS NULL)) AND (([City] = @original_City) OR ([City] IS NULL AND @original_City IS NULL))" ConflictDetection="CompareAllValues" InsertCommand="INSERT INTO [tblEmployee] ([Name], [Gender], [City]) VALUES (@Name, @Gender, @City)" OldValuesParameterFormatString="original_{0}" UpdateCommand="UPDATE [tblEmployee] SET [Name] = @Name, [Gender] = @Gender, [City] = @City WHERE [EmployeeId] = @original_EmployeeId AND (([Name] = @original_Name) OR ([Name] IS NULL AND @original_Name IS NULL)) AND (([Gender] = @original_Gender) OR ([Gender] IS NULL AND @original_Gender IS NULL)) AND (([City] = @original_City) OR ([City] IS NULL AND @original_City IS NULL))">
                <DeleteParameters>
                    <asp:Parameter Name="original_EmployeeId" Type="Int32" />
                    <asp:Parameter Name="original_Name" Type="String" />
                    <asp:Parameter Name="original_Gender" Type="String" />
                    <asp:Parameter Name="original_City" Type="String" />
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
                    <asp:Parameter Name="original_EmployeeId" Type="Int32" />
                    <asp:Parameter Name="original_Name" Type="String" />
                    <asp:Parameter Name="original_Gender" Type="String" />
                    <asp:Parameter Name="original_City" Type="String" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False"
                DataKeyNames="EmployeeId" DataSourceID="SqlDataSource4" OnRowDataBound="GridView5_RowDataBound" OnRowDeleted="GridView5_RowDeleted">
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" />
                    <asp:BoundField DataField="EmployeeId" HeaderText="EmployeeId" InsertVisible="False" ReadOnly="True" SortExpression="EmployeeId" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                    <asp:BoundField DataField="City" HeaderText="City" SortExpression="City" />
                </Columns>
            </asp:GridView>
            <br />
            <asp:Label ID="deletedlbl" runat="server"></asp:Label>
        </div>

        <div>
            <i>Grid View 1 from Databind</i>
            <br />
            <asp:GridView ID="GridView1" runat="server"></asp:GridView>
            <br />
            <i>Object Data source</i>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" SelectMethod="GetAllProducts" TypeName="Webforms.ProductDataAccessLayer"></asp:ObjectDataSource>
            <br />
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="ObjectDataSource1">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" />
                    <asp:BoundField DataField="Name" HeaderText="Name" SortExpression="Name" />
                    <asp:BoundField DataField="ProductDescription" HeaderText="ProductDescription" SortExpression="ProductDescription" />
                </Columns>
            </asp:GridView>


            <div>

                <div style="font-family: Arial">
                    <br />

                    <asp:SqlDataSource ID="SqlDataSource1" runat="server"
                        ConnectionString="<%$ ConnectionStrings:EmployeeDB %>" SelectCommand="SELECT [ID], [FirstName], [Gender], [LastName], [Salary], [DateOfBirth], [Country] FROM [Employees]"></asp:SqlDataSource>
                    <i>using sql datasource</i>

                    <asp:GridView ID="GridView3" runat="server" DataSourceID="SqlDataSource1"
                        AutoGenerateColumns="False" DataKeyNames="ID"
                        OnRowDataBound="GridView3_RowDataBound" CellPadding="4" ForeColor="#333333" GridLines="None">
                        <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                        <Columns>
                            <asp:BoundField DataField="ID" HeaderText="ID" ItemStyle-CssClass="DisplayNone" HeaderStyle-CssClass="DisplayNone" InsertVisible="False" ReadOnly="True" SortExpression="ID">
                                <HeaderStyle CssClass="DisplayNone"></HeaderStyle>

                                <ItemStyle CssClass="DisplayNone"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                            <asp:BoundField DataField="Gender" HeaderText="Gender" SortExpression="Gender" />
                            <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                            <asp:BoundField DataField="Salary" HeaderText="Salary" SortExpression="Salary" />
                            <asp:BoundField DataField="DateOfBirth" HeaderText="DateOfBirth"
                                SortExpression="DateOfBirth" DataFormatString="{0:D}" />
                            <asp:BoundField DataField="Country" HeaderText="Country" SortExpression="Country" />
                            <%-- ItemStyle-CssClass="DisplayNone" HeaderStyle-CssClass="DisplayNone"--%>
                        </Columns>
                        <EditRowStyle BackColor="#999999" />
                        <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                        <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#E9E7E2" />
                        <SortedAscendingHeaderStyle BackColor="#506C8C" />
                        <SortedDescendingCellStyle BackColor="#FFFDF8" />
                        <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
                    </asp:GridView>

                    <div>
                    </div>

                </div>



            </div>


        </div>


    </div>
    <hr />
    <br />

    <div style="align-content: flex-start">
        <div style="width: 350px">
            <i>Editing SQL datasource GridView</i>
            <asp:SqlDataSource ID="SqlDataSource5" runat="server"
                ConnectionString="<%$ ConnectionStrings:EmployeeDB %>"
                SelectCommand="SELECT * FROM [tblEmployee]"
                UpdateCommand="UPDATE [tblEmployee] SET [Name] = @Name, [Gender] = @Gender, [City] = @City WHERE [EmployeeId] = @EmployeeId" DeleteCommand="DELETE FROM [tblEmployee] WHERE [EmployeeId] = @EmployeeId" InsertCommand="INSERT INTO [tblEmployee] ([Name], [Gender], [City]) VALUES (@Name, @Gender, @City)">

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
            <br />

            <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False"
                DataKeyNames="EmployeeId" DataSourceID="SqlDataSource5">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="True" CommandName="Update" Text="Update"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel"></asp:LinkButton>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete"></asp:LinkButton>
                        </ItemTemplate>


                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="EmployeeId" InsertVisible="False" SortExpression="EmployeeId">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("EmployeeId") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("EmployeeId") %>'></asp:Label>
                        </ItemTemplate>

                    </asp:TemplateField>


                    <asp:TemplateField HeaderText="Name" SortExpression="Name">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" 
                                Text='<%# Bind("Name") %>'></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvEditName" runat="server" 
                            ErrorMessage="Name is a required field"
                            ControlToValidate="TextBox1" Text="*" ForeColor="Red">
                        </asp:RequiredFieldValidator>
                            
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                        </ItemTemplate>

                        
                    </asp:TemplateField>




                    <asp:TemplateField HeaderText="Gender" SortExpression="Gender">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownList2" SelectedValue='<%# Bind("Gender") %>' runat="server">
                                <asp:ListItem>Select Gender</asp:ListItem>
                                <asp:ListItem Value="Male">Male</asp:ListItem>
                                <asp:ListItem Value="Female">Female</asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvEditGender" runat="server"
                                ErrorMessage="Gender is a required field" Text="*"
                                ControlToValidate="DropDownList2" ForeColor="Red"
                                InitialValue="Select Gender">
                            </asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
                        </ItemTemplate>






                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="City" SortExpression="City">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("City") %>'></asp:TextBox>
                         <asp:RequiredFieldValidator ID="rfvEditCity" runat="server" 
                    ErrorMessage="City is a required field" Text="*"
                    ControlToValidate="TextBox3" ForeColor="Red">
                </asp:RequiredFieldValidator>

                        
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("City") %>'></asp:Label>
                        </ItemTemplate>
                         




                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            <asp:Label ID="lbleditStatus" runat="server" ></asp:Label>

            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red" />
        </div>




    </div>

</asp:Content>
