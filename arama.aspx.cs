using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class arama : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    //#region "AutoComplete"
    ////Auto Complete
    //[System.Web.Script.Services.ScriptMethod()]
    //[System.Web.Services.WebMethod]

    //public static List<string> GetCity(string prefixText)
    //{
    //    myClass myclass = new myClass();
    //    string sorgu = "select * from kullanicilar where kullaniciAdi like '" + prefixText + "%'";
    //    DataTable dt = myclass.dataTableGetir(sorgu);
    //    List<string> CityNames = new List<string>();
    //    for (int i = 0; i < dt.Rows.Count; i++)
    //    {
    //        CityNames.Add(dt.Rows[i][1].ToString());
    //    }
    //    return CityNames;
    //}

    //#endregion
}