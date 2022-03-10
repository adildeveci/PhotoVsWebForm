using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class hesapAyarlari : System.Web.UI.Page
{
    myClass myclass = new myClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["kullaniciId"] != null)
            {
                DataTable dt = myclass.dataTableGetir("select * from kullanicilar where kullaniciId= " + Session["kullaniciId"]);
                txEmail.Text = dt.Rows[0]["email"].ToString();  
            }
            else
            {
                Response.Redirect("login.aspx");
            }

        }
    }
    protected void btnEmailDegistir_Click(object sender, EventArgs e)
    {
        bool sonuc = (bool)myclass.sorguCalistirTekSonuc("DECLARE @cevap bit EXEC emailDegistir " + Session["kullaniciId"].ToString() + ", '" + txEmail.Text + "', @cevap OUTPUT select @cevap");
        if (sonuc)
        {
            lblMessage.Text = "Email Başarıyla Güncellendi";
        }
        else
        {
            lblMessage.Text = "Bu email kullanılmakta !";
        }
    }
    protected void btnSifreDegistir_Click(object sender, EventArgs e)
    {
        bool sonuc = (bool)myclass.sorguCalistirTekSonuc("DECLARE @cevap bit EXEC sifreDegistir " + Session["kullaniciId"].ToString() + ", '"+txMevcutSifre.Text+"', '"+txYeniSifre.Text+"', @cevap OUTPUT select @cevap");
        if (sonuc)
        {
            lblMessage.Text = "Şifre Güncellendi";
        }
        else
        {
            lblMessage.Text = "Şifre değiştirilemedi. Mevcut şifre yanlış olabilir!";
        }
    }
}