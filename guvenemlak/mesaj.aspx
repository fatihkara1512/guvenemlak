<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="mesaj.aspx.cs" Inherits="guvenemlak.mesajlar" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
                    <div class="row">
                    <div class="col-md-3">
                        
                                <%                int sayac = 0;
                                                  if (Session["kullanici"] != null)
                                                  {
                                                      Response.Write("<div class='filter-content'><div class='list-group list-group-flush'><table class='table'><tr><td class='text-center'><b>Gelen Kutusu</b></td></tr></table>");
                                                          string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
                                                          using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(connstring))
                                                          {
                                                              conn.Open();
                                                              System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(@"SELECT * FROM 
                                            uyeler u INNER JOIN mesajlar m ON m.giden_uye_id = u.uye_id where
                                            gelen_uye_id='" + Session["uye_id"] + "' order by mesaj_id desc", conn);
                                                              System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();
                                                              while (reader.Read())
                                                              {
                                                                  Response.Write("<a class='list-group-item");
                                                                  if (sayac == 0){ Session["kontrol_id"] = reader["mesaj_id"].ToString();
                                                                  if (Request.QueryString["id"] == null) { Response.Write(" active"); }
                                                                  }
                                                                  if (Request.QueryString["id"] == reader["mesaj_id"].ToString()) Response.Write(" active");
                                                                  Response.Write("' href='mesaj.aspx?id=" + reader["mesaj_id"] + "'>" + reader["ad"]+" "+reader["soyad"] + "</a>");
                                                                  sayac = 1;
                                                              }
                                                              reader.Close();
                                                              if (Request.QueryString["id"] != null) { Session["kontrol_id"] = Request.QueryString["id"]; }
                                                              Response.Write("</div></div></div><div class='col-md-9'><table class='table'><tr><td><h4>MESAJ : </h4>");
                                                              System.Data.SqlClient.SqlCommand cmd1 = new System.Data.SqlClient.SqlCommand(@"SELECT * FROM 
                                            mesajlar  where gelen_uye_id=
                                            '" + Session["uye_id"] + "' and  mesaj_id='" + Session["kontrol_id"] + "'", conn);
                                                              System.Data.SqlClient.SqlDataReader reader1 = cmd1.ExecuteReader();
                                                              if (reader1.Read())
                                                              {
                                                                  Session["gecici_id"] = reader1["giden_uye_id"];
                                                                  Response.Write(" <hr>" + reader1["mesaj"]);
                                                                  yanit.Visible = true;
                                                              }
                                                          }
                                                      }
                               
                                     %>
                                <asp:Panel ID="yanit" runat="server" Visible="false">
                                                    <hr>
                            <asp:TextBox runat="server"  type="submit" placeholder="Mesajınız..." Height="60px" Width="100%" ID="yanitkutusu" TextMode="MultiLine" />
                            <hr>
                            <asp:Button runat="server" type="submit" Text="Yanıtla" class="btn btn-primary" ID="yanitla" OnClick="yanitla_Click" OnClientClick="alert('Mesajınız Gönderildi.');"/>

                                </asp:Panel>
                         
               </td></tr></table>
                     
    
                    </div>
                    </div>  <asp:MultiView ID="MultiView1" runat="server"><asp:View ID="View1" runat="server">
sadsad</asp:View></asp:MultiView>
</asp:Content>
