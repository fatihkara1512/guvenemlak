using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
namespace guvenemlak.admin
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM uyeler where uye_id='" + Request.QueryString["id"] + "' ", conn);
                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        adg.Text = reader["ad"].ToString();
                        soyadg.Text = reader["soyad"].ToString();
                        epostag.Text = reader["eposta"].ToString();
                        sifreg.Text = reader["sifre"].ToString();
                    }
                }
            }


            if ((Request.Path == "/admin/default" || Request.Path == "/admin/default.aspx") && Session["admin"] != null)
            { defaults.Visible = true; }
            if (Request.Path == "/admin/guncelle" && Session["admin"] != null)
            { guncelle.Visible = true; soltaraf.Text = "Güncelle >"; }
            if (Request.Path == "/admin/ekle" && Session["admin"] != null)
            { eklemepanel.Visible = true; soltaraf.Text = "Üye Ekle >"; }
            if (Session["admin"] == null)
            {
                isonline.Visible = true;

            }
            else
            {
                basarili.Visible = true;
                isonline.Visible = false;
            }
        }
        public static void kisi_getir()
        {

            string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM uyeler ", conn);
                SqlDataReader reader = cmd.ExecuteReader();
                while (reader.Read())
                {
                    HttpContext.Current.Response.Write(@" <tr>
                        <td>"+reader["ad"]+" "+reader["soyad"]+@"</td>
                        <td>"+reader["eposta"]+@"</td>
                        <td>"+reader["sifre"]+ @"</td>
                        <td>
							<a class='edit' href='guncelle.aspx?id=" + reader["uye_id"] + @"' style='cursor: pointer;'  data-toggle='tooltip' data-original-title='Add'><i class='glyphicon glyphicon-pencil'></i></a>
                          &nbsp <a class='delete' href='sil.aspx?id=" + reader["uye_id"] + @"' style='cursor: pointer;'  data-toggle='tooltip' data-original-title='Edit'><i class='glyphicon glyphicon-remove'></i></a>
                          &nbsp <a  href='../ilanlarim.aspx?id2=" + reader["uye_id"] + @"' style='cursor: pointer;'  data-toggle='tooltip' data-original-title='Edit'><i class='glyphicon glyphicon-eye-open'></i></a>

</td>
                    </tr>");
                }





            }

        }

        protected void Unnamed4_Click(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT * FROM admin where admin_kullanici='" + k_id.Text + "' and admin_sifre='" + sifre.Text + "' ", conn);
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    Session["admin"] = reader["admin_kullanici"];
                    Session["admin_ad"] = reader["admin_ad"];
                    Session["admin_soyad"] = reader["admin_soyad"];
                    Session["admin_id"] = reader["admin_id"];

                    Response.Redirect("default.aspx");
                }
                else
                {
                    FailureText.Text = "Böyle Bir Kullanıcı yok.";
                    ErrorMessage.Visible = true;
                }




            }
        }

        protected void guncellebtn_Click(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"UPDATE uyeler SET
                   ad='" + adg.Text + "',soyad='" + soyadg.Text +
                     "',eposta='" + epostag.Text + "',sifre='" + sifreg.Text +"' where uye_id='"+Request.QueryString["id"]+"'", conn);
                cmd.ExecuteNonQuery();

            }

            Response.Redirect("default.aspx");
        }

        protected void ekle_Click(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"INSERT INTO uyeler
                   (ad,soyad,eposta,sifre)VALUES ('"+ade.Text+"','"+soyade.Text+"','"+epostae.Text+"','"+sifree.Text+"')", conn);
                cmd.ExecuteNonQuery();

            }

            Response.Redirect("default.aspx");
        }
    }
}