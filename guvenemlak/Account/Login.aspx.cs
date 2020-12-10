using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using guvenemlak.Models;
using System.Data.SqlClient;
using System.Configuration;
namespace guvenemlak.Account
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void LogIn(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM uyeler where eposta='" + email.Text + "' and sifre='" + Password.Text + "' ", conn);
                SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read()) {
                    Session["kullanici"]=reader["ad"];
                    Session["soyad"] = reader["soyad"];
                    Session["uye_id"] = reader["uye_id"];
                  
                    IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response);
                }
                else{ FailureText.Text = "Böyle Bir Kullanıcı yok.";
                    ErrorMessage.Visible = true;}
                
                
                   
                
            }
     
        }
    }
}