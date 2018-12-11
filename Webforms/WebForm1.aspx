<%@ Page Language="C#" AutoEventWireup="true" EnableSessionState="True" CodeBehind="WebForm1.aspx.cs" Inherits="Webforms.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<script src="Scripts/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    function LinkButonClientClick() {
        return confirm("Are you sure you want to delete ?");
    }

    function IsEven(source, args) {
        if (args.Value == "") {
            args.IsValid = false;
        }
        else {
            if (args.Value % 2 == 0) {
                args.IsValid = true;
            }
            else {
                args.IsValid = false;
            }
        }
    }

    function OpenNewWindow() {
        var Name = document.getElementById('TextBoxName').value;
        var Place = document.getElementById('TextBoxPlace').value;
        window.open('WebForm2.aspx?Name=' + Name + '&Place=' + Place, '_blank',
            'toolbar=no, location=no, resizable=yes, width=500px, height=500px', true);


    }
</script>
<body>
    <br />
    <br />

    <form id="form1" runat="server">

        <br />

        <div style="display: flex; justify-content: flex-start">



            <div style="max-width: 350px; text-align: left; border: 1px solid black">
                <div>
                    UserName
                    <asp:TextBox ID="TextBox1" runat="server" Height="22px"
                        Width="183px"></asp:TextBox>

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ForeColor="Red" runat="server" ErrorMessage="Please enter the text"
                        ControlToValidate="TextBox1" ValidationGroup="Registration" Text="*"></asp:RequiredFieldValidator>
                    <br />

                    Gender   
                    <asp:DropDownList ID="DropDownList6" runat="server">
                        <asp:ListItem Text="Select Gender" Value="-1"></asp:ListItem>
                        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                    </asp:DropDownList>

                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorGender" runat="server"
                        ErrorMessage="Gender is required" ForeColor="Red" InitialValue="-1"
                        ControlToValidate="DropDownList6" ValidationGroup="Registration" Display="Dynamic">
                    </asp:RequiredFieldValidator>
                    <br />
                    Age 
                    <asp:TextBox ID="TextBox5" type="Number" runat="server"></asp:TextBox>
                    <asp:RangeValidator ID="RangeValidator1" Type="Integer"
                        MinimumValue="1" MaximumValue="100" Display="Dynamic"
                        runat="server" ForeColor="Red" ValidationGroup="Registration" ErrorMessage="invalid age"
                        ControlToValidate="TextBox5"></asp:RangeValidator>
                    <br />

                    <asp:CompareValidator ID="CompareValidatorAge" runat="server"
                        ErrorMessage="Age must be a number - Compare Validator" ControlToValidate="TextBox5"
                        Operator="DataTypeCheck" Type="Integer" ForeColor="Red" ValidationGroup="Registration"
                        SetFocusOnError="true"></asp:CompareValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" Display="Dynamic" ControlToValidate="TextBox5"
                        runat="server" ForeColor="Red" ValidationGroup="Registration" ErrorMessage="Enter Age "></asp:RequiredFieldValidator>
                    <br />
                    password :<asp:TextBox ID="txtPassword" runat="server" Width="150px" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorPassword"
                        runat="server" ForeColor="Red"
                        ErrorMessage="Password is required"
                        ControlToValidate="txtPassword" Display="Dynamic" ValidationGroup="Registration" Text="*">
                    </asp:RequiredFieldValidator>
                    <br />

                    retype password:
                    <asp:TextBox ID="txtRetypePassword" runat="server"
                        Width="150px" TextMode="Password"></asp:TextBox>
                    <br />



                    <asp:CompareValidator ID="CompareValidatorPassword" runat="server"
                        ErrorMessage="Password and Retype Password must match"
                        ControlToValidate="txtRetypePassword" ControlToCompare="txtPassword"
                        Type="String" Operator="Equal" ValidationGroup="Registration" ForeColor="Red">
                    </asp:CompareValidator>


                    <br />
                    Email
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email"></asp:TextBox>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidatorEmail"
                        runat="server" ControlToValidate="txtEmail"
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                        ErrorMessage="Invalid Email" ValidationGroup="Registration"
                        ForeColor="Red"></asp:RegularExpressionValidator>
                    <br />

                    Even Number
                    <asp:TextBox ID="txtEvenNumber" runat="server"></asp:TextBox>
                    <asp:CustomValidator ID="CustomValidatorEvenNumber" runat="server"
                        ForeColor="Red"
                        ErrorMessage="Not an even number"
                        OnServerValidate="CustomValidatorEvenNumber_ServerValidate"
                        ControlToValidate="txtEvenNumber"
                        ClientValidationFunction="IsEven"
                        ValidationGroup="Registration"
                        ValidateEmptyText="true">
                    </asp:CustomValidator>
                    <br />
                    <br />
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server"
                        ForeColor="Red" HeaderText="Please solve the following Errors"
                        ShowMessageBox="True" ValidationGroup="Registration" ShowSummary="true" DisplayMode="List" />
                    <p>

                        <asp:Label ID="Label2" runat="server" Text="Label"></asp:Label>
                        <br />
                        Date Avaliable 
                        <asp:TextBox ID="txtDateAvailable" runat="server"></asp:TextBox>
                        <br />
                        <asp:RangeValidator ID="RangeValidatorDateAvailable" runat="server"
                            ErrorMessage="Date must be between 01/01/2012 & 31/12/2012"
                            MinimumValue="01/01/2012" MaximumValue="31/12/2012" Display="Dynamic"
                            ValidationGroup="Registration"
                            ControlToValidate="txtDateAvailable" Type="Date"
                            ForeColor="Red">
                        </asp:RangeValidator>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3"
                            runat="server" Display="Dynamic" ControlToValidate="txtDateAvailable"
                            ErrorMessage="Date is required" ForeColor="Red" ValidationGroup="Registration"> </asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidatorDateofbirth"
                            runat="server" ErrorMessage="Date of application must be greater 
                            than 01/01/2012 Compare Validator"
                            ControlToValidate="txtDateAvailable"
                            ValidationGroup="Registration" ValueToCompare="01/01/2012"
                            Type="Date" Operator="GreaterThan" ForeColor="Red"
                            Display="Dynamic"
                            SetFocusOnError="true"></asp:CompareValidator>

                        &nbsp;
                    <asp:Button ID="Button13" runat="server" Text="Validate Button" ValidationGroup="Registration" OnClick="Button13_Click" />
                        &nbsp;
                        <asp:Button ID="btnClear" runat="server" OnClick="btnClear_Click"
                            CausesValidation="false" ValidationGroup="Registration" Text="Clear" />
                    </p>
                    <p>
                        &nbsp;
                    </p>
                    <i>here validator is used</i>
                    <asp:CustomValidator ID="CustomValidator1" runat="server" ErrorMessage="CustomValidator"></asp:CustomValidator>


                    <table style="font-family: Arial">
                        <tr>
                            <td colspan="2"><b>Employee Details Form</b></td>
                        </tr>
                        <tr>
                            <td>First Name: </td>
                            <td>
                                <asp:TextBox ID="TextBox2" runat="server" OnTextChanged="TextBox2_TextChanged" ToolTip="Enter first name" AutoPostBack="True"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Last Name: </td>
                            <td>
                                <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>City:</td>
                            <td>
                                <asp:DropDownList ID="ddlCity" runat="server" OnSelectedIndexChanged="ddlCity_SelectedIndexChanged">
                                </asp:DropDownList>
                            </td>
                            <td><i>Dropdownlist is a collection of listitmes</i></td>
                        </tr>
                        <tr>
                            <td></td>
                            <td>
                                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click"
                                    Text="Register Employee" />
                            </td>
                        </tr>
                    </table>


                    <fieldset style="width: 300px">
                        <legend><b>Gender</b></legend>

                        <asp:RadioButton ID="MaleRadioButton" Text="Male" runat="server" GroupName="GenderGroup" />
                        <asp:RadioButton ID="FemaleRadioButton" Text="Female" runat="server" AutoPostBack="True"
                            OnCheckedChanged="FemaleRadioButton_CheckedChanged" GroupName="GenderGroup" />
                        <asp:RadioButton ID="UnknownRadioButton" Text="Unknown" runat="server" GroupName="GenderGroup" />
                        <br />


                        <asp:Button ID="Button2" runat="server" Text="Button" OnClick="Button2_Click" />
                        <br />
                        <i>set the groupname property same to make it mutually exclusive </i>
                    </fieldset>


                </div>

            </div>
            <br />

            <div style="width: 400px; border: 2px solid blue;">
                <fieldset style="width: 350px">
                    <legend><b>Education</b></legend>
                    <asp:CheckBox ID="GraduateCheckBox" Text="Graduate" runat="server" Checked="true" OnCheckedChanged="GraduateCheckBox_CheckedChanged" AutoPostBack="True" />
                    <asp:CheckBox ID="PostGraduateCheckBox" Text="Post Graduate" runat="server" />
                    <asp:CheckBox ID="DoctrateCheckBox" Text="Doctrate" runat="server" />

                    <asp:Button ID="Button3" runat="server" Text="Button" OnClick="Button3_Click" />
                    <br />
                </fieldset>

                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="https://www.google.com/"
                    Text="Go to Google" Target="_blank"></asp:HyperLink>

                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl="https://www.google.com/"
                    Text="Go to Google" ImageHeight="50px" ImageUrl="~/Images/GoogleImage.jpg" ImageWidth="50px"></asp:HyperLink>
                <br />
                <i>the properties like navigate url can be defined on code behind too</i>

                <hr />
                <br />
                <asp:Button ID="Button4" runat="server" Text="Submit" OnClick="Button4_Click" />

                <asp:ImageButton ID="ImageButton1" runat="server" Height="50px"
                    ImageUrl="~/Images/SubmitButton.png" OnClick="ImageButton1_Click" Width="100px" OnClientClick="alert(&quot;submit button clicked&quot;)" />

                <asp:LinkButton ID="LinkButton1" Text="Submit" OnClientClick="LinkButonClientClick()" runat="server"
                    OnClick="LinkButton1_Click">LinkButton</asp:LinkButton>

                <br />
                <i>We use hyperlink to navigate to the a url, LinkButton post back to the same page</i>
                <br />
                <hr />
                <b>Navigation Controls</b>
                <br />
                <asp:HyperLink ID="HyperLink3" NavigateUrl="~/WebForm2.aspx" Text="Go to Webform2" runat="server">HyperLink</asp:HyperLink>

                Name<asp:TextBox ID="TextBoxName" MaxLength="10" runat="server"></asp:TextBox>
                Place<asp:TextBox ID="TextBoxPlace" MaxLength="10" runat="server"></asp:TextBox>

                <br />
                <asp:Button ID="Button14" runat="server" Text="Response Redirect" OnClick="Button14_Click" />
                <br />

                <asp:Button ID="Button15" runat="server" Text="Server.Transfer" OnClick="Button15_Click" />
                <asp:Button ID="Button16" runat="server" Text="Server.Execute"
                    OnClick="Button16_Click" />

                <br />
                <b>
                    <asp:Label ID="Label3" runat="server" ForeColor="Red"
                        Text="Label to check server execute"></asp:Label>
                </b>
                <asp:Button ID="btnCrossPagePostback" runat="server" Text="CrossPage Postback - WebForm2"
                    PostBackUrl="~/WebForm2.aspx" />
                <br />
                <asp:Button ID="Button17" runat="server" OnClientClick="OpenNewWindow();" Text="Open Using Js" />
                <asp:Button ID="Button18" runat="server" Text="Using Attributes" OnClick="Button18_Click" />
                <asp:Button ID="Button19" runat="server" Text="Using JS Response Write" OnClick="Button19_Click" />

                <br />
                <asp:Button ID="Button20" runat="server"
                    Text="ServerTransfer using Context Handler" OnClick="Button20_Click" />
                <asp:Button ID="Button21" runat="server"
                    Text="ResponseRedirect using Cookie and Session"
                    OnClick="Button21_Click" />


                <br />
                <asp:Label ID="lblCookieMessage" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
            </div>

            <div style="width: 400px; border: 1px solid black">

                <asp:Button ID="Button5" runat="server" Text="Command Events" OnClick="Button5_Click" OnCommand="Button5_Command" />
                <asp:Button ID="Button6" runat="server" Text="  Events" />
                <br />
                <i>The events can be added on code behind using deligates</i>

                <br />
                <br />
                <br />
                <asp:Button ID="PrintButton" runat="server" Text="Print" OnCommand="CommandButton_Click"
                    CommandName="Print" />
                <asp:Button ID="DeletButton" runat="server" Text="Delete" OnCommand="CommandButton_Click"
                    CommandName="Delete" />

                <asp:Button ID="Top10Button" runat="server" Text="Show Top 10 Employees"
                    OnCommand="CommandButton_Click"
                    CommandName="Show" CommandArgument="Top10" />

                <asp:Button ID="Bottom10Button" runat="server" Text="Show Bottom 10 Employees"
                    OnCommand="CommandButton_Click"
                    CommandName="Show" CommandArgument="Bottom10" />

                <asp:Label ID="OutputLabel" runat="server"></asp:Label>
                <br />
                <br />

                <div>
                    <asp:DropDownList ID="DropDownList1" runat="server">
                        <asp:ListItem Value="1" Text="Male"></asp:ListItem>
                        <asp:ListItem Value="2" Selected="True">Female</asp:ListItem>
                        <asp:ListItem Value="3  " Enabled="false">UnDisclosed</asp:ListItem>
                    </asp:DropDownList>


                    <asp:DropDownList ID="DropDownList2" runat="server"></asp:DropDownList>
                    <asp:DropDownList ID="DropDownList3" runat="server"></asp:DropDownList>


                    <h6>Used EF</h6>


                    <i>You can specify DataTextField and DataValueField eiher in Code behind or in aspx
                        
                    </i>
                    <br />
                    <asp:DropDownList ID="DropDownList4" runat="server"></asp:DropDownList>

                    <i>Using XML</i>
                    <hr />
                    <asp:DropDownList ID="ddlContinents" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlContinents_SelectedIndexChanged"></asp:DropDownList>
                    <asp:DropDownList ID="ddlCountries" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCountries_SelectedIndexChanged"></asp:DropDownList>
                    <asp:DropDownList ID="ddlCities" runat="server"></asp:DropDownList>
                    <hr />
                    <b>Exception Catching and writing to Event Viewer - ShashankCustom Event Log</b>
                    <br />
                    <asp:Button ID="Button22" runat="server" Text="Throw Exception and Email" OnClick="Button22_Click" />
                </div>
                <br />

                <asp:Button ID="Button23" runat="server" Text="Write Trace" OnClick="Button23_Click" />

                <hr />

                <b>Dynamic User Controls</b>

                <asp:PlaceHolder ID="PlaceHolder1" runat="server"></asp:PlaceHolder>
                <asp:Button ID="ButtonUserControl" runat="server" Text="Button" OnClick="ButtonUserControl_Click" />
                <asp:Panel ID="Panel1" runat="server"></asp:Panel>
                <br />
                <hr />
                <b>Loading Dynamic User Controls</b>
                <div>
                    <div>
                        <asp:DropDownList ID="DropDownList7" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList7_SelectedIndexChanged">
                            <asp:ListItem Text="Please Select" Value="-1"></asp:ListItem>
                            <asp:ListItem Text="Select City" Value="DDL"></asp:ListItem>
                            <asp:ListItem Text="Enter Post Code" Value="TB"></asp:ListItem>
                        </asp:DropDownList>
                        <br />
                        <asp:PlaceHolder ID="PlaceHolder2" runat="server"></asp:PlaceHolder>
                        <br />
                        <asp:Button ID="ButtonDUserControl" runat="server" Text="ButtonDynamicUserControl" OnClick="ButtonDUserControl_Click" />

                        <asp:PlaceHolder ID="PlaceHolder3" runat="server"></asp:PlaceHolder>

                    </div>



                </div>

                <br />

                <br />
                <br />


            </div>

            <div style="width: 350px; border: 2px dotted black">
                <i>Checkbox list to to represent multiple choices</i>
                <asp:CheckBoxList ID="checkboxListEducation" runat="server" AutoPostBack="True" OnSelectedIndexChanged="checkboxListEducation_SelectedIndexChanged">
                    <asp:ListItem Text="Diploma" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Graduate" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Post Graduate" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Doctrate" Value="4"></asp:ListItem>

                </asp:CheckBoxList>
                <asp:Button ID="Button7" runat="server" Text="Button" OnClick="Button7_Click" />
                <asp:Button ID="Button8" runat="server" Text="Select all" OnClick="Button8_Click" Style="margin-left: 21px" />
                <br />
                <br />
                <asp:ListBox ID="ListBox1" runat="server" SelectionMode="Single">

                    <asp:ListItem Text="Diploma" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Graduate" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Post Graduate" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Doctrate" Value="4"></asp:ListItem>

                </asp:ListBox>

                <asp:ListBox ID="ListBox2" runat="server" Rows="3" SelectionMode="Multiple" Style="margin-left: 17px"></asp:ListBox>
                <asp:Button ID="Button9" runat="server" Text="ListBox Button" OnClick="Button9_Click" Style="margin-left: 20px" />

                <br />
                <br />

                <asp:ListBox ID="ListBox3" runat="server" Style="margin-left: 18px" SelectionMode="Multiple"></asp:ListBox>
                <asp:Label ID="Label1" Font-Bold="true" runat="server" Text="Label"></asp:Label>
                <br />
                <hr />
                
                


                <br />

            </div>
        </div>




        <br />
        <div style="display: flex; float: left">
            <div style="width: 350px; border: 1px solid black;">
                <asp:RadioButtonList ID="ColorRadioButtonList" runat="server" RepeatDirection="Horizontal">
                    <asp:ListItem Text="Red" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Green" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Blue" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Orange" Value="4"></asp:ListItem>

                </asp:RadioButtonList>
                <asp:Button ID="Button10" runat="server" Text="Write" OnClick="Button10_Click" />
                <asp:Button ID="Button11" runat="server" Text="Clear" OnClick="Button11_Click" Style="margin-left: 22px" />


                <br />
                <asp:BulletedList ID="CountriesBulletedList" runat="server" BulletImageUrl="~/Images/bullet.jpg" FirstBulletNumber="10">
                    <asp:ListItem Text="India" Value="1"></asp:ListItem>
                    <asp:ListItem Text="US" Value="2"></asp:ListItem>
                    <asp:ListItem Text="UK" Value="3"></asp:ListItem>
                    <asp:ListItem Text="France" Value="4"></asp:ListItem>

                </asp:BulletedList>
                <asp:BulletedList ID="BulletedList2" runat="server"
                    DisplayMode="HyperLink">
                    <asp:ListItem Text="Google" Value="https://www.google.com/"></asp:ListItem>
                    <asp:ListItem Text="Microsoft" Value="https://www.microsoft.com/"></asp:ListItem>
                    <asp:ListItem Text="Dell" Value="https://www.dell.com/"></asp:ListItem>
                    <asp:ListItem Text="IBM" Value="https://www.ibm.com/"></asp:ListItem>
                </asp:BulletedList>

                <asp:BulletedList ID="BulletedList1" runat="server" DisplayMode="LinkButton" Target="_blank" OnClick="BulletedList1_Click">
                    <asp:ListItem Text="Google" Value="1"></asp:ListItem>
                    <asp:ListItem Text="Youtube" Value="2"></asp:ListItem>
                    <asp:ListItem Text="Blogger" Value="3"></asp:ListItem>
                    <asp:ListItem Text="Gmail" Value="4"></asp:ListItem>
                </asp:BulletedList>
            </div>

            <div style="width: 350px; border: 1px solid black;">
                <b>List Controls</b>
                <i>All controls are inherited from List control class, So all can be filled same way</i>

                <asp:DropDownList ID="DropDownList5" runat="server">
                    <asp:ListItem Text="Item1" Value="1"></asp:ListItem>
                </asp:DropDownList>
                <br />
                <asp:CheckBoxList ID="CheckBoxList1" runat="server">
                    <asp:ListItem Text="Item1" Value="1"></asp:ListItem>
                </asp:CheckBoxList>
                <br />
                <asp:RadioButtonList ID="RadioButtonList1" runat="server">
                    <asp:ListItem Text="Item1" Value="1"></asp:ListItem>
                </asp:RadioButtonList>
                <br />
                <asp:ListBox ID="ListBox4" SelectionMode="Multiple" runat="server">
                    <asp:ListItem Text="Item1" Value="1"></asp:ListItem>
                </asp:ListBox>
                <br />
                <asp:BulletedList ID="BulletedList3" runat="server">
                    <asp:ListItem Text="Item1" Value="1"></asp:ListItem>
                </asp:BulletedList>

                <br />
                <asp:Button ID="Button12" runat="server" Text="Selected item Text" OnClick="Button12_Click" />
            </div>

            <div style="width: 350px; border: 1px solid black;">
                <asp:FileUpload ID="FileUpload1" Text="Upload" runat="server" />
                <asp:Button ID="btnUpload" runat="server" Text="UploadFile" OnClick="btnUpload_Click" />
                <br />
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
                <br />
                <hr />
                <b>Ad rotator Control</b>
                <asp:AdRotator ID="AdRotator1" runat="server" AdvertisementFile="~/AdsData.xml" BorderStyle="Dashed" Height="200px" KeywordFilter="Google" Target="_blank" Width="350px" />
                <br />
                <asp:TextBox ID="TextBox4" runat="server" Width="115px"></asp:TextBox>
                <asp:ImageButton ID="ImageButton2" runat="server"
                    ImageUrl="~/Images/Calender.jpg" OnClick="ImageButton2_Click" Height="26px" Style="margin-left: 1px" Width="26px" />
                <br />


                <asp:Calendar ID="Calendar1" runat="server" OnDayRender="Calendar1_DayRender"
                    OnSelectionChanged="Calendar1_SelectionChanged" BackColor="#FFCC99" BorderColor="Red" BorderStyle="Double" BorderWidth="2px" Caption="Select the date" CaptionAlign="Top" ForeColor="#6600FF" NextMonthText="&gt;&gt;" NextPrevFormat="ShortMonth" PrevMonthText="&lt;&lt;">
                    <DayHeaderStyle BackColor="#FF0066" BorderColor="Yellow" ForeColor="Black" />
                    <DayStyle BorderColor="#663300" />
                    <OtherMonthDayStyle ForeColor="#669999" />
                </asp:Calendar>







                <asp:Calendar ID="Calendar2" runat="server" OnDayRender="Calendar2_DayRender"
                    OnSelectionChanged="Calendar2_SelectionChanged" BackColor="#FFCC99" BorderColor="Red" BorderStyle="Double" BorderWidth="2px" Caption="Select the date" CaptionAlign="Top" ForeColor="#6600FF" NextMonthText="&gt;&gt;" NextPrevFormat="ShortMonth" PrevMonthText="&lt;&lt;" SelectionMode="DayWeekMonth" OnVisibleMonthChanged="Calendar2_VisibleMonthChanged">
                    <DayHeaderStyle BackColor="#FF0066" BorderColor="Yellow" ForeColor="Black" />
                    <DayStyle BorderColor="#663300" />
                    <OtherMonthDayStyle ForeColor="#669999" />
                </asp:Calendar>


            </div>
        </div>

    </form>
</body>
</html>
