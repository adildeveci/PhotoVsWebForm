<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="arama.aspx.cs" Inherits="arama" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
   <br /><br /><br /><br /><br />
    




<asp:ToolkitScriptManager  ID="ToolkitScriptManager1" runat="server">
   
</asp:ToolkitScriptManager>
    <asp:TextBox ID="txtCity" runat="server"></asp:TextBox>
  <asp:AutoCompleteExtender ID="AutoCompleteExtender1" runat="server" TargetControlID="txtCity"
         MinimumPrefixLength="1" EnableCaching="true" CompletionSetCount="1" CompletionInterval="1000"
         ServiceMethod="GetCity" ServicePath="~/WebService.asmx">
    </asp:AutoCompleteExtender>
</asp:Content>

