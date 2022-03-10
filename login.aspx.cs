using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class login : System.Web.UI.Page
{
    
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    myClass mc = new myClass(); 
    protected void btnLogin_Click(object sender, EventArgs e)
    { 
        object kullaniciId=mc.sorguCalistirTekSonuc("select kullaniciId from kullanicilar where (kullaniciAdi='"+txEmail.Text+"' or email='"+txEmail.Text+"') and sifre='"+txSifre.Text+"'");
        if(kullaniciId!=null)
        {
            Title = "Hoş Geldiniz";
            Session["kullaniciId"] = kullaniciId;
            Response.Redirect("default.aspx");
        }

        else {
            lblMesaj.Text = "Hatalı Giriş";
        } 
    }
    
    protected void btnSignup_Click(object sender, EventArgs e)
    {
        Response.Redirect("signup.aspx");
    }
}