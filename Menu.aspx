<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Menu.aspx.cs" Inherits="Menu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/normalize.css" rel="stylesheet" />
    <link href="css/menu.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="menuContent"> 
          <asp:Button ID="btnAyar" runat="server" Width="100%" Height="40px" Text="Hesap Ayarları" OnClick="btnAyar_Click" />
         <asp:Button ID="btnCikis" runat="server" Width="100%" Height="40px" Text="Çıkış" OnClick="btnCikis_Click" />
       
    </div>
</asp:Content>

