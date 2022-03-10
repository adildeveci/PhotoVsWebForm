<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <title>Photo VS</title>
    <meta name="description" content="Fotoğraflarınızı karşılaştırın. Hangi fotoğrafın daha iyi olduğunu öğrenin." />
    <meta name="keywords" content="foto, photo, vs, photovs, karsilastir" />
    <meta name="author" content="photo vs" />

    <link href="css/normalize.css" rel="stylesheet" />
    <link href="css/gonderi.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div id="anaSayfaContent">
        <asp:UpdatePanel ID="UpdatePanel2" runat="server">
            <ContentTemplate>
                <div class="kisitlamaBar">

                    <div class="dunyaCapinda">
                        <asp:ImageButton ID="btnHerkes" CssClass="kisitmalaResim" runat="server" ImageUrl="~/images/herkesSelected.png" Height="40px" OnClick="btnHerkes_Click" />
                    </div>

                    <div class="takipEttiklerim">
                        <asp:ImageButton ID="btnTakipEttiklerim" CssClass="kisitmalaResim" runat="server" ImageUrl="~/images/takipEttiklerim.png" OnClick="btnTakipEttiklerim_Click" />
                    </div>
                </div>
            </ContentTemplate>
        </asp:UpdatePanel>



        <div id="gonderiler">

            <asp:SqlDataSource ID="SqlDataSourceGonderiler" runat="server"
                SelectCommand="exec getGonderilerDunyaCapinda @kullaniciId, @topCount"
                ConnectionString="<%$ ConnectionStrings:baglanti %>">
                <SelectParameters>
                    <asp:Parameter Name="kullaniciId" DefaultValue='<% Session["kullaniciId"].ToString() %>' Type="Int32" />
                    <asp:Parameter Name="topCount" DefaultValue="3" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>

                    <asp:Repeater ID="RepeaterGonderi" runat="server" OnItemCommand="RepeaterGonderi_ItemCommand" DataSourceID="SqlDataSourceGonderiler">
                        <ItemTemplate>

                            <div class="gonderiItem">
                                <%--gonderiIdyi tutan gizli etiket--%>
                                <asp:LinkButton ID="getGonderiId" runat="server" CommandName="getGonderiId" CommandArgument='<%#Eval("gonderiId")%>'></asp:LinkButton>
                                <div class="gonderiUstBar">
                                    <asp:ImageButton ID="ImageButtonProfil" CssClass="profilPhoto" runat="server" ImageUrl='<%#Eval("profilPhotoUrl").ToString()!=""?"~/profilPhotos/"+Eval("profilPhotoUrl").ToString():"images/bonus.png" %>' PostBackUrl='<%# "~/profilx.aspx?kid="+ Eval("kullaniciId") %>' />
                                    <asp:ImageButton ID="btnFav" runat="server" CommandName="btnFav" ImageUrl='<%# Eval("favlayanKullaniciId").ToString()!=""?"images/fav.png":"images/favEmpty.png" %>' />
                                    <asp:ImageButton ID="ImageButton26" runat="server" ImageUrl="~/images/facebook.png" />
                                    <asp:ImageButton ID="ImageButton27" runat="server" ImageUrl="~/images/twitter.png" />

                                    <asp:ImageButton ID="btnGonderiMenu" runat="server" ImageUrl="~/images/gonderiMenu.png" ImageAlign="Right" />
                                    <!--gonderi menüye basınca açılacak olan panel-->
                                    <asp:Panel ID="panelGonderiMenu" runat="server" CssClass="panelGonderiMenu">
                                        <asp:Button ID="Button1" Text="Sil" Width="100%" CommandName="btnSil" runat="server" Visible='<%# Eval("kullaniciId").ToString()!=Session["kullaniciId"].ToString()?false:true %>' />
                                        <asp:Button Text="Şikayet Et" Width="100%" ID="btnSikayet" CommandName="btnSikayet" runat="server" Visible='<%# Eval("kullaniciId").ToString()!=Session["kullaniciId"].ToString()?true:false %>' />
                                        <asp:Button ID="btnIptal" Width="100%" runat="server" Text="İptal" />
                                    </asp:Panel>
                                    <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="arkaGonderiMenu" CancelControlID="btnIptal" TargetControlID="btnGonderiMenu" PopupControlID="panelGonderiMenu"></asp:ModalPopupExtender>

                                </div>
                                <div class="gonderiAciklama">
                                    <asp:LinkButton ID="LinkButton13" runat="server" PostBackUrl='<%# "~/profilx.aspx?kid="+ Eval("kullaniciId") %>'>@<%#Eval("kullaniciAdi") %></asp:LinkButton>
                                    <%#Eval("aciklama") %>
                                </div>
                                <div class="gonderiFoto">
                                    <img src="photos/<%#Eval("foto1url") %>" width="100%" />

                                </div>
                                <div class="gonderiLikeBar">
                                    <div class="solLike">
                                        <div class="solEtiket">
                                            <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl='<%# "~/profilx.aspx?kid="+ Eval("etiketSol") %>'><%#Eval("etiketSolKullaniciAdi")%></asp:LinkButton>
                                        </div>

                                        <div class="solLikeButton">
                                            <div class="solLikeSayisi">
                                                <asp:Label ID="solBegeniSayisi" runat="server" Font-Size="Small"><%#Eval("solBegeniSayisi") %></asp:Label>
                                            </div>
                                            <div class="solLikeImage">
                                                <asp:ImageButton ID="btnSolLike" runat="server" CommandName="btnSolLike" ImageUrl='<%# Eval("begeniSolSag").ToString()=="False"?"images/liked.png":"images/likeEmpty.png" %>' />
                                            </div>

                                        </div>
                                    </div>
                                    <div class="sagLike">
                                        <div class="sagEtiket">
                                            <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl='<%# "~/profilx.aspx?kid="+ Eval("etiketSag") %>'><%#Eval("etiketSagKullaniciAdi")%></asp:LinkButton>

                                        </div>
                                        <div class="sagLikeButton">
                                            <div class="sagLikeSayisi">
                                                <asp:Label ID="sagBegeniSayisi" runat="server" Font-Size="Small"><%#Eval("sagBegeniSayisi") %></asp:Label>
                                            </div>
                                            <div class="sagLikeImage">
                                                <asp:ImageButton ID="btnSagLike" runat="server" CommandName="btnSagLike" ImageUrl='<%#Eval("begeniSolSag").ToString()=="True"?"images/liked.png":"images/likeEmpty.png" %>' />
                                            </div>

                                        </div>
                                    </div>
                                </div>
                            </div>


                        </ItemTemplate>
                    </asp:Repeater>

                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="loadMore" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnHerkes" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnTakipEttiklerim" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>

        </div>
        <asp:Button ID="loadMore" runat="server" Text="Daha Fazla..." Height="40px" Width="100%" OnClick="loadMore_Click" />


    </div>
</asp:Content>

