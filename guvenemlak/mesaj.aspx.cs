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
    public partial class mesajlar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void yanitla_Click(object sender, EventArgs e)
        {
            string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                try
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand("INSERT INTO mesajlar (mesaj,giden_uye_id,gelen_uye_id) VALUES ('" + yanitkutusu.Text + "','" + Session["uye_id"] + "','" + Session["gecici_id"] + "')", conn);
                    cmd.ExecuteNonQuery();
                    Response.Redirect("mesaj.aspx");
                }
                catch
                {
                } yanitkutusu.Text = null;
                Session["gecici_id"] = null;

            } 
        }
    }
}