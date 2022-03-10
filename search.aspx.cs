using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
public partial class search : System.Web.UI.Page
{
    myClass myclass = new myClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["kullaniciId"] != null)
            {
                //arama sonucunu doldur
                SqlDataSourceUser.SelectCommand = "exec searchUser @kullaniciId, @arama, @topCount";
                SqlDataSourceUser.SelectParameters["kullaniciId"].DefaultValue = Session["kullaniciId"].ToString();
                SqlDataSourceUser.SelectParameters["arama"].DefaultValue = txara.Text;
                SqlDataSourceUser.SelectParameters["topCount"].DefaultValue = "3";
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }
    
    protected void btnAra_Click(object sender, ImageClickEventArgs e)
    {
        SqlDataSourceUser.SelectCommand = "exec searchUser @kullaniciId, @arama, @topCount";
        SqlDataSourceUser.SelectParameters["kullaniciId"].DefaultValue = Session["kullaniciId"].ToString();
        SqlDataSourceUser.SelectParameters["arama"].DefaultValue = txara.Text;
        SqlDataSourceUser.SelectParameters["topCount"].DefaultValue = "3";

         
        loadMore.Visible = true;
         
    }
    protected void RepeaterAra_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "btnTakip") { 
            //takip et butonuna bastığında
            ImageButton btnTakip = (ImageButton)e.Item.FindControl("btnTakip");    
            //takip durumunu değiştir 
            bool sonuc =(bool) myclass.sorguCalistirTekSonuc("DECLARE @cevap bit EXEC takipEtBirak "+Session["kullaniciId"]+", "+btnTakip.CommandArgument.ToString()+", @cevap OUTPUT select @cevap");
            //ve takip durumuna göre resmi de değiştir
            btnTakip.ImageUrl=sonuc==true?"images/takipEdilen.png":"images/takipEt.png";

           
        }
    }

    protected void loadMore_Click(object sender, EventArgs e)
    {
        SqlDataSourceUser.SelectParameters["topCount"].DefaultValue = (int.Parse(SqlDataSourceUser.SelectParameters["topCount"].DefaultValue) + 3).ToString();

    }
    protected void RepeaterAra_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
        {
            if (((ImageButton)e.Item.FindControl("btnTakip")).CommandArgument.ToString() == Session["kullaniciId"].ToString())
            {
                ((ImageButton)e.Item.FindControl("btnTakip")).Visible = false;
            }
         }
    }
}