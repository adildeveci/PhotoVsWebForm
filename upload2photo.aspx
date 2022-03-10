<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="upload2photo.aspx.cs" Inherits="upload2photo" %>

<%@ Register Src="~/userControl/photoUploadMenu.ascx" TagPrefix="uc1" TagName="photoUploadMenu" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/normalize.css" rel="stylesheet" />
    <link href="css/upload2photo.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
   
    <div id="uploadPhotoContent">
     <uc1:photoUploadMenu runat="server" ID="photoUploadMenu" />
    
    <div class="photo2uploadpanel">
         <div class="photo2uploadpanelBlok1">
                   <asp:FileUpload ID="FileUpload1" runat="server" /> 
         </div>
         <div class="photo2uploadpanelBlok2">
                  <asp:FileUpload ID="FileUpload2" runat="server" /> 
        </div> 
        <div class="uploadbutton">
                       <asp:ImageButton  ID="ImageButton1"   runat="server" ImageUrl="~/images/photoUploadSave.png" />
       </div>
   </div>


    <asp:TextBox ID="TextBox1"  placeholder="Açıklama" runat="server" Width="95%"></asp:TextBox>
    <div class="fotocontent">
    <asp:Image ID="Image1" Width="45%"  runat="server" ImageUrl="~/images/selfie1.png" />
    <asp:Image ID="Image2" Width="45%"  runat="server" ImageUrl="~/images/selfie2.png" />
        </div>
    <div class="kullaniciEtiketle">
        <div class="solEtiketAlani">
            <asp:LinkButton ID="LinkButton1" runat="server">@etiket1</asp:LinkButton>
            <asp:Button ID="Button1" runat="server" Text="x" />
            <br />
             <asp:TextBox ID="TextBox2" runat="server" Width="95%"></asp:TextBox>
               </div>
        <div class="sagEtiketAlani">
            <asp:LinkButton ID="LinkButton2" runat="server">@etiket2</asp:LinkButton>
            <asp:Button ID="Button2" runat="server" Text="x" />
            <br />
            <asp:TextBox ID="TextBox3" runat="server" Width="95%"></asp:TextBox>
                </div>
    </div>
        </div>
</asp:Content>

