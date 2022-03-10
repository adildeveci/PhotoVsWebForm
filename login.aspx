<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   <title>Photo VS</title>
<meta name="description" content="Fotoğraflarınızı karşılaştırın. Hangi fotoğrafın daha iyi olduğunu öğrenin."/>
<meta name="keywords" content="photo, vs, photovs, giris, login"/>
<meta name="author" content="photo vs"/>
 <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />  

    <link href="css/normalize.css" rel="stylesheet" />
    <link href="css/login.css" rel="stylesheet" />
    
    </head>
<body>
    <form id="form1" runat="server">
         
    
 
         
        <table class="girisForm">
            <tr style="background-color:blue; text-align:center">
                <td colspan="3">
                     <asp:Label Text="Photo VS" runat="server"  Font-Bold="True" Font-Names="Impact" Font-Size="XX-Large" ForeColor="Red" />

                </td>
            </tr>
            <tr>
                <td class="loginSagSolBlock">Email</td>
                <td>
                    <asp:TextBox ID="txEmail" placeholder="Kullanıcı Adı veya Email" runat="server" Width="100%"></asp:TextBox>
                </td>
                <td class="loginSagSolBlock">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="txEmail"  ValidationGroup="login" ForeColor="Red"></asp:RequiredFieldValidator>
               <%--     <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txEmail" ValidationGroup="login" ErrorMessage="!" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>--%>
                </td>
            </tr>
            <tr>
                <td class="loginSagSolBlock">Şifre</td>
                <td>
                    <asp:TextBox ID="txSifre" runat="server" Width="100%" TextMode="Password"></asp:TextBox>
                </td>
                <td class="loginSagSolBlock">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txSifre" ErrorMessage="!" ForeColor="Red" ValidationGroup="login"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="loginSagSolBlock">
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnLogin" runat="server" Width="100%" Height="40px" Text="Giriş" OnClick="btnLogin_Click" ValidationGroup="login" />
                </td>
                <td class="loginSagSolBlock"></td>
            </tr>
            <tr>
                <td class="loginSagSolBlock">
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnSignup" runat="server" Width="100%" Height="40px" Text="Üye Ol" OnClick="btnSignup_Click" />
                </td>
                 <td class="loginSagSolBlock"></td>
            </tr>
            <tr >
                <td>
                    &nbsp;</td>
                <td>
                    <asp:Label ID="lblMesaj" runat="server" ForeColor="Red" ></asp:Label>
                </td>
                <td class="loginSagSolBlock"></td>
            </tr>
            <tr>
                <td colspan="3">
               <center>   <img src="images/photovs.png" width="100%" style="max-width:400px" /></center></td>
            </tr>
        </table>

         
    </form>
</body>
</html>
