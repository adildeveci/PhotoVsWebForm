using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Menu : System.Web.UI.Page
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
    protected void btnCikis_Click(object sender, EventArgs e)
    {
        Session["kullaniciId"] = null;
        Response.Redirect("login.aspx");
    }
    protected void btnAyar_Click(object sender, EventArgs e)
    {
        Response.Redirect("hesapAyarlari.aspx");
    }
}