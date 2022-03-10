using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class signup : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    myClass myclass = new myClass();
    
    protected void btnLogin_Click(object sender, EventArgs e)
    {
        Response.Redirect("login.aspx");
    }
    protected void btnKayitOl_Click(object sender, EventArgs e)
    {
      DataTable kullanicilarTablosu = myclass.dataTableGetir("select * from kullanicilar where email='" + txEmail.Text + "' or kullaniciAdi='" + txKullaniciAdi.Text + "'");
           string kullaniciAdi="";
           string email="";

      if(kullanicilarTablosu.Rows.Count==0)
        {   
            if (myclass.sorguCalistir("insert into kullanicilar (kullaniciAdi, email, sifre) values('" + txKullaniciAdi.Text + "', '" + txEmail.Text + "','" + txSifre1.Text + "')")>0)
            {
                lblMessage.Text = "Kayıt Başarılı"; 
                
            }
           
        }


      else if (kullanicilarTablosu.Rows.Count == 1)
      {
          kullaniciAdi = kullanicilarTablosu.Rows[0]["kullaniciAdi"].ToString();
          email = kullanicilarTablosu.Rows[0]["email"].ToString();



          //kullanıcı adı veya email kullanılmakta kontrol et
          if (kullaniciAdi == txKullaniciAdi.Text)
          {
              //girilen kullanıcı adı mevcut
              lblMessage.Text = "girilen kullanıcı adı mevcut";
          }
          else
          {
              //girilen email mevcut
              lblMessage.Text = "girilen email mevcut";

          }
      }


      else if (kullanicilarTablosu.Rows.Count > 1)
        {
         
            //kayıt var kullanıcı adı ve ve  email de kullanılmakda
            lblMessage.Text = "girilen bilgiler var kullanıcı adı ve  email de kullanılmakda";
        }
    }
}