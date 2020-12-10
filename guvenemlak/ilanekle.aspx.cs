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
    public partial class ilanekle : System.Web.UI.Page
    {
        ListItem i = new ListItem("İlçe Seçiniz", "-1");
        
        protected void Page_Load(object sender, EventArgs e)
        {
            if(Session["kullanici"]!=null){ilaneklemepaneli.Visible=true;}
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
                ilce_drop.Items.Insert(0, i);
               
                string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    conn.Open();
                    SqlCommand cmd1 = new SqlCommand("SELECT * FROM iller ", conn);
                    SqlDataReader reader = cmd1.ExecuteReader();
                    il_drop.DataSource = reader;
                    il_drop.DataValueField = "id";
                    il_drop.DataTextField = "sehir";
                    il_drop.DataBind();
                    ListItem li = new ListItem("İl Seçiniz", "-1");
                    il_drop.Items.Insert(0, li);
                    il_drop.SelectedIndex = 0;

                }

            }
        }

        protected void il_drop_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (il_drop.SelectedValue == "-1")
            {
                ilce_drop.Items.Clear();
                ilce_drop.Items.Insert(0, i);
                ilce_drop.SelectedIndex = 0;
            }
            else
            {

                string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    conn.Open();
                    SqlCommand cmd1 = new SqlCommand("SELECT * FROM ilceler where sehir='" + il_drop.SelectedValue + "' order by ilce asc", conn);
                    SqlDataReader reader = cmd1.ExecuteReader();
                    ilce_drop.DataSource = reader;
                    ilce_drop.DataValueField = "id";
                    ilce_drop.DataTextField = "ilce";
                    ilce_drop.DataBind();

                }

            }
        }
        protected void ekle_Click(object sender, EventArgs e)
        {
            string veri1="";
            string veri2 = "";
            System.Drawing.Bitmap bmpPostedImage = new System.Drawing.Bitmap(resimupload.PostedFile.InputStream);
            System.Drawing.Image objImage = bmpPostedImage;
            FileInfo dosyaismi = new FileInfo(resimupload.FileName);
            objImage.Save(Server.MapPath("images/" + dosyaismi.Name));
           string[] bol = urun_tipi.SelectedValue.Split('/') ;
           if (urun_tipi.SelectedValue == "0/0" || urun_tipi.SelectedValue == "0/1")
           {
               veri1 = veri1 + ",oda_salon_bolum,banyo_sayisi,isinma,bina_yasi";
               veri2 = veri2 + ",'" + oda_salon.SelectedItem.Text + "','" + banyo.Text + "' ,'" + isinma.SelectedItem.Text + "','" + bina_k.Text + "'";
           }
           else if (urun_tipi.SelectedValue == "1/0" || urun_tipi.SelectedValue == "1/1")
           {
               veri1 = veri1 + ",oda_salon_bolum,bina_yasi";
               veri2 = veri2 + ",'" + bolum.Text + "','" + bina_i.Text + "'";
           }
           else
           {
            
           }
           int id;
          string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
          using (SqlConnection conn = new SqlConnection(connstring))
          {
              conn.Open();
              SqlCommand cmd = new SqlCommand(@"INSERT INTO ilan
                   (urun_tipi,urun_durumu,urun_adi,metrekare,aciklama,uye_id,il,ilce,url,
                   ilan_tarihi,urun_fiyat"+veri1+
            ") output INSERTED.ilan_no VALUES('" + bol[0] + "','" + bol[1] + "','" +
        urun_adi.Text + "','" + metrekare.Text +
        "','" + aciklama.Text + "','" + Session["uye_id"] +
        "','" + il_drop.SelectedItem.Text + "','" + ilce_drop.SelectedItem.Text + "','" +
        dosyaismi.Name + "','" + DateTime.Now.ToString("MM/dd/yyyy") +
        "','" + fiyat.Text + "'"+veri2+")", conn);
               id = (int)cmd.ExecuteScalar();
          }

          Response.Redirect("detail.aspx?ilan_no=" + id);
        
        }


    }
}