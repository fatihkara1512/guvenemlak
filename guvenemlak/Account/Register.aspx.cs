using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using guvenemlak.Models;
using System.Configuration;
using System.Data.SqlClient;

namespace guvenemlak.Account
{
    public partial class Register : Page
    {
        protected void CreateUser_Click(object sender, EventArgs e)
        {

             string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
             using (SqlConnection conn = new SqlConnection(connstring))
             {
                 try
                 {
                     conn.Open();
                     SqlCommand cmd = new SqlCommand("INSERT INTO uyeler (ad,soyad,eposta,sifre) VALUES ('" + name.Text + "','" + surname.Text + "','" + email.Text + "','" + Password.Text + "')", conn);
                     cmd.ExecuteNonQuery();
                     SqlCommand cmd1 = new SqlCommand("SELECT * FROM uyeler where eposta='" + email.Text + "' and sifre='" + Password.Text + "'", conn);
                     SqlDataReader reader = cmd1.ExecuteReader();
                     if (reader.Read())
                     {
                         Session["kullanici"] = reader["ad"];
                         Session["soyad"] = reader["soyad"];
                         Session["uye_id"] = reader["uye_id"];

                         IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                     }
                 }
                 catch {  ErrorMessage.Text = "Kayıt Başarısız."; }
               

             }
             
 
        }
     }
}
