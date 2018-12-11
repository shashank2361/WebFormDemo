<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="EmployeeControl.ascx.cs" Inherits="Webforms.UserControls.EmployeeControl" %>
<%@ OutputCache Duration="60" VaryByParam="None" Shared="true" %>

<table style="border: 1px solid black">
    <tr>
        <td style="background-color: Gray; font-size: 12pt">Employee User Control
        </td>
    </tr>
    <tr>
        <td>
            <asp:GridView ID="GridView1" runat="server"></asp:GridView>
        </td>
    </tr>
    <tr>
        <td>
            <b>User Control Server Time:
                <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            </b>
        </td>
    </tr>
    <tr>
        <td>
            <b>User Control Client Time:
                <script type="text/javascript">
                    document.write(Date());
                </script>
            </b>
        </td>
    </tr>
</table>


