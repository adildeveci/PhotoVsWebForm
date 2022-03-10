<%@ Control Language="C#" AutoEventWireup="true" CodeFile="photoUploadMenu.ascx.cs" Inherits="photoUploadMenu" %>
<link href="../css/uploadMenu.css" rel="stylesheet" />
<link href="../css/normalize.css" rel="stylesheet" />
<div id="photoUploadMenu">
    
    <div class="photoUploadMenuItem">
        <asp:ImageButton ID="ImageButton1" CssClass="photoUploadMenuImage" Width="40px" runat="server" ImageUrl="~/images/photouploadayni.png" PostBackUrl="~/upload1photo.aspx" /> </div>
      <div class="photoUploadMenuItem"> 
          <asp:ImageButton ID="ImageButton2" CssClass="photoUploadMenuImage" Width="40px"  runat="server" ImageUrl="~/images/photouploadayri.png" PostBackUrl="~/upload2photo.aspx"/></div>
      <div class="photoUploadMenuItem">
          <asp:ImageButton ID="ImageButton3" CssClass="photoUploadMenuImage" Width="40px"  runat="server" ImageUrl="~/images/photouploadduello.png" /></div>

</div>
