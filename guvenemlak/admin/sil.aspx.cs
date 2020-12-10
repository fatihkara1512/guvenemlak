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
    public partial class sil : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["admin"] != null)
            {
                string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    conn.Open();
                    SqlCommand cmd = new SqlCommand(@"DELETE from uyeler where uye_id='" + Request.QueryString["id"] + "'", conn);
                    cmd.ExecuteNonQuery();

                }
            }
                Response.Redirect("default.aspx");
        }
    }
}