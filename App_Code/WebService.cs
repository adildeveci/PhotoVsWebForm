using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;

/// <summary>
/// Summary description for WebService
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[System.Web.Script.Services.ScriptService]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
 // [System.Web.Script.Services.ScriptService]
public class WebService : System.Web.Services.WebService {

    public WebService () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }
    [WebMethod]
    
    public  List<string> getKullanici(string prefixText)
    {
        myClass myclass = new myClass();
        DataTable dt = myclass.dataTableGetir("select * from kullanicilar where kullaniciAdi like '"+prefixText+"%'");
         
        List<string> firstname = new List<string>();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            firstname.Add(dt.Rows[i]["kullaniciAdi"].ToString());
        }
        return firstname;
    }
}
