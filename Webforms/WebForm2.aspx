<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" 
   Trace="false" Inherits  ="Webforms.WebForm2" %>
 

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>


    <form id="form1" runat="server">
        <div style="display: inline-flex">

            <div style="border: 1px dotted black">
                <div>
                    <b>Update using ADO.net</b>
                    <table>
                        <tr>
                            <td>First Name:</td>
                            <td>
                                <asp:HiddenField ID="HiddenField1" runat="server" />

                                <asp:TextBox ID="txtFirstName" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Last Name:</td>
                            <td>
                                <asp:TextBox ID="txtLastName" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Gender:</td>
                            <td>
                                <asp:TextBox ID="txtGender" runat="server"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>Salary:</td>
                            <td>
                                <asp:TextBox ID="txtSalary" runat="server"
                                    oncopy="return false"
                                    onpaste="return false"
                                    oncut="return false" onkeydown="return (!((event.keyCode>=65 && event.keyCode <= 95) || event.keyCode >= 106 || (event.keyCode >= 48 && event.keyCode <= 57 && isNaN(event.key))) && event.keyCode!=32);"></asp:TextBox>

                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1"
                                    ControlToValidate="txtSalary" runat="server"
                                    ErrorMessage="Only Numbers allowed"
                                    ValidationExpression="\d+">
                                </asp:RegularExpressionValidator>
                            </td>
                        </tr>
                    </table>



                    <asp:Button ID="Button1" runat="server" Text="Update Employee"
                        OnClick="Button1_Click" />&nbsp;
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click"
                    Text="Load Employee" />



                </div>
                <div>
                    <b>Multiview Control</b>
                    <div style="font-family: Arial">
                        <asp:MultiView ID="multiViewEmployee" runat="server">
                            <asp:View ID="viewPersonalDetails" runat="server">
                                <table style="border: 1px solid black">
                                    <tr>
                                        <td colspan="2">
                                            <h2>Step 1 - Personal Details</h2>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>First Name</td>
                                        <td>
                                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Last Name</td>
                                        <td>
                                            <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Gender</td>
                                        <td>
                                            <asp:DropDownList ID="ddlGender" runat="server">
                                                <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
                                                <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
                                            </asp:DropDownList>
                                            <asp:HiddenField ID="HiddenField2" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align: right">
                                            <asp:Button ID="btnGoToStep2" runat="server"
                                                Text="Step 2 >>" OnClick="btnGoToStep2_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="viewSalaryDetails" runat="server">
                                <table style="border: 1px solid black">
                                    <tr>
                                        <td colspan="2">
                                            <h2>Step 2 - Salary Details</h2>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Salary </td>
                                        <td>
                                            <asp:TextBox ID="txtSal" runat="server"></asp:TextBox>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>
                                            <asp:Button ID="btnBackToStep1" runat="server" Text="<< Step 1"
                                                OnClick="btnBackToStep1_Click" />
                                        </td>
                                        <td style="text-align: right">
                                            <asp:Button ID="btnGoToStep3" runat="server" Text="Step 3 >>"
                                                OnClick="btnGoToStep3_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="viewSummary" runat="server">
                                <table style="border: 1px solid black">
                                    <tr>
                                        <td colspan="2">
                                            <h2>Step 3 - Summary</h2>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <h3>Personal Details</h3>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>First Name</td>
                                        <td>:<asp:Label ID="lblFirstName" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Last Name</td>
                                        <td>:<asp:Label ID="lblLastName" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Gender</td>
                                        <td>:<asp:Label ID="lblGender" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <h3>Salary Details</h3>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Salary</td>
                                        <td>:<asp:Label ID="lblSal" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Button ID="Button3" runat="server" Text="<< Step 2"
                                                OnClick="Button3_Click" />
                                        </td>
                                        <td style="text-align: right">
                                            <asp:Button ID="Button4" runat="server" Text="Submit >>"
                                                OnClick="Button4_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </asp:View>
                        </asp:MultiView>
                    </div>

                </div>
                <div>
                    <asp:Wizard ID="Wizard1" runat="server"
                        StepNextButtonText=" Next >> "
                        StepPreviousButtonText=" << Previous "
                        OnActiveStepChanged="Wizard1_ActiveStepChanged"
                        OnFinishButtonClick="Wizard1_FinishButtonClick"
                        OnNextButtonClick="Wizard1_NextButtonClick"
                        OnPreviousButtonClick="Wizard1_PreviousButtonClick"
                        OnSideBarButtonClick="Wizard1_SideBarButtonClick"
                        DisplayCancelButton="True"
                        OnCancelButtonClick="Wizard1_CancelButtonClick" OnPreRender="Wizard1_PreRender" BackColor="#F7F6F3" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" Height="104px" Width="280px">

                        <FinishNavigationTemplate>
                            <asp:Button ID="FinishPreviousButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="MovePrevious" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" Text="Previous" />
                            <asp:Button ID="FinishButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" CommandName="MoveComplete" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" Text="Finish" />
                            <asp:Button ID="CancelButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="Cancel" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" Text="Cancel" />
                        </FinishNavigationTemplate>
                        <HeaderStyle BackColor="#5D7B9D" BorderStyle="Solid" Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Left" />
                        <NavigationButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
                        <SideBarButtonStyle BorderWidth="0px" Font-Names="Verdana" ForeColor="White" />

                        <SideBarStyle VerticalAlign="Top" BackColor="#7C6F57" BorderWidth="0px" Font-Size="0.9em" />

                        <StartNavigationTemplate>
                            <asp:Button ID="StartNextButton" runat="server" BackColor="#FFFBFF"
                                BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px"
                                CommandName="MoveNext" Font-Names="Verdana" Font-Size="0.8em"
                                ForeColor="#284775" Text="Next"
                                OnClientClick="return confirm('Are you sure you want to go to next step');" />

                            <asp:Button ID="CancelButton" runat="server" BackColor="#FFFBFF"
                                BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px"
                                CausesValidation="False" CommandName="Cancel" Font-Names="Verdana"
                                Font-Size="0.8em" ForeColor="#284775" Text="Cancel" />
                        </StartNavigationTemplate>
                        <StepNavigationTemplate>
                            <asp:Button ID="StepPreviousButton" runat="server" UseSubmitBehavior="false" BackColor="#FFFBFF" BorderColor="#CCCCCC"
                                BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="MovePrevious"
                                Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" Text=" &lt;&lt; Previous " />
                            <asp:Button ID="StepNextButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC"
                                BorderStyle="Solid" BorderWidth="1px" CommandName="MoveNext" Font-Names="Verdana"
                                Font-Size="0.8em" ForeColor="#284775" Text=" Next &gt;&gt; " />
                            <asp:Button ID="CancelButton" runat="server" BackColor="#FFFBFF" BorderColor="#CCCCCC"
                                BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="Cancel"
                                Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" Text="Cancel" />
                        </StepNavigationTemplate>
                        <StepStyle BorderWidth="0px" ForeColor="#5D7B9D" />

                        <WizardSteps>
                            <asp:WizardStep runat="server" Title="Step 1">
                                <asp:CheckBox ID="chkBoxCancel" Text="Cancel Navigation" runat="server" />
                                <asp:TextBox ID="Step1TextBox" runat="server"></asp:TextBox>
                            </asp:WizardStep>
                            <asp:WizardStep runat="server" Title="Step 2">
                                <asp:TextBox ID="Step2TextBox" runat="server"></asp:TextBox>
                            </asp:WizardStep>
                            <asp:WizardStep runat="server" Title="Step 3">
                                <asp:TextBox ID="Step3TextBox" runat="server"></asp:TextBox>
                            </asp:WizardStep>
                        </WizardSteps>
                    </asp:Wizard>
                </div>
                <div>
                    <asp:Wizard ID="Wizard2" runat="server" ActiveStepIndex="0" BackColor="#FFFBD6" BorderColor="#FFDFAD" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" Height="210px" OnNextButtonClick="Wizard2_NextButtonClick" Width="496px">
                        <HeaderStyle BackColor="#FFCC66" BorderColor="#FFFBD6" BorderStyle="Solid" BorderWidth="2px" Font-Bold="True" Font-Size="0.9em" ForeColor="#333333" HorizontalAlign="Center" />
                        <NavigationButtonStyle BackColor="White" BorderColor="#CC9966" BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#990000" />
                        <SideBarButtonStyle ForeColor="White" />
                        <SideBarStyle BackColor="#990000" Font-Size="0.9em" VerticalAlign="Top" />
                        <WizardSteps>
                            <asp:WizardStep ID="WizardStep1" runat="server" Title="Employee Details">
                                <table style="width: 100%;">
                                    <tr>
                                        <td><strong>Employee Details</strong></td>

                                    </tr>
                                    <tr>
                                        <td>Employee FirstName</td>
                                        <td>
                                            <asp:TextBox ID="TextBox3" runat="server"></asp:TextBox></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Employee LastName</td>
                                        <td>
                                            <asp:TextBox ID="TextBox4" runat="server"></asp:TextBox></td>
                                        <td></td>
                                    </tr>
                                </table>


                            </asp:WizardStep>
                            <asp:WizardStep ID="WizardStep2" runat="server" Title="Employee Course Details">
                                <table style="width: 100%;">
                                    <tr>
                                        <td><strong>Employee Course Detail</strong></td>

                                    </tr>
                                    <tr>
                                        <td>Employee Course</td>
                                        <td>
                                            <asp:TextBox ID="TextBox5" runat="server"></asp:TextBox></td>

                                    </tr>
                                    <tr>
                                        <td>Employee Branch</td>
                                        <td>
                                            <asp:TextBox ID="TextBox6" runat="server"></asp:TextBox></td>

                                    </tr>
                                </table>

                            </asp:WizardStep>
                            <asp:WizardStep ID="WizardStep3" runat="server" Title="Employee Personal Details">
                                <table style="width: 100%;">
                                    <tr>
                                        <td><strong>Employee Personal Detail</strong></td>

                                    </tr>
                                    <tr>
                                        <td>Employee EmailId</td>
                                        <td>
                                            <asp:TextBox ID="TextBox7" runat="server"></asp:TextBox></td>

                                    </tr>
                                    <tr>
                                        <td>Employee City</td>
                                        <td>
                                            <asp:TextBox ID="TextBox8" runat="server"></asp:TextBox></td>

                                    </tr>
                                    <tr>
                                        <td>Employee State</td>
                                        <td>
                                            <asp:TextBox ID="TextBox9" runat="server"></asp:TextBox></td>

                                    </tr>
                                </table>

                            </asp:WizardStep>

                            <asp:WizardStep ID="WizardStep4" runat="server" Title="Employee Summary">

                                <table class="auto-style1">
                                    <tr>
                                        <td><strong>Employee Details</strong></td>

                                        <td></td>

                                    </tr>
                                    <tr>
                                        <td>Employee FirstName:</td>
                                        <td>
                                            <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                                        </td>
                                        <td></td>

                                    </tr>
                                    <tr>
                                        <td>Employee LastName:</td>

                                        <td>
                                            <asp:Label ID="Label2" runat="server" Text=""></asp:Label>
                                        </td>

                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Employee Course Details</strong></td>
                                        <td></td>
                                    </tr>

                                    <tr>
                                        <td>Employee Course:</td>
                                        <td>
                                            <asp:Label ID="Label3" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Employee Branch:</td>
                                        <td>
                                            <asp:Label ID="Label4" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td><strong>Employee Personal Details</strong></td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>Employee EmailId:</td>
                                        <td>
                                            <asp:Label ID="Label5" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Employee City:</td>
                                        <td>
                                            <asp:Label ID="Label6" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Employee State:</td>
                                        <td>
                                            <asp:Label ID="Label7" runat="server" Text=""></asp:Label>
                                        </td>
                                    </tr>

                                </table>
                            </asp:WizardStep>


                        </WizardSteps>

                    </asp:Wizard>
                </div>
                <div>
                    <asp:Label ID="Label8" runat="server" Text="Label">
            <%=Server.HtmlEncode("<script>alert('Literal Text');</script>") %>
                    </asp:Label>
                    <br />
                    <asp:Literal ID="Literal1" Mode="Encode" Text="<script>alert('Literal Text');</script>" runat="server"></asp:Literal>

                </div>
            </div>

            <div style="border:1px solid gray">
                <div>
                    <b>Values form Previous Page</b>
                    <br />
                    <asp:Label ID="Label9" runat="server"  ></asp:Label>
                    <asp:Label ID="Label10" runat="server" ></asp:Label>
                    <br />
                    <asp:Label ID="Label11" runat="server" ></asp:Label>
                    <asp:Label ID="Label12" runat="server" ></asp:Label>
                    <asp:Label ID="lblStatus" runat="server" ></asp:Label>
                    <br />
                    <i>Data retrieve using query string</i>
                    <asp:Label ID="Label13" runat="server" ForeColor="Blue"></asp:Label>
                    <asp:Label ID="Label14" runat="server" ForeColor="Blue"></asp:Label>
                    <br />
                    <i>Server transfer using Context Handler</i>
                    <asp:Label ID="Label15" runat="server" ></asp:Label>
                    <asp:Label ID="Label16" runat="server" ></asp:Label>
                    <br />
                    <i>DataTransfer using Cookies</i>
                    <asp:Label ID="Label17" runat="server" ></asp:Label>
                    <asp:Label ID="Label18" runat="server" ></asp:Label>
                    <br />
                    <i>Data transfer Session</i>
                    <asp:Label ID="Label19" runat="server" ></asp:Label>
                    <asp:Label ID="Label20" runat="server" ></asp:Label>

                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    
                    <hr />
                    <h3>Panel Control</h3>
                    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true"
                        OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
                        <asp:ListItem Text="Select User" Value="-1"></asp:ListItem>
                        <asp:ListItem Text="Admin" Value="Admin"></asp:ListItem>
                        <asp:ListItem Text="Non-Admin" Value="Non-Admin"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:Panel ID="AdminPanel" runat="server">
                        <table>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="AdminGreeting" runat="server" Font-Size="XX-Large"
                                        Text="You are logged in as an administrator">
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="AdminNameLabel" runat="server" Text="Admin Name:">
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="AdminNameTextBox" runat="server" Text="Tom">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="AdminRegionLabel" runat="server" Text="Admin Region:">
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="AdminRegionTextBox" runat="server" Text="Asia">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="AdminActionsLabel" runat="server" Text="Actions:">
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="AdminActionsTextBox" runat="server" Font-Size="Medium" TextMode="MultiLine"
                                        Text="There are 4 user queries to be answered by the end of Dcemeber 25th 2013."
                                        Font-Bold="True"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                    <asp:Panel ID="NonAdminPanel" runat="server">
                        <table>
                            <tr>
                                <td colspan="2">
                                    <asp:Label ID="NonAdminGreeting" runat="server" Font-Size="XX-Large"
                                        Text="Welcome Tom!">
                                    </asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="NonAdminNameLabel" runat="server" Text="User Name:">
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="NonAdminNameTextBox" runat="server" Text="Mike">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="NonAdminRegionLabel" runat="server" Text="User Region:">
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="NonAdminRegionTextBox" runat="server" Text="United Kingdom">
                                    </asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="NonAdminCityLabel" runat="server" Text="City:">
                                    </asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="NonAdminCityTextBox" runat="server" Text="London">
                                    </asp:TextBox>
                                </td>
                            </tr>
                        </table>

                    </asp:Panel>
                    <hr />
                </div>
                <br />
                <div style="font-family: Arial">
                    <table>
                        <tr>
                            <td><b>Control Type</b></td>
                            <td>
                                <asp:CheckBoxList ID="chkBoxListControlType" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem Text="Label" Value="Label"></asp:ListItem>
                                    <asp:ListItem Text="TextBox" Value="TextBox"></asp:ListItem>
                                    <asp:ListItem Text="Button" Value="Button"></asp:ListItem>
                                </asp:CheckBoxList>
                            </td>
                            <td><b>How Many</b></td>
                            <td>
                                <asp:TextBox ID="txtControlsCount" runat="server" Width="40px"></asp:TextBox>
                            </td>
                            <td>
                                <asp:Button ID="btnGenerateControl" runat="server" Text="Generate Controls"
                                    OnClick="btnGenerateControl_Click" />
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <h3>Label Controls</h3>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" id="tdLabels" runat="server">
                                <asp:Panel ID="pnlLabels" runat="server">
                                </asp:Panel>
                                <asp:PlaceHolder ID="phLabels" runat="server"></asp:PlaceHolder>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <h3>TextBox Controls</h3>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" id="tdTextBoxes" runat="server">
                                <asp:Panel ID="pnlTextBoxes" runat="server">
                                </asp:Panel>
                                <asp:PlaceHolder ID="phTextBoxes" runat="server"></asp:PlaceHolder>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5">
                                <h3>Button Controls</h3>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="5" id="tdButtons" runat="server">
                                <asp:Panel ID="pnlButtons" runat="server">
                                </asp:Panel>
                                <asp:PlaceHolder ID="phButtons" runat="server"></asp:PlaceHolder>
                            </td>
                        </tr>
                    </table>
                </div>

            </div>



        </div>
    <p>
        &nbsp;
    </p>
    <p>
        &nbsp;
         
    </p>


    </form>
    

</body>
</html>
