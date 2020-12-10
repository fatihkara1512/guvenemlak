using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;
namespace guvenemlak
{
    public partial class ilanlarim : System.Web.UI.Page
    {
        string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
        protected void Page_Load(object sender, EventArgs e)
        {


            if (urun_tipi.SelectedValue == "0/0" || urun_tipi.SelectedValue == "0/1")
            {
                konutpaneli.Visible = true;
                isyeripaneli.Visible = false;
            }
            else if (urun_tipi.SelectedValue == "1/0" || urun_tipi.SelectedValue == "1/1")
            {
                isyeripaneli.Visible = true;
                konutpaneli.Visible = false;
            }
            else
            {
                konutpaneli.Visible = false;
                isyeripaneli.Visible = false;
            }
            if (!IsPostBack)
            {

                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    conn.Open();
                    SqlCommand cmd1 = new SqlCommand("SELECT * FROM iller ", conn);
                    SqlDataReader reader = cmd1.ExecuteReader();
                    il_drop.DataSource = reader;
                    il_drop.DataValueField = "id";
                    il_drop.DataTextField = "sehir";
                    il_drop.DataBind();
                }


            }

        }
        public void ilce_getir(string ilce_gir)
        {
          
               string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    conn.Open();
                    SqlCommand cmd1 = new SqlCommand("SELECT * FROM ilceler where sehir='" + ilce_gir + "' order by ilce asc", conn);
                    SqlDataReader reader = cmd1.ExecuteReader();
                    ilce_drop.DataSource = reader;
                    ilce_drop.DataValueField = "id";
                    ilce_drop.DataTextField = "ilce";
                    ilce_drop.DataBind();

                } if (IsPostBack && Session["gecici_ilce"] != null) { ilce_drop.SelectedIndex = int.Parse(Session["gecici_ilce"].ToString()); Session["gecici_ilce"] = null; }
            
        }

        protected void il_drop_SelectedIndexChanged(object sender, EventArgs e)
        {

            ilce_getir(il_drop.SelectedValue);

        }

        protected void guncelle_Click(object sender, EventArgs e)
        {

            string veri = "";
            if (resimupload.HasFile)
            {
                File.Delete(Server.MapPath("~/images/" + Session["gecici_url"]));
                Session["gecici_url"] = null;

                System.Drawing.Bitmap bmpPostedImage = new System.Drawing.Bitmap(resimupload.PostedFile.InputStream);
                System.Drawing.Image objImage = bmpPostedImage;
                FileInfo dosyaismi = new FileInfo(resimupload.FileName);
                objImage.Save(Server.MapPath("images/" + dosyaismi.Name));
                veri = veri + ",url='" + dosyaismi.Name + "'";
            }
            string[] bol = urun_tipi.SelectedValue.Split('/');



            if (urun_tipi.SelectedValue == "0/0" || urun_tipi.SelectedValue == "0/1")
            {
                veri = veri + ",oda_salon_bolum='" + oda_salon.SelectedItem.Text + "',banyo_sayisi='" + banyo.Text +
               "',isinma='" + isinma.SelectedItem.Text + "',bina_yasi='" + bina_k.Text + "'";
            }
            else if (urun_tipi.SelectedValue == "1/0" || urun_tipi.SelectedValue == "1/1")
            {
                veri = veri + ",oda_salon_bolum='" + bolum.Text + "',bina_yasi='" + bina_i.Text + "'";

            }
            else
            {

            }
            string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                string x;
                if (Session["gecici_ilce"] == null) { x = ilce_drop.SelectedItem.Text; }
                else { x = Session["gecici_ilce"].ToString(); }
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"UPDATE ilan SET
                   urun_tipi='" + bol[0] + "',urun_durumu='" + bol[1] +
                     "',urun_adi='" + urun_adi.Text + "',metrekare='" + metrekare.Text +
                     "',aciklama='" + aciklama.Text + "',il='" + il_drop.SelectedItem.Text +
                     "',ilce='" + x + "',urun_fiyat='" + fiyat.Text + "'" + veri + " where ilan_no='" + Session["kontrol_id"] + "'", conn);
                cmd.ExecuteNonQuery();

            }

            Response.Redirect("ilanlarim.aspx?id=" + Session["kontrol_id"] + "");

        }

        protected void kaldir_Click(object sender, EventArgs e)
        {

            string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"DELETE from ilan where ilan_no='" + Session["kontrol_id"] + "'", conn);
                cmd.ExecuteNonQuery();

            }
            File.Delete(Server.MapPath("~/images/" + Session["gecici_url"]));
            Session["gecici_url"] = null;
            Response.Redirect("ilanlarim.aspx");

        }
    }
}