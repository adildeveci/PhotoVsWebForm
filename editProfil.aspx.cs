    using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.IO;
public partial class editProfil : System.Web.UI.Page
{
    myClass myclass = new myClass(); 
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["kullaniciId"] != null)
            {
                DataTable dt = myclass.dataTableGetir("select * from kullanicilar where kullaniciId= " + Session["kullaniciId"]);
                txAd.Text = dt.Rows[0]["ad"].ToString();
                txSoyad.Text = dt.Rows[0]["soyad"].ToString();
                txKullaniciAdi.Text = dt.Rows[0]["kullaniciAdi"].ToString();
                txHakkinda.Text = dt.Rows[0]["hakkinda"].ToString();
                if (dt.Rows[0]["profilPhotoUrl"].ToString()!="") ImageProfil.ImageUrl = "profilPhotos/" + dt.Rows[0]["profilPhotoUrl"].ToString();
               
            }
            else
            {
                Response.Redirect("login.aspx");
            }
          
        }

    } 
    protected void btnKaydet_Click(object sender, EventArgs e)
    {
        //eğer kullanıcı adı değişmişse ve başkasında mevcut ise  uyar
        if (int.Parse(myclass.sorguCalistirTekSonuc("select count(*) from kullanicilar where kullaniciAdi='" + txKullaniciAdi.Text + "' and kullaniciId<>" + Session["kullaniciId"]).ToString()) > 0)
        {
            lblMessage.Text = "Bu kullanıcı adı başkasının";
        }
        else
        {

            string photoAdi = "";
            //eğer yeni foto seçildiyse
            if (FileUpload1.HasFile)
            {
                string dosyauzanti = Path.GetExtension(FileUpload1.FileName).ToLower();
                //string yeniFotoAdi = DateTime.Today.Year.ToString() + "_" + DateTime.Today.Month.ToString() + "_" + DateTime.Today.Day.ToString() + "_" + DateTime.Now.Hour.ToString() + "_" + DateTime.Now.Minute.ToString() + "_" + DateTime.Now.Second.ToString() + "_" + DateTime.Now.Millisecond.ToString() + "_" + Session["kullaniciId"].ToString() + dosyauzanti;
                //FileUpload1.SaveAs(Server.MapPath("~/profilPhotos/") + yeniFotoAdi);
                //photoAdi = yeniFotoAdi;
                string yeniFotoAdi = DateTime.Today.Year.ToString() + "_" + DateTime.Today.Month.ToString() + "_" + DateTime.Today.Day.ToString() + "_" + DateTime.Now.Hour.ToString() + "_" + DateTime.Now.Minute.ToString() + "_" + DateTime.Now.Second.ToString() + "_" + DateTime.Now.Millisecond.ToString() + "_" + Session["kullaniciId"].ToString() + dosyauzanti;
                photoAdi = yeniFotoAdi;
                myclass.yukle(FileUpload1, 80,"/profilPhotos/", yeniFotoAdi);
              
            }
            else
            {
                // profilPhotos/ 13 karakter olduğu için 13. karakterden sonrasını al
                photoAdi = ImageProfil.ImageUrl.Substring(13);
            }
            if (myclass.sorguCalistir("exec editProfil " + Session["kullaniciId"] + ",'" + txKullaniciAdi.Text + "', '" + txAd.Text + "', '" + txSoyad.Text + "', '" + txHakkinda.Text + "', '" + photoAdi + "'") > 0)
            {
                lblMessage.Text = "Kaydedildi";
            }
            else
            {
                lblMessage.Text = "Kayıt başarısız!";
            }
        }
    }
    
}