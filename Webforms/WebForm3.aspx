<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm3.aspx.cs"
    Inherits="Webforms.WebForm3" %>
<%@ Register src="UserControls/EmployeeControl.ascx" tagname="EmployeeControl" tagprefix="uc1" %>
<%@ OutputCache Duration="60"   VaryByParam="DropDownList3" %>
<%@ Register Assembly="CustomControls, Version=1.0.0.0, Culture=neutral,
    PublicKeyToken=08c5748ed67199fd"
    Namespace="CustomControls" TagPrefix="cc1" %>

<%@ Register Src="~/UserControls/CalendarUserControl.ascx" TagPrefix="uc2" TagName="CalendarUserControl" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <i>We use EventHandler deligate (Delegates ) to hook up Click event with click event handler</i>
            <i>Events are variables of type delgates with an event keyword</i>
        </div>
        <uc2:CalendarUserControl runat="server" SelectedDate="01/01/2013" ID="CalendarUserControl" />
        <%-- OnCalendarVisibilityChanged="CalendarUserControl_CalendarVisibilityChanged"--%>

        <asp:Button ID="ButtonUserctrl" runat="server" Text="Button" 
            OnClick="ButtonUserctrl_Click" />

        <hr />
        <b>DropDown with Year and Month Dropdown</b>
        <fieldset style="font-family: Arial">
            Year :
    <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True"
        OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged">
    </asp:DropDownList>&nbsp;
    Month:
    <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True"
        OnSelectedIndexChanged="DropDownList2_SelectedIndexChanged">
    </asp:DropDownList>
            <br />
            <asp:Calendar ID="Calendar2" runat="server"></asp:Calendar>
            <asp:Button ID="Button2" runat="server" OnClick="Button2_Click"
                Text="Get Selected Date" />
        </fieldset>
        <br />
        <b>Custom ServerControl<br />
            <i>Deployed in GAC</i>
            <br />
            <br />
            <cc1:CustomCalendar ID="CustomCalendar1" runat="server" ImageButtonImageUrl="Images/Calender.jpg" OnDateSelected="CustomCalendar1_DateSelected" />
            <br />
        </b>
        &nbsp;<asp:Button ID="ButtonCustomServerControl" runat="server" Text="ButtonCustomServerControl" OnClick="ButtonCustomServerControl_Click" />
        <br />
        <hr />
        <div style="display: flex; float: left">
            <div style="width:350px;">
             <h2>Cacheing</h2>
                <asp:GridView ID="GridViewEmployee" runat="server"></asp:GridView>
                <br />
                Server Time<asp:Label ID="Label1" runat="server"></asp:Label>
                <br />
                Client Time
                <script>
                    document.write(Date());
                </script>

            </div>

            <div style="font-family: Arial;width:350px;">
                Select Gender: 
    <asp:DropDownList ID="DropDownList3" AutoPostBack="true" runat="server"
        OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged"
        Style="height: 25px" DataTextField="Gender" DataValueField="Gender">
        <asp:ListItem Text="All" Value="All"></asp:ListItem>
        <asp:ListItem Text="Male" Value="Male"></asp:ListItem>
        <asp:ListItem Text="Female" Value="Female"></asp:ListItem>
    </asp:DropDownList>
                <br />
                <asp:GridView ID="GridView1" runat="server">
                </asp:GridView>
                <br />
                Server Time: 
    <asp:Label ID="Label2" runat="server"></asp:Label>
                <br />
                Client Time:
    <script type="text/javascript">
        document.write(Date());
    </script>
            </div>

            <div style="width:350px;">
                <i>User Control Cache Shared</i>

                <uc1:EmployeeControl ID="EmployeeControl1" runat="server" />
                Page Server Time:
                    <asp:Label ID="Label3" runat="server" ></asp:Label>
                <br />
                Page Client Time:
                    <script type="text/javascript">
                        document.write(Date());
                    </script>

            </div>

            <div style="width:350px;">
                <i>Caching multiple responses of a user control declaratively, 
                    using "VaryByControl" attribute of the "OutputCache" directive
                    OutputCache Duration="60" VaryByControl="DropDownList1" 
                    or [PartialCaching(60, VaryByControls = "DropDownList1")]

                </i>
            </div>

        </div>

    </form>

</body>
</html>
