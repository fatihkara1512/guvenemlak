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
    public partial class konut : System.Web.UI.Page
    {
        public static int durum_sayisi(int sayi)
        {


            string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                conn.Open();

                SqlCommand cmd1 = new SqlCommand("SELECT COUNT(*) FROM ilan where urun_tipi='0' and urun_durumu='" + sayi + "'", conn);
                sayi = (Int32)cmd1.ExecuteScalar();


            }
            return sayi;


        }
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
    }
}