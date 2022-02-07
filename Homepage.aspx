<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Homepage.aspx.cs" Inherits="PracticalAssignment.Homepage" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <fieldset>
                <legend>User Profile<br />
            </legend>
            &nbsp;<table class="auto-style1">
                
                <tr>
                    <td class="auto-style2">User ID:</td>
                    <td>
                        <asp:Label Text="string" runat="server" ID="lbl_userID" /></td>
                </tr>
                <tr>
                    <td class="auto-style2">Credit Card Info:</td>
                    <td>
                        <asp:Label Text="string" runat="server" ID="lbl_creditcard" /></td>
                </tr>
            </table>

                <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="LogoutMe" Visible="false" />
                <p></p>

            </fieldset>
        </div>
    </form>
</body>
</html>
