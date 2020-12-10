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
    public partial class bilgilerim : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("SELECT * FROM uyeler where uye_id='" + Session["uye_id"] + "' ", conn);
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
        }
        protected void guncellebtn_Click(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand(@"UPDATE uyeler SET
                   ad='" + adg.Text + "',soyad='" + soyadg.Text +
                     "',eposta='" + epostag.Text + "',sifre='" + sifreg.Text + "' where uye_id='" + Session["uye_id"] + "'", conn);
                cmd.ExecuteNonQuery();

            }

            Response.Redirect("default.aspx");
        }
    }
}