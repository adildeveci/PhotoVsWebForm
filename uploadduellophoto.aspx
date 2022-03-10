<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="uploadduellophoto.aspx.cs" Inherits="uploadduellophoto" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Src="~/userControl/photoUploadMenu.ascx" TagPrefix="uc1" TagName="photoUploadMenu" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/normalize.css" rel="stylesheet" />
    <link href="css/uploadduellophoto.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <uc1:photoUploadMenu runat="server" ID="photoUploadMenu" />
    
    <div class="photo2uploadpanel">
     <div class="photo2uploadpanelBlok1">
         <asp:FileUpload ID="FileUpload1" runat="server" /> 
     </div>
       
        <div class="uploadbutton">
        <asp:ImageButton  ID="ImageButton1"  Height="35px" runat="server" ImageUrl="~/images/photoUploadSave.png" />
    </div>
         </div>
    <asp:TextBox ID="TextBox1"  placeholder="Açıklama" runat="server" Width="100%"></asp:TextBox>
    <div class="fotocontent">
    <asp:Image ID="Image1" Width="49%"  runat="server" ImageUrl="~/images/selfie1.png" />
    <asp:Image ID="Image2" Width="49%"  runat="server" ImageUrl="~/images/soruisareti.png" />
        </div>
    <div class="kullaniciEtiketle">
        <div class="solEtiketAlani">
            <asp:LinkButton ID="LinkButton1" runat="server">@etiket1</asp:LinkButton>
            <asp:Button ID="Button1" runat="server" Text="x" />
            <br />
             <asp:TextBox ID="TextBox2" runat="server" Width="100%"></asp:TextBox>
               </div>
        <asp:DropDownExtender ID="DropDownExtender1" TargetControlID="TextBox2" runat="server"></asp:DropDownExtender>
      
    </div>
</asp:Content>

