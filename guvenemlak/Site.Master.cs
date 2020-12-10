using System;
using System.Collections.Generic;
using System.Security.Claims;
using System.Security.Principal;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
namespace guvenemlak
{
    public partial class SiteMaster : MasterPage
    {
        private const string AntiXsrfTokenKey = "__AntiXsrfToken";
        private const string AntiXsrfUserNameKey = "__AntiXsrfUserName";
        private string _antiXsrfTokenValue;
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            Page.Header.DataBind();
        }
        public static void div_uretici(int t)
        {
            int i = 0;
            string veri = "";
            if (t != 3) { veri = "where urun_tipi='" + t + "'"; }

            string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(connstring))
            {
                conn.Open();
                SqlCommand cmd = new SqlCommand("SELECT count(*) FROM ilan "+veri+" ", conn);
                int kayitsayisi = Convert.ToInt32(cmd.ExecuteScalar());
                SqlCommand cmd1 = new SqlCommand("SELECT ilan_no,urun_tipi,urun_durumu,il,ilce,url FROM ilan " + veri + " order by ilan_no desc ", conn);
                SqlDataReader reader = cmd1.ExecuteReader();
                while (reader.Read())
                {

                    if (i % 4 == 0 && i != 0) { HttpContext.Current.Response.Write("<hr>"); }
                    if (i % 4 == 0) { HttpContext.Current.Response.Write("<div class='row'>"); }
                    HttpContext.Current.Response.Write(" <a href=detail.aspx?ilan_no=" + reader[0] + " class='a-temp'> ");
                    HttpContext.Current.Response.Write("<div class='col-md-3' >");
                    HttpContext.Current.Response.Write("<img class='img-yedek' src='images/" + reader[5] + "'>");
                    HttpContext.Current.Response.Write("<p class='tip'>");
                    HttpContext.Current.Response.Write(urun_tipi(int.Parse(reader[1].ToString())) + " ");
                    HttpContext.Current.Response.Write(urun_durumu(int.Parse(reader[2].ToString())) + "</p>");
                    HttpContext.Current.Response.Write("<p class='ililce'>" + reader[3] + " / " + reader[4] + "</p></div></a>");
                    i++;
                    if (i % 4 == 0 || i == kayitsayisi) { HttpContext.Current.Response.Write("</div>"); }

                }


            }
        }
            public static void kategori_uretici(int t,int d){
                string il=HttpContext.Current.Request.QueryString["il"],
                    ilce=HttpContext.Current.Request.QueryString["ilce"],
                    maz=HttpContext.Current.Request.QueryString["maz"],
                    mcok=HttpContext.Current.Request.QueryString["mcok"],
                    faz=HttpContext.Current.Request.QueryString["faz"],
                    fcok=HttpContext.Current.Request.QueryString["fcok"];
                        if (il != null) il = " and il='" + il + "'";
                        if (ilce != null) ilce = " and ilce='" + ilce + "'";
                        if (maz != null) maz = " and metrekare >='" + maz + "'";
                        if (mcok != null) mcok = " and metrekare <='" + mcok + "'";
                        if (faz != null) faz = " and urun_fiyat >='" + faz + "'";
                        if (fcok != null) fcok = " and urun_fiyat <='" + fcok + "'";
         string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connstring))
            {
                HttpContext.Current.Response.Write(@"<table class='table table-hover'>
                <thead><tr><th>Ürün</th><th class='text-center'>Konum</th><th class='text-center'>
                Tarih</th><th class='text-center'>M²</th><th class='text-center'>Fiyat </th></tr>
                </thead><tbody>");
                conn.Open();
                SqlCommand cmd1 = new SqlCommand(@"SELECT ilan_no,il,ilce,url,ilan_tarihi,
                metrekare,urun_adi,urun_fiyat FROM ilan where
                urun_tipi='" + t + "' and urun_durumu='" + d + "'" + il + ilce + maz + mcok + faz + fcok + "", conn);
                SqlDataReader reader = cmd1.ExecuteReader();
                while (reader.Read())
                {
                    string[] bol = reader[4].ToString().Split(' ');
                    HttpContext.Current.Response.Write("<tr><td><div class='media'><a class='thumbnail pull-left' href='detail.aspx?ilan_no=" + reader[0] + "'> <img class='media-object' src='images/" + reader[3] + "' style='width: 72px; height: 72px;'> </a>");
                    HttpContext.Current.Response.Write("<div class='media-body'><h4 class='media-heading'><a href='detail.aspx?ilan_no=" + reader[0] + "'>" + reader[6] + "</a></h4></div></div></td>");
                    HttpContext.Current.Response.Write("<td style='text-align: center'>"+reader[1]+" /<br />" +reader[2]+" </td>");
                    HttpContext.Current.Response.Write("<td class='text-center'><strong>" + bol[0] + "</strong></td><td class='text-center'>" + reader[5] + "</td><td  class='text-center'>");
                    HttpContext.Current.Response.Write("<strong>" + String.Format("{0:C}",reader[7] ).Replace(",00", "") + "</strong></a></td></tr>");
                }
                HttpContext.Current.Response.Write("</table>");
            }
                    

    }

        
        
        public static int tip_sayisi(int sayi)
        {

          
                string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
                using (SqlConnection conn = new SqlConnection(connstring))
                {
                    conn.Open();
                    
                        SqlCommand cmd1 = new SqlCommand("SELECT COUNT(*) FROM ilan where urun_tipi='" + sayi + "'", conn);
                        sayi = (Int32)cmd1.ExecuteScalar();
                    

                }
            return sayi;


            }

        public static string urun_tipi(int x)
        {
            string sonuc = "";
            if (x == 0) { sonuc = "Konut"; }
            else if (x == 1) { sonuc = "İşyeri"; }
            else if (x == 2) { sonuc = "Arsa"; }
            return sonuc;
        }
        public static string urun_durumu(int x)
        {
            string sonuc = "";
            if (x == 0) { sonuc = "Satılık"; }
            else if (x == 1) { sonuc = "Kiralık"; }
            return sonuc;
        }
        protected void Page_Init(object sender, EventArgs e)
        {
            // The code below helps to protect against XSRF attacks
            var requestCookie = Request.Cookies[AntiXsrfTokenKey];
            Guid requestCookieGuidValue;
            if (requestCookie != null && Guid.TryParse(requestCookie.Value, out requestCookieGuidValue))
            {
                // Use the Anti-XSRF token from the cookie
                _antiXsrfTokenValue = requestCookie.Value;
                Page.ViewStateUserKey = _antiXsrfTokenValue;
            }
            else
            {
                // Generate a new Anti-XSRF token and save to the cookie
                _antiXsrfTokenValue = Guid.NewGuid().ToString("N");
                Page.ViewStateUserKey = _antiXsrfTokenValue;

                var responseCookie = new HttpCookie(AntiXsrfTokenKey)
                {
                    HttpOnly = true,
                    Value = _antiXsrfTokenValue
                };
                if (FormsAuthentication.RequireSSL && Request.IsSecureConnection)
                {
                    responseCookie.Secure = true;
                }
                Response.Cookies.Set(responseCookie);
            }

            Page.PreLoad += master_Page_PreLoad;
        }

        protected void master_Page_PreLoad(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Set Anti-XSRF token
                ViewState[AntiXsrfTokenKey] = Page.ViewStateUserKey;
                ViewState[AntiXsrfUserNameKey] = Context.User.Identity.Name ?? String.Empty;
            }
            else
            {
                // Validate the Anti-XSRF token
                if ((string)ViewState[AntiXsrfTokenKey] != _antiXsrfTokenValue
                    || (string)ViewState[AntiXsrfUserNameKey] != (Context.User.Identity.Name ?? String.Empty))
                {
                    throw new InvalidOperationException("Validation of Anti-XSRF token failed.");
                }
            }
        }
        ListItem i = new ListItem("İlçe Seçiniz", "-1");
        protected void Page_Load(object sender, EventArgs e){
            if (Session["kullanici"] != null)
            {
                basarili.Visible = true;
                basarisiz.Visible = false;
            }
            else
            {
                basarisiz.Visible = true;
                basarili.Visible = false;
            }

            // il ilçe dropdownlistesi
            ilce_drop.Items.Insert(0, i);
            if (!IsPostBack)
            {
               
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

            if (Request.Path == "/Contact" || Request.Path == "/About"
                   || Request.Path == "/Account/Login" || Request.Path == "/Account/Register")
            { aramapanel.Visible = false; }

            if (Request.Path == "/konut_satilik" || Request.Path == "/konut_kiralik"
              || Request.Path == "/isyeri_satilik" || Request.Path == "/isyeri_kiralik"
              || Request.Path == "/arsa_satilik" || Request.Path == "/arsa_kiralik")
            { kategori.Visible = true; }
           
        }
        protected void il_drop_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (il_drop.SelectedValue == "-1") {  ilce_drop.Items.Clear();
            ilce_drop.Items.Insert(0, i);
            ilce_drop.SelectedIndex = 0;
            }
            else{

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

        protected void Unnamed_LoggingOut(object sender, LoginCancelEventArgs e)
        {
            Context.GetOwinContext().Authentication.SignOut();
        }
        public string ilkmi = ".aspx?";
        public void sorgu(int s)
        {
            if (s != 0) { ilkmi = "&"; }


        }
        protected void filtreara_Click(object sender, EventArgs e)
        {
            int s = 0;
            
            string url="~"+Request.Path;
            if (il_drop.SelectedValue != "-1") { url = url + ilkmi + "il=" + il_drop.SelectedItem.ToString(); s++; }
            sorgu(s);
            if (ilce_drop.SelectedValue != "-1") { url = url + ilkmi+"ilce=" + ilce_drop.SelectedItem.ToString(); s++;}
            sorgu(s);
            if (maz.Text != "") { url = url + ilkmi+"maz=" + maz.Text; s++; }
            sorgu(s);
            if (mcok.Text != "") { url = url + ilkmi + "mcok=" + mcok.Text; s++; }
            sorgu(s);
            if (faz.Text != "") { url = url + ilkmi + "faz=" + faz.Text; s++; }
            sorgu(s);
            if (fcok.Text != "") { url = url + ilkmi + "fcok=" + fcok.Text; s++; }
            Response.Redirect(url);
        }

        protected void btnaramayap_Click(object sender, EventArgs e)
        {
            Response.Redirect("arama.aspx?kelime="+aramayap.Text+"");
        }

   
    }

}