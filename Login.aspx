<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PracticalAssignment.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="https://www.google.com/recaptcha/api.js?render=6Lf-q2EeAAAAAGIuVHMf9zwRCDKqcgdxMX3WIJyo"></script>
    <style type="text/css">
        .auto-style1 {
            height: 267px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <fieldset class="auto-style1">
                 <legend>Login</legend>
                <p>Username: 
                    <asp:TextBox ID="tb_userid" runat="server"></asp:TextBox>
                 </p>
           
                 <p>Password:
                    <asp:TextBox ID="tb_pwd" runat="server"></asp:TextBox>
                 </p>
         
                 <asp:Label ID="lbl_gScore" runat="server"></asp:Label>
                <br />
                <br />

            <asp:Button ID="btn_login" runat="server" OnClick="LoginMe" Text="Login" />
                 <br />
            <asp:Label ID="lblMessage" runat="server"></asp:Label>


            </fieldset>
        </div>
        <p>
            &nbsp;</p>
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
