<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="profil.aspx.cs" Inherits="profilim" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="css/normalize.css" rel="stylesheet" />
    <link href="css/profil.css" rel="stylesheet" />
    <link href="css/gonderi.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
    <div class="profilContent">
        <div class="profilUstContent">
            <div class="profilUstBar">
                <div class="profilFoto">
                    <asp:Image ID="ImageProfil" CssClass="profilPhoto" Width="40px" Height="40px" runat="server" ImageUrl="~/images/bonus.png" />
                </div>
                <div class="takipciler">
                    <div class="sayacIcon">
                        <img src="images/takipciler.png" height="30px" />
                    </div>
                    <div class="sayac">
                        <asp:Label ID="lblTakipciSayisi" runat="server" Font-Size="XX-Small"></asp:Label>
                    </div>
                </div>
                <div class="takipEdilen">
                    <div class="sayacIcon">
                        <img src="images/takipEdilen.png" height="30px" />
                    </div>
                    <div class="sayac">
                        <asp:Label ID="lblTakipEdilenSayisi" runat="server" Font-Size="XX-Small"></asp:Label>
                    </div>
                </div>
                <div class="gonderiSayisi">
                    <div class="sayacIcon">
                        <img src="images/photouploadayni.png" height="30px" />
                    </div>
                    <div class="sayac">
                        <asp:Label ID="lblGonderiSayisi" runat="server" Font-Size="XX-Small"></asp:Label>
                    </div>
                </div>
                <div class="ayarButton">
                    <asp:ImageButton PostBackUrl="~/editProfil.aspx" runat="server" ImageUrl="~/images/settings.png" ImageAlign="Right" />
                </div>
            </div>
            <div class="profilHakkinda">

                <asp:Label ID="lblKullaniciAdi" runat="server" ForeColor="#6600FF"></asp:Label><asp:Label ID="lblAdSoyad" runat="server" ForeColor="#FF9933"></asp:Label>
                <br />
                <asp:Label ID="lblHakkinda" runat="server" />
            </div>
            <asp:UpdatePanel runat="server">
                <ContentTemplate>
                    <div class="gonderiKisitlamaBar">
                        <div class="tumGonderiler">
                            <asp:ImageButton CssClass="ortaIcon" ID="btnTumGonderiler" runat="server" ImageUrl="~/images/timeSelected.png" OnClick="btnTumGonderiler_Click" />
                        </div>

                        <div class="favoriGonderiler">
                            <asp:ImageButton CssClass="ortaIcon" ID="btnFavoriGonderiler" runat="server" ImageUrl="~/images/favori.png" OnClick="btnFavoriGonderiler_Click" />
                        </div>

                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>



        </div>

        <asp:SqlDataSource ID="SqlDataSourceGonderiler" runat="server"
            SelectCommand="exec getGonderilerTumu @kullaniciId, @kullaniciIdAktif, @topCount"
            ConnectionString="<%$ ConnectionStrings:baglanti %>">
            <SelectParameters>
                <asp:Parameter Name="kullaniciId" DefaultValue='<% Session["kullaniciId"].ToString() %>' Type="Int32" />
                <asp:Parameter Name="kullaniciIdAktif" DefaultValue='<% Session["kullaniciId"].ToString() %>' Type="Int32" />
                <asp:Parameter Name="topCount" DefaultValue="3" Type="Int32" />
            </SelectParameters>
        </asp:SqlDataSource>

        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:Repeater ID="RepeaterGonderi" runat="server" DataSourceID="SqlDataSourceGonderiler" OnItemCommand="RepeaterGonderi_ItemCommand">
                    <ItemTemplate>


                        <div class="gonderiItem">
                            <%--gonderiIdyi tutan gizli etiket--%>
                            <asp:LinkButton ID="getGonderiId" runat="server" CommandName="getGonderiId" CommandArgument='<%#Eval("gonderiId")%>'></asp:LinkButton>
                            <asp:LinkButton ID="getFotoUrl" runat="server" CommandName="getGonderiId" CommandArgument='<%#Eval("foto1url")%>'></asp:LinkButton>


                            <div class="gonderiUstBar">
                                <asp:ImageButton ID="ImageButton1" CssClass="profilPhoto" runat="server" ImageUrl='<%#Eval("profilPhotoUrl").ToString()!=""?"profilPhotos/"+Eval("profilPhotoUrl"):"images/bonus.png" %>' PostBackUrl='<%# "~/profilx.aspx?kid="+ Eval("kullaniciId") %>' />
                                <asp:ImageButton ID="btnFav" runat="server" CommandName="btnFav" ImageUrl='<%# Eval("favlayanKullaniciId").ToString()!=""?"images/fav.png":"images/favEmpty.png" %>' />
                                <asp:ImageButton ID="ImageButton26" runat="server" ImageUrl="~/images/facebook.png" />
                                <asp:ImageButton ID="ImageButton27" runat="server" ImageUrl="~/images/twitter.png" />
                                <asp:ImageButton ID="btnGonderiMenu" runat="server" ImageUrl="~/images/gonderiMenu.png" ImageAlign="Right" />

                                <!--gonderi menüye basınca açılacak olan panel-->
                                <asp:Panel ID="panelGonderiMenu" runat="server" CssClass="panelGonderiMenu">
                                    <asp:Button Text="Sil" Width="100%" CommandName="btnSil" runat="server" Visible='<%# Eval("kullaniciId").ToString()!=Session["kullaniciId"].ToString()?false:true %>' />
                                    <asp:Button Text="Şikayet Et" Width="100%" id="btnSikayet" CommandName="btnSikayet" runat="server" Visible='<%# Eval("kullaniciId").ToString()!=Session["kullaniciId"].ToString()?true:false %>' />
                                    <asp:Button ID="btnIptal" Width="100%" runat="server" Text="İptal" />

                                </asp:Panel>

                                <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="arkaGonderiMenu" CancelControlID="btnIptal" TargetControlID="btnGonderiMenu" PopupControlID="panelGonderiMenu"></asp:ModalPopupExtender>
                            </div>
                            <div class="gonderiAciklama">
                                <asp:LinkButton ID="LinkButton1" runat="server" PostBackUrl='<%# "~/profilx.aspx?kid="+ Eval("kullaniciId") %>'>@<%#Eval("kullaniciAdi") %></asp:LinkButton>
                                <%#Eval("aciklama") %>
                            </div>
                            <div class="gonderiFoto">
                                <img src="photos/<%#Eval("foto1url") %>" width="100%" />

                            </div>
                            <div class="gonderiLikeBar">
                                <div class="solLike">
                                    <div class="solEtiket">
                                        <asp:LinkButton ID="LinkButton2" runat="server" PostBackUrl='<%# "~/profilx.aspx?kid="+ Eval("etiketSol") %>'><%#Eval("etiketSolKullaniciAdi")%></asp:LinkButton>
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
                                        <asp:LinkButton ID="LinkButton3" runat="server" PostBackUrl='<%# "~/profilx.aspx?kid="+ Eval("etiketSag") %>'><%#Eval("etiketSagKullaniciAdi") %></asp:LinkButton>

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
                <asp:AsyncPostBackTrigger ControlID="btnTumGonderiler" EventName="Click" />
                <asp:AsyncPostBackTrigger ControlID="btnFavoriGonderiler" EventName="Click" />
            </Triggers>
        </asp:UpdatePanel>


        <asp:Button ID="loadMore" runat="server" Text="Daha Fazla..." Height="40px" Width="100%" OnClick="loadMore_Click" />

    </div>
</asp:Content>

