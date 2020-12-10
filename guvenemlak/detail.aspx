<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="detail.aspx.cs" Inherits="guvenemlak.detail" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
       
     <div class="row">
         <div class="col-md-5"><% 
                                   try { 
                        string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
                        using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(connstring)) 
                        {
                            conn.Open();
                            System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand("SELECT * FROM ilan where ilan_no='" + Request.QueryString[0] + "' ", conn);
                            System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();
                            if (reader.Read())
                            {
                                string[] bol = reader["ilan_tarihi"].ToString().Split(' ');
                                Session["gecici_id"]= reader["uye_id"].ToString();
                                Response.Write("<img class='img-buyuk' src='images/" + reader[9] + "'></div> <div class='col-md-4'>");
                                Response.Write("<table class='table'>");
                                Response.Write("<tr><td colspan='2' align='center'><h4>Ürün Bilgileri</h4></td></tr>");
                                Response.Write("<tr ><td  colspan='2' align='center' class='satir1'>" + String.Format("{0:C}",reader["urun_fiyat"]).Replace(",00", "") + "</td></tr>");
                                Response.Write("<tr ><td colspan='2' align='center' style='color:red;' class='satir2'>İlan No : " + reader["ilan_no"] + "</td></tr>");
                                Response.Write("<tr ><td colspan='2' align='center' class='satir1'>" + reader["il"] +" / "+ reader["ilce"] + "</td></tr>");
                                Response.Write("<tr ><td>Net Metrekare</td><td width='50%' class='satir2'>" + reader["metrekare"] + " m²</td></tr>");
                                Response.Write("<tr' ><td  class='satir1'>İlan Tarihi</td><td width='50%'  class='satir1'>" +  bol[0]+ "</td></tr>");

                                if (reader["urun_tipi"].ToString() == "0")
                                {
                                    Response.Write("<tr ><td>Oda + Salon</td><td width='50%' class='satir2'>" + reader["oda_salon_bolum"] + "</td></tr>");
                                    Response.Write("<tr' ><td  class='satir1'>Bina Yaşı</td><td width='50%'  class='satir1'>" + reader["bina_yasi"] + "</td></tr>");
                                    Response.Write("<tr ><td>Isınma Tipi</td><td width='50%' class='satir2'>" + reader["isinma"] + "</td></tr>");
                                    Response.Write("<tr' ><td  class='satir1'>Banyo Sayısı</td><td width='50%'  class='satir1'>" + reader["banyo_sayisi"] + "</td></tr>");
                                }
                                else if (reader["urun_tipi"].ToString() == "1")
                                {
                                    Response.Write("<tr ><td>Bölüm</td><td width='50%' class='satir2'>" + reader["oda_salon_bolum"] + "</td></tr>");
                                    Response.Write("<tr' ><td  class='satir1'>Bina Yaşı</td><td width='50%'  class='satir1'>" + reader["bina_yasi"] + "</td></tr>");
                                }
                                
                                Response.Write("</table></div>");
                                
                                %>
             <div class='col-md-3'>
                 <asp:Panel ID="mesajpaneliacik" runat="server" Visible="false">
                        <div class="list-group-item">
                            <div class="form-group text-center">
                              <label>  Mesaj Kutusu</label>
                          

                            <hr>
                            <asp:TextBox runat="server"  type="submit" placeholder="Mesajınız..." Height="60px" Width="100%" ID="mesajkutusu" TextMode="MultiLine" />
                            <hr>
                            <asp:Button runat="server" type="submit" Text="GÖNDER" class="btn btn-primary" ID="mesajgonder" OnClientClick="alert('Mesajınız Gönderildi.');" OnClick="mesajgonder_Click" />
                            </div>
                        </div>
                     </asp:Panel>
                   <asp:Panel ID="mesajpanelikapali" runat="server" Visible="false">
                        <div class="list-group-item">
                            <div class="form-group text-center">
                              <label>  Mesaj Kutusu</label>

                            <hr>
                           MESAJ GÖNDERMEK İÇİN<br><u><a href="/Account/Register.aspx" style="color:blue;">KAYIT OL</a></u>
                            </div>
                        </div>
                     </asp:Panel>
                    </div>
                </div>
             
             <%
                                Response.Write("<br><div class='row'><div class='col-md-9'><table class='table'><tr><td><h4><b>Açıklamalar</b><h4></td></tr>");
                                Response.Write("<tr><td>" + reader["aciklama"] + "</td></tr></table></div></div>");
                            }
                        }
                                   }
                                   catch { }
                %>
                  
</asp:Content>
