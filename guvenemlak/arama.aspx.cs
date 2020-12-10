using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
namespace guvenemlak
{
    public partial class arama : System.Web.UI.Page
    {
        public string FieldText
        {
            get { return noresult.Text; }
            set { noresult.Text = value; }
        }
        protected void Page_Load(object sender, EventArgs e)
        {
        }
        public static void getir(string ilan)
        {
            try {
                string kes = ilan.Trim();
                string[] bol = kes.Split(' ');
        Boolean numeric = true;
        try {
            int.Parse(bol[0]);
        } catch {
            numeric = false;
        }
            string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                string sorgu = "";
                conn.Open();
                if (bol.Length == 1 && numeric)
                {
                    sorgu = @"SELECT ilan_no,il,ilce,url,ilan_tarihi, 
                metrekare,urun_adi,urun_fiyat FROM ilan where
                ilan_no='" + bol[0] + "'";

                }
                else if (bol.Length == 1 && bol[0] != "")
                {
                    sorgu = @"SELECT ilan_no,il,ilce,url,ilan_tarihi,
                    metrekare,urun_adi,urun_fiyat FROM ilan where 
                    il like '%" + bol[0] + "%' or ilce like '%" + bol[0] + "%' ";
                }
                else if (bol.Length != 0)
                {
                    sorgu = @"SELECT ilan_no,il,ilce,url,ilan_tarihi, 
                metrekare,urun_adi,urun_fiyat FROM ilan where
                (il like '%" + bol[0] + "%' and ilce like '%" + bol[1] +
                    "%') or (il like '%" + bol[1] + "%' and ilce like '%" + bol[0] + "%')";
                }
                SqlCommand cmd = new SqlCommand(sorgu, conn);
                SqlDataReader reader = cmd.ExecuteReader();

              

                if (reader.HasRows)
                {
                    HttpContext.Current.Response.Write(@"<table class='table table-hover'>
                <thead><tr><th>Ürün</th><th class='text-center'>Konum</th><th class='text-center'>
                Tarih</th><th class='text-center'>M²</th><th class='text-center'>Fiyat </th></tr>
                </thead><tbody>");
                    while (reader.Read())
                    {
                        string[] bol2 = reader[4].ToString().Split(' ');
                        HttpContext.Current.Response.Write("<tr><td><div class='media'><a class='thumbnail pull-left' href='detail.aspx?ilan_no=" + reader[0] + "'> <img class='media-object' src='images/" + reader[3] + "' style='width: 72px; height: 72px;'> </a>");
                        HttpContext.Current.Response.Write("<div class='media-body'><h4 class='media-heading'><a href='detail.aspx?ilan_no=" + reader[0] + "'>" + reader[6] + "</a></h4></div></div></td>");
                        HttpContext.Current.Response.Write("<td style='text-align: center'>" + reader[1] + " /<br/> " + reader[2] + " </td>");
                        HttpContext.Current.Response.Write("<td class='text-center'><strong>" + bol2[0] + "</strong></td><td class='text-center'>" + reader[5] + "</td><td  class='text-center'>");
                        HttpContext.Current.Response.Write("<strong>" + String.Format("{0:C}", reader[7]).Replace(",00", "") + "</strong></a></td></tr>");
                    }

                    HttpContext.Current.Response.Write("</table>");
                }
                else { HttpContext.Current.Response.Write("Sonuç Bulunamadı."); }
            }
            }
            catch{
                HttpContext.Current.Response.Write("Sonuç Bulunamadı.");
            }
         
        }
    }
}