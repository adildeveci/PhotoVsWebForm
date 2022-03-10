<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="search.aspx.cs" Inherits="search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/normalize.css" rel="stylesheet" />
    <link href="css/bildirim.css" rel="stylesheet" />
    <link href="css/search.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>    <div id="aramaContent">
     <div class="aramaBar">
        <div class="aramaMetni">  <asp:TextBox ID="txara" Width="100%" Height="25px" placeholder="Aranacak Kişi" runat="server" ></asp:TextBox></div>
        <div class="aramaButonu"> <asp:ImageButton ID="btnAra" runat="server" ImageUrl="~/images/arama.png" OnClick="btnAra_Click" /></div>
    </div>

    <div class="aramaSonuclari">

        <asp:SqlDataSource ID="SqlDataSourceUser" runat="server"  
                SelectCommand="exec searchUser @kullaniciId, @arama, @topCount"
                ConnectionString="<%$ ConnectionStrings:baglanti %>"> 
                 <SelectParameters>
                     <asp:Parameter Name="kullaniciId" DefaultValue='<% Session["kullaniciId"].ToString() %>' Type="Int32" />
                     <asp:Parameter Name="arama" DefaultValue='<% txara.Text %>' Type="String" />
                      <asp:Parameter Name="topCount" DefaultValue="3" Type="Int32" />
                 </SelectParameters>  
            </asp:SqlDataSource>

        <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
            <ContentTemplate>
                <asp:Repeater ID="RepeaterAra" runat="server" DataSourceID="SqlDataSourceUser" OnItemCommand="RepeaterAra_ItemCommand" OnItemDataBound="RepeaterAra_ItemDataBound">
           <ItemTemplate>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
            <ContentTemplate>

              <div class="bildirim-area">
          <div class="sol-resim">  
            <asp:ImageButton Width="40px" Height="40px"   runat="server"  ImageUrl='<%#Eval("profilPhotoUrl").ToString()!=""?"profilPhotos/"+Eval("profilPhotoUrl"):"images/bonus.png" %>' PostBackUrl='<%# "~/profilx.aspx?kid="+ Eval("kullaniciId") %>'/>
            
          </div>
          <div class="yazi-alani">

               <asp:LinkButton ID="LinkButton1" runat="server" Font-Size="Small" PostBackUrl='<%# "~/profilx.aspx?kid="+ Eval("kullaniciId") %>' >@<%#Eval("kullaniciAdi") %></asp:LinkButton> 
                
                <asp:Label ID="Label3" runat="server" Font-Size="Small"><%#Eval("ad") %>_<%#Eval("soyad") %></asp:Label>
              <br />
              <asp:Label ID="Label1" runat="server" Font-Size="Small"><%#Eval("hakkinda") %></asp:Label>
             </div>
          <div class="sag-resim">
             <asp:ImageButton ID="btnTakip" CommandName="btnTakip" CommandArgument='<%#Eval("kullaniciId") %>' runat="server" ImageUrl='<%#Eval("takipEdenId").ToString()!=""?"images/takipEdilen.png":"images/takipEt.png" %>'/>

          </div>
        </div>

                 </ContentTemplate> 
        </asp:UpdatePanel>

            </ItemTemplate>  
        </asp:Repeater>
            </ContentTemplate>
            <Triggers>
                 <asp:AsyncPostBackTrigger  ControlID="loadMore" EventName="Click"/>
            </Triggers>
        </asp:UpdatePanel>

          

           
         
        
    </div>
  <asp:Button ID="loadMore" Visible="false" runat="server" Text="Daha Fazla..." Height="40px" Width="100%" OnClick="loadMore_Click"   />
     </div>
</asp:Content>

