<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="bildirim.aspx.cs" Inherits="bildirim" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/normalize.css" rel="stylesheet" />
    <link href="css/bildirim.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    
     <div id="bildirimContent">
         
          <asp:SqlDataSource ID="SqlDataSourceBildirimler" runat="server"
                SelectCommand="exec getBildirim @kullaniciId, @topCount"
                ConnectionString="<%$ ConnectionStrings:baglanti %>"> 
                 <SelectParameters>
                     <asp:Parameter Name="kullaniciId" DefaultValue='<% Session["kullaniciId"].ToString() %>' Type="Int32" />
                     <asp:Parameter Name="topCount" DefaultValue="3" Type="Int32" />
                 </SelectParameters>  
            </asp:SqlDataSource>  
         <asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
             <ContentTemplate>
                 <asp:Repeater ID="RepeaterBildirim" runat="server" DataSourceID="SqlDataSourceBildirimler" OnItemDataBound="RepeaterBildirim_ItemDataBound">
            <ItemTemplate>
                  <div class="bildirim-area">
          <div class="sol-resim">
               <asp:ImageButton ID="ImageButton2" Width="40px" Height="40px"   runat="server"  ImageUrl='<%#Eval("profilPhotoUrl").ToString()!=""?"profilPhotos/"+Eval("profilPhotoUrl"):"images/bonus.png" %>' PostBackUrl='<%# "~/profilx.aspx?kid="+ Eval("kullaniciIdBildiren") %>'/>
            
               </div>
          <div class="yazi-alani">
               <asp:Label ID="lblBildirimTuru"  runat="server" Visible="false" Text='<%#Eval("bildirimTuru") %>'></asp:Label> 
              <asp:Label ID="lblBildirimResimUrl"  runat="server" Visible="false" Text='<%#Eval("bildirimResimUrl") %>'></asp:Label>


              <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl='<%# "~/profilx.aspx?kid="+ Eval("kullaniciIdBildiren") %>'>
                  <%#Eval("kullaniciAdi") %>
              </asp:LinkButton> 
              <asp:Label ID="lblAciklama" runat="server" ></asp:Label>
              <br />
              <asp:Label ID="Label1"  runat="server" Font-Size="XX-Small" Text='<%#Eval("bildirimTarihi") %>'></asp:Label>

             </div>
          <div class="sag-resim">  
             <asp:ImageButton ID="imgBildirim" runat="server" Width="40px" Height="40px"  ImageUrl="images/bildirim.png"/>
           </div>
        </div>

            </ItemTemplate> 
        </asp:Repeater>
             </ContentTemplate>
             <Triggers>
                 <asp:AsyncPostBackTrigger ControlID="loadMore" EventName="Click" />
             </Triggers>
         </asp:UpdatePanel>
           
       

         <asp:Button ID="loadMore" runat="server" Text="Daha Fazla..." Height="40px" Width="100%" OnClick="loadMore_Click"   />
        
    </div>
</asp:Content>

