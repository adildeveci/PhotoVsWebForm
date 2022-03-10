<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="hesapAyarlari.aspx.cs" Inherits="hesapAyarlari" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/hesapAyarlari.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="hesapAyarlariContent">
        <table class="girisForm">

            <tr>
                <td class="loginSolBlock">Email</td>
                <td>
                    <asp:TextBox ID="txEmail" runat="server" Width="100%"></asp:TextBox>
                </td>
                <td class="loginSagBlock">
                    <asp:Button ID="btnEmailDegistir" runat="server" Text="Güncelle" ValidationGroup="email" OnClick="btnEmailDegistir_Click" />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="!" ControlToValidate="txEmail" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="email"></asp:RegularExpressionValidator>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ValidationGroup="email" ControlToValidate="txEmail"></asp:RequiredFieldValidator>

                </td>
            </tr>
            <tr>
                <td class="loginSolBlock">Mevcut Şifre</td>
                <td>
                    <asp:TextBox ID="txMevcutSifre" runat="server" Width="100%" ValidationGroup="sifre" TextMode="Password"></asp:TextBox>
                </td>
                <td class="loginSagBlock">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ControlToValidate="txMevcutSifre" ValidationGroup="sifre"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td class="loginSolBlock">Yeni Şifre</td>
                <td>
                    <asp:TextBox ID="txYeniSifre" runat="server" Width="100%" ValidationGroup="sifre" TextMode="Password"></asp:TextBox>
                </td>
                <td class="loginSagBlock">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ControlToValidate="txYeniSifre" ValidationGroup="sifre"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="uyuşmadı!" ControlToCompare="txYeniSifre" ControlToValidate="txYeniSifreTekrar" ValidationGroup="sifre"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td class="loginSolBlock">Şifre Tekrar</td>
                <td>
                    <asp:TextBox ID="txYeniSifreTekrar" runat="server" Width="100%" ValidationGroup="sifre" TextMode="Password"></asp:TextBox>
                </td>
                <td class="loginSagBlock">
                    <asp:Button ID="btnSifreDegistir" runat="server" Text="Güncelle" ValidationGroup="sifre" OnClick="btnSifreDegistir_Click" />
                       <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="*" ControlToValidate="txYeniSifreTekrar" ValidationGroup="sifre"></asp:RequiredFieldValidator>
                
                </td>
            </tr>
           
            <tr>
                <td class="loginSolBlock">&nbsp;</td>
                <td>
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>
                </td>
                <td class="loginSagBlock"></td>
            </tr>

        </table>
    </div>
</asp:Content>

