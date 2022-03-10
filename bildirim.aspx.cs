using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class bildirim : System.Web.UI.Page
{
    myClass myclass = new myClass();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
             
            if (Session["kullaniciId"] != null)
            {
                SqlDataSourceBildirimler.SelectCommand = "exec getBildirim @kullaniciId, @topCount";
                SqlDataSourceBildirimler.SelectParameters["kullaniciId"].DefaultValue = Session["kullaniciId"].ToString();
                SqlDataSourceBildirimler.SelectParameters["topCount"].DefaultValue = "3";
                
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
       
    }
    protected void RepeaterBildirim_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.AlternatingItem || e.Item.ItemType == ListItemType.Item)
        {
            
            Label lblBildirimTuru = (Label)e.Item.FindControl("lblBildirimTuru"); 
            Label lblBildirimResimUrl = (Label)e.Item.FindControl("lblBildirimResimUrl");
            if (((Label)e.Item.FindControl("lblBildirimTuru")).Text == "takip")
            {
                ((Label)e.Item.FindControl("lblAciklama")).Text = "Sizi Takip Etti";
            }
            else if (lblBildirimTuru.Text == "begeni")
            {
                ((Label)e.Item.FindControl("lblAciklama")).Text = "Sizin <a href='#'>Fotoğrafınızı</a>  Beğendi";
                ((ImageButton)e.Item.FindControl("imgBildirim")).ImageUrl = "photos/"+lblBildirimResimUrl.Text;
            }
            else if (lblBildirimTuru.Text == "favori")
            {
                ((Label)e.Item.FindControl("lblAciklama")).Text = "Sizin Fotoğrafınızı Favorilerine Ekledi";
                ((ImageButton)e.Item.FindControl("imgBildirim")).ImageUrl = "photos/" + lblBildirimResimUrl.Text;
            }
            else if (lblBildirimTuru.Text == "etiket")
            {
                ((Label)e.Item.FindControl("lblAciklama")).Text = "Sizi bir fotoğrafa etiketledi";
                ((ImageButton)e.Item.FindControl("imgBildirim")).ImageUrl = "photos/" + lblBildirimResimUrl.Text;
            }
        }
    }
    protected void loadMore_Click(object sender, EventArgs e)
    {
           SqlDataSourceBildirimler.SelectParameters["topCount"].DefaultValue = (int.Parse(SqlDataSourceBildirimler.SelectParameters["topCount"].DefaultValue) + 3).ToString();
    }
}