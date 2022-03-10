<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="upload1photo.aspx.cs" Inherits="upload1photo" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/userControl/photoUploadMenu.ascx" TagPrefix="uc1" TagName="photoUploadMenu" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/normalize.css" rel="stylesheet" />
    <link href="css/upload1photo.css" rel="stylesheet" /> 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   
   <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods = "true"></asp:ScriptManager>
    <div id="uploadPhotoContent">
    <uc1:photoUploadMenu runat="server" ID="photoUploadMenu" />
    <div id="createfoto">
        <div class="fotosec"> <asp:FileUpload ID="FileUpload1" runat="server"  />
            <asp:Label ID="lblMesaj" runat="server"></asp:Label>
        </div>
        <div class="uploadbutton">
    <asp:ImageButton  ID="btnPhoto1Upload"  Height="35px" runat="server" ImageUrl="~/images/photoUploadSave.png" OnClick="btnPhoto1Upload_Click"  />
    </div>

    </div> 
    <asp:TextBox ID="txAciklama" placeholder="Açıklama" runat="server" Width="95%"></asp:TextBox> 
       <div class="kullaniciEtiketle">
        <div class="solEtiketAlani"> 
             <asp:TextBox ID="txEtiketSol" placeholder="Sol Etiket"  runat="server" Width="95%"></asp:TextBox>
             <asp:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID ="txEtiketSol" ServiceMethod="getKullanici" ServicePath="~/WebService.asmx"  MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1" CompletionInterval="1000">
              </asp:AutoCompleteExtender>
        </div>
        <div class="sagEtiketAlani">
             <asp:TextBox ID="txEtiketSag" placeholder="Sağ Etiket"  runat="server" Width="95%"></asp:TextBox>
             <asp:AutoCompleteExtender ID="AutoCompleteExtender2" runat="server" TargetControlID="txEtiketSag" ServiceMethod="getKullanici" ServicePath="~/WebService.asmx"  MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1" CompletionInterval="1000">
             </asp:AutoCompleteExtender>
        </div>
    </div>       
    
    <asp:Image ID="Image1" Width="100%"  runat="server" ImageUrl="~/images/facetofaceimage.jpg" />
    
        </div>
</asp:Content>

