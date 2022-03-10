using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;


using System.Drawing.Imaging; 
using System.Drawing; 
public partial class upload1photo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        { 
            if (Session["kullaniciId"] != null)
            {
                  
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }
    myClass myclass = new myClass();

   
    protected void btnPhoto1Upload_Click(object sender, ImageClickEventArgs e)
    { 


        if (FileUpload1.HasFile)//Kullanıcı fileupload ile bir dosya seçmiş ise işlemleri gerçekleştir.
        {
            string dosyauzanti = Path.GetExtension(FileUpload1.FileName).ToLower();
            if (dosyauzanti.ToLower() == ".jpg" || dosyauzanti.ToLower() == ".png" || dosyauzanti.ToLower() == ".bmp" || dosyauzanti.ToLower() == ".gif")
            {

              string yeniFotoAdi = DateTime.Today.Year.ToString() + "_" + DateTime.Today.Month.ToString() + "_" + DateTime.Today.Day.ToString() + "_" + DateTime.Now.Hour.ToString() + "_" + DateTime.Now.Minute.ToString() + "_" + DateTime.Now.Second.ToString() + "_" + DateTime.Now.Millisecond.ToString() + "_" + Session["kullaniciId"].ToString() + dosyauzanti;
              myclass.yukle(FileUpload1, 600,"/photos/",yeniFotoAdi);
              myclass.sorguCalistir("exec upload1photo '" + Session["kullaniciId"].ToString() + "', 'tekli', '" + txAciklama.Text + "', '"+txEtiketSol.Text+"', '"+txEtiketSag.Text+"', '" + yeniFotoAdi + "'");

                lblMesaj.Text = "Foto yüklendi.";
            }
        }
        else
            lblMesaj.Text = "Foto seç"; 
    
    }
 
}