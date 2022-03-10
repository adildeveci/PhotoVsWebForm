using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
public partial class profilx : System.Web.UI.Page
{
    myClass myclass = new myClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { 
            if (Session["kullaniciId"]!= null)
            {
                if (Request.QueryString["kid"] != null && Request.QueryString["kid"].ToString()!=Session["kullaniciId"].ToString())
                {
                    DataTable dt = myclass.dataTableGetir("getProfilxBilgi " + Request.QueryString["kid"]+", "+Session["kullaniciId"]);
                    lblGonderiSayisi.Text = dt.Rows[0]["gonderiSayisi"].ToString()+" post";
                    lblTakipciSayisi.Text = dt.Rows[0]["takipciSayisi"].ToString();
                    lblTakipEdilenSayisi.Text = dt.Rows[0]["takipEdilenSayisi"].ToString();
                    lblKullaniciAdi.Text = "@" + dt.Rows[0]["kullaniciAdi"].ToString() + " ";
                    lblAdSoyad.Text = dt.Rows[0]["ad"].ToString() + " " + dt.Rows[0]["soyad"].ToString(); ;
                    lblHakkinda.Text = dt.Rows[0]["hakkinda"].ToString();
                    if (dt.Rows[0]["profilPhotoUrl"].ToString() != "") ImageProfil.ImageUrl = "~/profilPhotos/" + dt.Rows[0]["profilPhotoUrl"].ToString();
                    if (dt.Rows[0]["takipEdenId"].ToString()==Session["kullaniciId"].ToString())   btnTakip.ImageUrl = "images/takipEdilen.png";
                  


                    //gönderilerini doldur
                    SqlDataSourceGonderiler.SelectCommand = "exec getGonderilerTumu @kullaniciId, @kullaniciIdAktif, @topCount";
                    //baktığımız profilid
                    SqlDataSourceGonderiler.SelectParameters["kullaniciId"].DefaultValue = Request.QueryString["kid"];
                    //bakan profilin id si
                    SqlDataSourceGonderiler.SelectParameters["kullaniciIdAktif"].DefaultValue = Session["kullaniciId"].ToString();
                    SqlDataSourceGonderiler.SelectParameters["topCount"].DefaultValue = "3";
                }
                else
                {
                    //kulanıcı ıd boş ise kendi profiline salla salağı ya
                    Response.Redirect("profil.aspx");
                }
              
            }
            else Response.Redirect("login.aspx");
        }
        
    }



    protected void RepeaterGonderi_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        //tıklanan gonderiId yi çek
        LinkButton getGonderiId = (LinkButton)e.Item.FindControl("getGonderiId");
        string gonderiId = getGonderiId.CommandArgument.ToString();
        if (e.CommandName == "btnSolLike")
        {

            ImageButton btnSolLike = (ImageButton)e.Item.FindControl("btnSolLike");
            ImageButton btnSagLike = (ImageButton)e.Item.FindControl("btnSagLike");
            Label solBegeniSayisi = (Label)e.Item.FindControl("solBegeniSayisi");
            Label sagBegeniSayisi = (Label)e.Item.FindControl("sagBegeniSayisi");
            string sonuc = myclass.sorguCalistirTekSonuc("DECLARE @cevap bit EXEC likeSolSag " + Session["kullaniciId"] + ", " + gonderiId + ",0, @cevap OUTPUT select @cevap").ToString();
            btnSagLike.ImageUrl = "images/likeEmpty.png";
            btnSolLike.ImageUrl = sonuc == "False" ? "images/liked.png" : "images/likeEmpty.png";

            //beğenme işlemi bitti şimdi yeni beğeni sayısını göster

            solBegeniSayisi.Text = myclass.sorguCalistirTekSonuc("declare @cevap int exec getExpressBegeniSayisi " + gonderiId + ",0, @cevap  OUTPUT select @cevap").ToString();
            sagBegeniSayisi.Text = myclass.sorguCalistirTekSonuc("declare @cevap int exec getExpressBegeniSayisi " + gonderiId + ",1, @cevap  OUTPUT select @cevap").ToString();
        }
        else if (e.CommandName == "btnSagLike")
        {
            ImageButton btnSolLike = (ImageButton)e.Item.FindControl("btnSolLike");
            ImageButton btnSagLike = (ImageButton)e.Item.FindControl("btnSagLike");
            Label solBegeniSayisi = (Label)e.Item.FindControl("solBegeniSayisi");
            Label sagBegeniSayisi = (Label)e.Item.FindControl("sagBegeniSayisi");
            string sonuc = myclass.sorguCalistirTekSonuc("DECLARE @cevap bit EXEC likeSolSag " + Session["kullaniciId"] + ", " + gonderiId + ",1, @cevap OUTPUT select @cevap").ToString();
            btnSolLike.ImageUrl = "images/likeEmpty.png";
            btnSagLike.ImageUrl = sonuc == "True" ? "images/liked.png" : "images/likeEmpty.png";

            //beğenme işlemi bitti şimdi yeni beğeni sayısını göster
            solBegeniSayisi.Text = myclass.sorguCalistirTekSonuc("declare @cevap int exec getExpressBegeniSayisi " + gonderiId + ", 0, @cevap  OUTPUT select @cevap").ToString();
            sagBegeniSayisi.Text = myclass.sorguCalistirTekSonuc("declare @cevap int exec getExpressBegeniSayisi " + gonderiId + ", 1, @cevap  OUTPUT select @cevap").ToString();
        }
        else if (e.CommandName == "btnFav")
        {
            ImageButton btnFav = (ImageButton)e.Item.FindControl("btnFav");
            string sonuc = myclass.sorguCalistirTekSonuc("DECLARE @cevap bit EXEC favlaBirak " + Session["kullaniciId"] + ", " + gonderiId + ", @cevap OUTPUT select @cevap").ToString();
            btnFav.ImageUrl = sonuc == "True" ? "images/fav.png" : "images/favEmpty.png";
        }
        else if (e.CommandName == "btnSil")
        {
            //gönderiyi sil
            string sonuc = myclass.sorguCalistir("exec gonderiSil " + gonderiId).ToString();
            //gönderiyi reperatörde gizle
            e.Item.Visible = false;
            //gönderiyle ait resim dosyasını sil
            //silincek resmin adını tutan gizli etiket
            LinkButton resimadi = (LinkButton)e.Item.FindControl("getFotoUrl");
            //silincek dosya yolu
            string yol = "photos/" + resimadi.CommandArgument.ToString();
            //eğer belirtilen yolda dosya varsa sil
            if (File.Exists(Server.MapPath(yol))) File.Delete(Server.MapPath(yol));


        }
        else if (e.CommandName == "btnSikayet")
        {
            //gonderi şikyet edildi şikayet tablosuna kayıt etle
            myclass.sorguCalistir("exec sikayetEt " + Session["kullaniciId"].ToString() + ", " + gonderiId);
            Button btnSikayet = (Button)e.Item.FindControl("btnSikayet");
            btnSikayet.Text = "Şikayet Edildi";
        }
    } 
    protected void btnTakip_Click(object sender, ImageClickEventArgs e)
    {
        //takip durumunu değiştir 
        bool sonuc = (bool)myclass.sorguCalistirTekSonuc("DECLARE @cevap bit EXEC takipEtBirak " + Session["kullaniciId"] + ", " + Request.QueryString["kid"].ToString() +", @cevap OUTPUT select @cevap");
        //ve takip durumuna göre resmi de değiştir
        btnTakip.ImageUrl = sonuc == true ? "images/takipEdilen.png" : "images/takipEt.png";

    }
    protected void loadMore_Click(object sender, EventArgs e)
    {
        SqlDataSourceGonderiler.SelectParameters["topCount"].DefaultValue = (int.Parse(SqlDataSourceGonderiler.SelectParameters["topCount"].DefaultValue) + 3).ToString();
   
    }
}