<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="PracticalAssignment.Registration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Registration</title>

    <script src="https://www.google.com/recaptcha/api.js?render=6Lf-q2EeAAAAAGIuVHMf9zwRCDKqcgdxMX3WIJyo"></script>
    <script type="text/javascript">
        function validate_password() {
            var password = document.getElementById('<%=tb_password.ClientID %>').value;
            if (password.length < 12) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password length must be at least 12 characters";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("too_short");
            }
            else if (password.search(/[0-9]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least 1 number";
                document.getElementById("lbl_pwdchecker").style.color = "Red";
                return ("no_short");
            }
            else if (password.search(/[^ a - zA - Z0 - 9]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least a special character"
                document.getElementById(lbl_pwdchecker).style.color = "Red";
                return ("no_short");
            }
            else if (password.search(/[A-Z]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least a uppercase letter"
                document.getElementById(lbl_pwdchecker).style.color = "Red";
                return ("no_short");
            }
            else if (password.search(/[a-z]/) == -1) {
                document.getElementById("lbl_pwdchecker").innerHTML = "Password require at least a lowercase letter"
                document.getElementById(lbl_pwdchecker).style.color = "Red";
                return ("no_short");
            }
            else {
                document.getElementById("lbl_pwdchecker").innerHTML = "Excellent!"
                document.getElementById("lbl_pwdchecker").style.color = "Blue";
                return ("no_short");
            }
            
        }
    </script>

    <style type="text/css">
        .auto-style1 {
            width: 100%;
            height: 56px;
        }
        .auto-style2 {
            width: 151px;
        }
        .auto-style3 {
            width: 151px;
            height: 23px;
        }
        .auto-style4 {
            height: 23px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            Registration<br />
            <table class="auto-style1">
                <tr>
                    <td class="auto-style3">First Name</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="tb_firstname" runat="server" Width="200px"></asp:TextBox>
                        <asp:Label ID="lbl_firstnamechecker" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Last Name</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="tb_lastname" runat="server" Width="200px"></asp:TextBox>
                        <asp:Label ID="lastnamechecker" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Credit Card Info</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="tb_creditcard" runat="server" Width="200px"></asp:TextBox>
                        <asp:Label ID="lbl_cardchecker" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Email Address</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="tb_email" runat="server" Width="200px"></asp:TextBox>
                        <asp:Label ID="lbl_emailchecker" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style3">Password</td>
                    <td class="auto-style4">
                        <asp:TextBox ID="tb_password" runat="server" Width="200px" onkeyup="javascript:validate_password()" TextMode="Password"></asp:TextBox>
                        <asp:Label ID="lbl_pwdchecker" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Date of Birth</td>
                    <td>
                        <asp:TextBox ID="tb_dateofbirth" runat="server" Width="200px"></asp:TextBox>
                        <asp:Label ID="lbl_datechecker" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2">Photo</td>
                    <td>
                        <asp:FileUpload ID="photo" runat="server" />
                    </td>
                </tr>
            </table>
        </div>
        <asp:Button ID="SubmitButton" runat="server" OnClick="Button1_Click" Text="Submit" Width="486px" />
        <br />
        <asp:Label ID="lbl_gScore" runat="server"></asp:Label>
        <asp:Label ID="lbl_error1" runat="server"></asp:Label>
        <input type="hidden" id="g-recaptcha-response" name="g-recaptcha-response"/>
    </form>
    <script>
        grecaptcha.ready(function () {
            grecaptcha.execute('6Lf-q2EeAAAAAGIuVHMf9zwRCDKqcgdxMX3WIJyo', { action: 'Login' }).then(function (token) {
                document.getElementById("g-recaptcha-response").value = token;
            });
        });
    </script>
</body>
</html>
