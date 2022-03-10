<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="editProfil.aspx.cs" Inherits="editProfil" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <%-- <link href="css/normalize.css" rel="stylesheet" />--%>
    <link href="css/editProfil.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="editProfilContent">
        <table class="girisForm">
             <tr>
                <td class="loginSolBlock">
                    <asp:Image ID="ImageProfil" Width="80px" Height="80px" runat="server" ImageUrl="~/images/bonus.png" />

                </td>
                <td> 
                  <asp:FileUpload ID="FileUpload1" runat="server" /></td>
                <td class="loginSagBlock">
                       </td>
            </tr>
            <tr>
                <td class="loginSolBlock">Kullanıcı Adı</td>
                <td>
                    <asp:TextBox ID="txKullaniciAdi" runat="server" Width="100%"></asp:TextBox>
                </td>
                <td class="loginSagBlock">
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txKullaniciAdi" ValidationGroup="Kayit"></asp:RequiredFieldValidator>
                     </td>
            </tr>
            <tr>
                <td class="loginSolBlock">Ad</td>
                <td>
                    <asp:TextBox ID="txAd" runat="server" Width="100%"></asp:TextBox>
                </td>
                <td class="loginSagBlock">
                    </td> 
            </tr>
            <tr>
                <td class="loginSolBlock">Soyad</td>
                <td >
                    <asp:TextBox ID="txSoyad" runat="server" Width="100%"></asp:TextBox>
                </td>
                <td class="loginSagBlock">
                     </td>
            </tr>
             <tr>
                <td class="loginSolBlock">Hakkinda</td>
                <td>
                    <asp:TextBox ID="txHakkinda" runat="server" Width="100%" TextMode="MultiLine"></asp:TextBox>
                </td>
                <td class="loginSagBlock">
                    </td>
            </tr>
            <tr>
                <td class="loginSolBlock">
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnKaydet" runat="server" Width="100%" Height="40px" Text="Kaydet" ValidationGroup="Kayit" OnClick="btnKaydet_Click" />
                </td>
                <td class="loginSagBlock">
                </td>
            </tr> 
            <tr >
                <td class="loginSolBlock">
                    &nbsp;</td>
                <td>
                    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" ></asp:Label>
                </td>
                <td class="loginSagBlock">
                </td>
            </tr>
             
        </table>






        <%-- <div class="editBox">
             <div class="editBoxSol">
                  <asp:Image ID="ImageProfil" Width="80px" Height="80px" runat="server" /> <br />
                  <asp:FileUpload ID="FileUpload1" runat="server" />
             </div>
             <div class="editBoxSag">
                
                 <div>
                       <asp:ImageButton ID="btnEditProfil" Width="40px" Height="40px" ImageUrl="~/images/save.png" ImageAlign="Right" runat="server" OnClick="btnEditProfil_Click"  />
                 </div>
                 
                  <div> 
                      <asp:Label ID="lblMesaj"  runat="server"></asp:Label>
                 </div>
               
             </div>
            
             
        </div>
         <div class="editProfilInputItem">
            Kullanıcı Adı<br />
            <asp:TextBox placeHolder="Kullanıcı Adı" ID="txKullaniciAdi" runat="server"></asp:TextBox>
            <asp:Label ID="lblKullaniciAdiUyari" runat="server" ></asp:Label>
        </div>
          <div class="editProfilInputItem">
             Ad<br />
            <asp:TextBox placeHolder="Ad" ID="txAd" runat="server"></asp:TextBox>
        </div>
          <div class="editProfilInputItem">
             Soyad <br />
            <asp:TextBox placeHolder="Soyad" ID="txSoyad" runat="server"></asp:TextBox>
        </div> 
          <div class="editProfilInputItem">
             Hakkımda<br />
            <asp:TextBox placeHolder="Hakkında" ID="txHakkinda" runat="server" TextMode="MultiLine" Width="100%"></asp:TextBox>
        </div>
        

        
            --%>
    </div>
</asp:Content>

