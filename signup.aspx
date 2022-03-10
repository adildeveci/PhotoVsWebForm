<%@ Page Language="C#" AutoEventWireup="true" CodeFile="signup.aspx.cs" Inherits="signup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Photo VS</title>
<meta name="description" content="Fotoğraflarınızı karşılaştırın. Hangi fotoğrafın daha iyi olduğunu öğrenin."/>
<meta name="keywords" content="photo, vs, photovsi, kayit, signup"/>
<meta name="author" content="photo vs"/>
 <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />  

    <link href="css/normalize.css" rel="stylesheet" />
    <link href="css/signup.css" rel="stylesheet" />
     
</head>
<body>
    <form id="form1" runat="server"> 
        <table class="girisForm">
            <tr style="background-color:blue; text-align:center">
                <td colspan="3">
                     <asp:Label ID="Label1" Text="Photo VS" runat="server"  Font-Bold="True" Font-Names="Impact" Font-Size="XX-Large" ForeColor="Red" />

                </td>
            </tr>
            <tr>
                <td class="loginSolBlock">Kullanıcı Adı</td>
                <td>
                    <asp:TextBox ID="txKullaniciAdi" runat="server" Width="100%"></asp:TextBox>
                </td>
                <td class="loginSagBlock">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txKullaniciAdi" ErrorMessage="*" ValidationGroup="Kayit"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="loginSolBlock">Email</td>
                <td>
                    <asp:TextBox ID="txEmail" runat="server" Width="100%"></asp:TextBox>
                </td>
                <td class="loginSagBlock">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txEmail" ValidationGroup="Kayit"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txEmail" ErrorMessage="!" ValidationGroup="Kayit" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </td> 
            </tr>
            <tr>
                <td class="auto-style1">Şifre</td>
                <td class="auto-style2">
                    <asp:TextBox ID="txSifre1" runat="server" Width="100%" TextMode="Password"></asp:TextBox>
                </td>
                <td class="auto-style1">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="txSifre1" ValidationGroup="Kayit"></asp:RequiredFieldValidator>
                </td>
            </tr>
             <tr>
                <td class="loginSolBlock">Şifre Doğrula</td>
                <td>
                    <asp:TextBox ID="txSifre2" runat="server" Width="100%" TextMode="Password"></asp:TextBox>
                </td>
                <td class="loginSagBlock">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="*" ControlToValidate="txSifre1" ValidationGroup="Kayit"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txSifre1" ControlToValidate="txSifre2" ErrorMessage="Uyuşmadı" ValidationGroup="Kayit"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td class="loginSolBlock">
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnKayitOl" runat="server" Width="100%" Height="40px" Text="Kayıt Ol" ValidationGroup="Kayit" OnClick="btnKayitOl_Click" />
                </td>
                <td class="loginSagBlock">
                </td>
            </tr>
            <tr>
                <td class="loginSolBlock">
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnLogin" runat="server" Width="100%" Height="40px" Text="Hesabım Var..." OnClick="btnLogin_Click" />
                </td>
                 <td class="loginSagBlock">
                </td>
            </tr>
            <tr >
                <td>
                    &nbsp;</td>
                <td>
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" ></asp:Label>
                </td>
                <td class="loginSagBlock">
                </td>
            </tr>
             
        </table>

    </form>
</body>
</html>
