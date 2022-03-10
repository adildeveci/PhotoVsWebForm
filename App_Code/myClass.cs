using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI.WebControls;
using System.Drawing;

/// <summary>
/// Summary description for Class1
/// </summary>
public class myClass
{
    public myClass()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    
       private   SqlConnection baglanti= new SqlConnection (WebConfigurationManager.ConnectionStrings["baglanti"].ConnectionString);
       
    
   public int sorguCalistir(string sqlcumle)
    {
        SqlCommand sorgu = new SqlCommand(sqlcumle, this.baglanti);
        
        int sonuc = 0;
        try
        {
            baglanti.Open();
            sonuc = sorgu.ExecuteNonQuery();
        }
        catch (SqlException ex)
        { 
            throw new Exception(ex.Message);
        }
        sorgu.Dispose();
        baglanti.Close();
       
        return (sonuc);
    }

   public object sorguCalistirTekSonuc(string sqlcumle)
   {
       SqlCommand sorgu = new SqlCommand(sqlcumle, this.baglanti); 
       object sonuc= 0;
       try
       { 
           baglanti.Open();
           sonuc = sorgu.ExecuteScalar();
       }
       catch (SqlException ex)
       {
           throw new Exception(ex.Message);
       }
      sorgu.Dispose();
       baglanti.Close(); 
       return (sonuc);
   }
   public DataTable dataTableGetir(string sql)
   {

       SqlDataAdapter adapter = new SqlDataAdapter(sql, this.baglanti);
       DataTable dt = new DataTable();
       try
       {
           adapter.Fill(dt);
       }
       catch (SqlException ex)
       {

           throw new Exception(ex.Message);
       }
       adapter.Dispose(); 
       return dt;

   }

   public  void yukle(FileUpload fu, int Ksize,String klasorAdi, String yeniFotoAdi)
   {
       System.Drawing.Image orjinalFoto = null;
       HttpPostedFile jpeg_image_upload = fu.PostedFile;
       orjinalFoto = System.Drawing.Image.FromStream(jpeg_image_upload.InputStream);
       KucukBoyut(orjinalFoto, Ksize,klasorAdi, yeniFotoAdi);
   }
   protected static void KucukBoyut(System.Drawing.Image orjinalFoto, int boyut,string klasorAdi, string yeniFotoAdi)
   {
       System.Drawing.Bitmap islenmisFotograf = null;
       System.Drawing.Graphics grafik = null;

       int hedefGenislik = boyut;
       int hedefYukseklik = boyut;
       int new_width, new_height;

       new_height = (int)Math.Round(((float)orjinalFoto.Height * (float)boyut) / (float)orjinalFoto.Width);
       new_width = hedefGenislik;
       hedefYukseklik = new_height;
       new_width = new_width > hedefGenislik ? hedefGenislik : new_width;
       new_height = new_height > hedefYukseklik ? hedefYukseklik : new_height;

       islenmisFotograf = new System.Drawing.Bitmap(hedefGenislik, hedefYukseklik);
       grafik = System.Drawing.Graphics.FromImage(islenmisFotograf);
       grafik.FillRectangle(new System.Drawing.SolidBrush(System.Drawing.Color.White), new System.Drawing.Rectangle(0, 0, hedefGenislik, hedefYukseklik));
       int paste_x = (hedefGenislik - new_width) / 2;
       int paste_y = (hedefYukseklik - new_height) / 2;

       grafik.SmoothingMode = System.Drawing.Drawing2D.SmoothingMode.HighQuality;
       grafik.CompositingQuality = System.Drawing.Drawing2D.CompositingQuality.HighQuality;
       grafik.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.Default;

       System.Drawing.Imaging.ImageCodecInfo codec = System.Drawing.Imaging.ImageCodecInfo.GetImageEncoders()[1];
       System.Drawing.Imaging.EncoderParameters eParams = new System.Drawing.Imaging.EncoderParameters(1);
       eParams.Param[0] = new System.Drawing.Imaging.EncoderParameter(System.Drawing.Imaging.Encoder.Quality, 95L);

       grafik.DrawImage(orjinalFoto, paste_x, paste_y, new_width, new_height);



       //çevirmeye çalışıyo bu alttaki kodlar çalışmıyo heralde mq
       if (islenmisFotograf.PropertyIdList.Contains(0x0112))
       {
           int rotationValue = islenmisFotograf.GetPropertyItem(0x0112).Value[0];
           switch (rotationValue)
           {
               case 1: // landscape, do nothing
                   break;

               case 8: // rotated 90 right
                   // de-rotate:
                   islenmisFotograf.RotateFlip(rotateFlipType: RotateFlipType.Rotate270FlipNone);
                   break;

               case 3: // bottoms up
                   islenmisFotograf.RotateFlip(rotateFlipType: RotateFlipType.Rotate180FlipNone);
                   break;

               case 6: // rotated 90 left
                   islenmisFotograf.RotateFlip(rotateFlipType: RotateFlipType.Rotate90FlipNone);
                   break;
           }
       }

       //son halini yükle
       islenmisFotograf.Save(HttpContext.Current.Server.MapPath(klasorAdi + yeniFotoAdi), codec, eParams);
   }

   


}