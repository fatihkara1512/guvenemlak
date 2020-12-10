<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ilanlarim.aspx.cs" Inherits="guvenemlak.ilanlarim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

     <div class="row">
                    <div class="col-md-3">
                        
                                <%      
                                    
                                    if (Request.QueryString["id2"] != null) { Session["asil_uye_id"] = Request.QueryString["id2"]; }
                                    else if (Session["kullanici"]!=null) { Session["asil_uye_id"] = Session["uye_id"].ToString(); }
                            
                                                 int sayac = 0;
                                                  if (Session["kullanici"] != null || Session["admin"]!=null)
                                                  {
                                                      Response.Write("<div class='filter-content'><div class='list-group list-group-flush'><table class='table'><tr><td class='text-center'><b>İlanlarım</b></td></tr></table>");

                                                          string connstring = ConfigurationManager.ConnectionStrings["DBF"].ConnectionString;
                                                          using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(connstring))
                                                          {
                                                            
                                                              conn.Open();
                                                              System.Data.SqlClient.SqlCommand cmd = new System.Data.SqlClient.SqlCommand(@"SELECT * FROM 
                                            ilan i INNER JOIN uyeler u ON i.uye_id = u.uye_id where
                                            i.uye_id='" + Session["asil_uye_id"] + "' order by i.ilan_no desc", conn);
                                                              System.Data.SqlClient.SqlDataReader reader = cmd.ExecuteReader();
                                                              while (reader.Read())
                                                              {
                                                                  Response.Write("<a class='list-group-item");
                                                                  if (sayac == 0)
                                                                  {
                                                                      Session["kontrol_id"] = reader["ilan_no"].ToString();
                                                                      if (Request.QueryString["id"] == null) { Response.Write(" active"); }
                                                                  }
                                                                  if (Request.QueryString["id"] == reader["ilan_no"].ToString()) Response.Write(" active");
                                                                  string urunuzunmu;
                                                                  if (reader["urun_adi"].ToString().Length > 25) {urunuzunmu = reader["urun_adi"].ToString().Substring(0,25) + "...";}
                                                                  else { urunuzunmu = reader["urun_adi"].ToString(); }
                                                                  Response.Write("' href='ilanlarim.aspx?id=" + reader["ilan_no"] + "'>" + urunuzunmu + "</a>");
                                                                  sayac = 1;
                                                              }
                                                              reader.Close();
                                                              if (Request.QueryString["id"] != null) { Session["kontrol_id"] = Request.QueryString["id"]; }
                                                              Response.Write("</div></div></div>");
                                                          }
                                                          Response.Write("<div class='col-md-9'><table class='table'><tr><td><h4>İLAN : </h4><hr>");
                                                    if (!IsPostBack)
                                                    {
                                                       
                                                          using (System.Data.SqlClient.SqlConnection conn = new System.Data.SqlClient.SqlConnection(connstring))
                                                          {
                                                              conn.Open();
                                                              System.Data.SqlClient.SqlCommand cmd1 = new System.Data.SqlClient.SqlCommand(@"SELECT * FROM 
                                                                ilan i INNER JOIN iller l ON i.il = l.sehir
                                                              INNER JOIN ilceler c ON c.ilce = i.ilce
                                                                    where uye_id='" + Session["asil_uye_id"] +
                                                                "' and  ilan_no='" + Session["kontrol_id"] + "'", conn);
                                                              System.Data.SqlClient.SqlDataReader reader1 = cmd1.ExecuteReader();
                                                              if (!reader1.HasRows) { Response.Write("Hiç İlanınız Yok."); ilanguncellemepanel.Visible = false; }
                                                              if (reader1.Read())
                                                              {
                                                                  Session["gecici_id"] = reader1["uye_id"];
                                                                  urun_adi.Text = reader1["urun_adi"].ToString();
                                                                  metrekare.Text = reader1["metrekare"].ToString();
                                                                  Session["gecici_url"] = reader1["url"];
                                                                    ilce_getir(reader1["id"].ToString());
                                                                 il_drop.SelectedValue = reader1["id"].ToString();
                                                                ilce_drop.Items.FindByText(reader1["ilce"].ToString()).Selected = true;
                                                                 Session["gecici_ilce"]=ilce_drop.SelectedIndex;

                                                                  urun_tipi.SelectedValue = (reader1["urun_tipi"].ToString() + "/" + reader1["urun_durumu"]);
                                                                  fiyat.Text = String.Format("{0}",reader1["urun_fiyat"]).Replace(",0000", "");
                                                                  aciklama.Text = reader1["aciklama"].ToString();
                                                                  if (urun_tipi.SelectedValue == "0/0" || urun_tipi.SelectedValue == "0/1")
                                                                  {
                                                                      oda_salon.Items.FindByText(reader1["oda_salon_bolum"].ToString()).Selected = true;
                                                                      banyo.Text = reader1["banyo_sayisi"].ToString();
                                                                      bina_k.Text = reader1["bina_yasi"].ToString();
                                                                      isinma.Items.FindByText(reader1["isinma"].ToString()).Selected = true;
                                                                      konutpaneli.Visible = true;
                                                                      isyeripaneli.Visible = false;
                                                                   
                                                                  }
                                                                  else if (urun_tipi.SelectedValue == "1/0" || urun_tipi.SelectedValue == "1/1")
                                                                  {
                                                                      bolum.Text = reader1["oda_salon_bolum"].ToString();
                                                                      bina_i.Text = reader1["bina_yasi"].ToString();
                                                                      isyeripaneli.Visible = true;
                                                                      konutpaneli.Visible = false;
                                                                  
                                                                  }
                                                                  else
                                                                  {
                                                                      konutpaneli.Visible = false;
                                                                      isyeripaneli.Visible = false;
                                                                  }


                                                                 
                                                              }
          
                                                           
                                                          }

                                                    } ufakresim.ImageUrl = "images/" + Session["gecici_url"].ToString();
                                               
                                                               %>
                        
                        
               <asp:Panel ID="ilanguncellemepanel" runat="server" Visible="true">



      

                         
                          <div class="form-group ">
                                <label>Ürün Adı  </label> 
                              <asp:RequiredFieldValidator runat="server" ControlToValidate="urun_adi"
                    CssClass="text-danger" ErrorMessage="*" />
                     <asp:TextBox runat="server" Text="" type="text" placeholder="_______________" class="form-control" ID="urun_adi"  />
                                 
                     <hr>
                             
                                  <label>Konum</label>
                                  <asp:RequiredFieldValidator runat="server" InitialValue="-1" ControlToValidate="ilce_drop"
                                      CssClass="text-danger" ErrorMessage="*" />
                                  <div class="row">
                                      <div class="col-md-6">
                                          <asp:DropDownList runat="server" ItemType="" class="form-control" ID="il_drop" name="il_drop" AutoPostBack="True" OnSelectedIndexChanged="il_drop_SelectedIndexChanged">
                                          </asp:DropDownList>
                                      </div>
                                      <div class="col-md-6">
                                          <asp:DropDownList runat="server" class="form-control" ID="ilce_drop" AutoPostBack="True">
                                          </asp:DropDownList>
                                      </div>
                                  </div>
                             
                            </div>
                            <hr>
                                   <label>Ürün Tipi  </label> 
                                <asp:RequiredFieldValidator runat="server" InitialValue="-1" ControlToValidate="urun_tipi"
                    CssClass="text-danger" ErrorMessage="*" />
                               <div class="row"><div class="col-md-6">
                     <asp:DropDownList runat="server" class="form-control" id="urun_tipi"  AutoPostBack="True" >
                                  <asp:ListItem  Value="0/0">Konut > Satılık</asp:ListItem>
                                   <asp:ListItem  Value="0/1">Konut > Kiralık</asp:ListItem>
                                   <asp:ListItem  Value="1/0">İşyeri > Satılık</asp:ListItem>
                                  <asp:ListItem  Value="1/1">İşyeri > Kiralık</asp:ListItem>
                                   <asp:ListItem  Value="2/0">Arsa > Satılık</asp:ListItem>
                                    <asp:ListItem  Value="2/1">Arsa > Kiralık</asp:ListItem>
                                </asp:DropDownList>
                                   </div></div>  
                     <hr>
                      <label>Metrekare</label> 
                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="metrekare"
                    CssClass="text-danger" ErrorMessage="*" />
                     <asp:TextBox runat="server" type="text" placeholder="_______________" class="form-control" ID="metrekare"  />
                     <hr>
                                   
                      <label>Fiyat </label> 
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="fiyat"
                    CssClass="text-danger" ErrorMessage="*" />
                     <asp:TextBox runat="server" placeholder="_______________" type="text" class="form-control" ID="fiyat"  />
                     <asp:Panel ID="konutpaneli" runat="server">
                          <hr>
                         <label>Oda/Salon </label> 
                         <asp:RequiredFieldValidator runat="server" InitialValue="-1" ControlToValidate="oda_salon"
                    CssClass="text-danger" ErrorMessage="*" />
                         <div class="row"><div class="col-md-5">
                            <asp:DropDownList runat="server" class="form-control" id="oda_salon"  >
                                  <asp:ListItem   Value="1">1+1</asp:ListItem>
                                   <asp:ListItem  Value="2">2+1</asp:ListItem>
                                   <asp:ListItem  Value="3">3+1</asp:ListItem>
                                   <asp:ListItem  Value="4">4+1</asp:ListItem>
                                   <asp:ListItem  Value="5">5+1</asp:ListItem>
                                </asp:DropDownList>
                             </div></div>
                          <hr>
                          <label>Banyo Sayısı </label> 
                          <asp:RequiredFieldValidator runat="server" ControlToValidate="banyo"
                    CssClass="text-danger" ErrorMessage="*" />
                           <asp:TextBox runat="server" placeholder="_______________" type="text" class="form-control" ID="banyo"  />
                           
                          <hr>
                         <label>Bina Yaşı </label> 
                           <asp:RequiredFieldValidator runat="server" ControlToValidate="bina_k"
                    CssClass="text-danger" ErrorMessage="*" />
                           <asp:TextBox runat="server" placeholder="_______________" type="text" class="form-control" ID="bina_k"  />
                       
                          <hr>
                             
                          <label>Isınma Tipi </label> 
                         <asp:RequiredFieldValidator runat="server" InitialValue="-1" ControlToValidate="isinma"
                    CssClass="text-danger" ErrorMessage="*" />
                         <div class="row"><div class="col-md-5">
                         <asp:DropDownList runat="server" class="form-control" id="isinma" >
                                  <asp:ListItem  Value="0">Güneş Enerjisi</asp:ListItem>
                              <asp:ListItem  Value="1">Enerjisi</asp:ListItem>
                              <asp:ListItem  Value="2">Kat Kaloriferi</asp:ListItem>
                              <asp:ListItem  Value="3">Klima</asp:ListItem>
                              <asp:ListItem  Value="4">Kombi</asp:ListItem>
                              <asp:ListItem  Value="5">Merkezi</asp:ListItem>
                              <asp:ListItem  Value="6">Merkezi (Pay Ölçer)</asp:ListItem>
                              <asp:ListItem  Value="7">Soba</asp:ListItem>
                              <asp:ListItem  Value="8">Jeotermal Isıtma</asp:ListItem>
                              <asp:ListItem  Value="9">Yok</asp:ListItem>
                                </asp:DropDownList>
                              </div></div>
                      
                     </asp:Panel>
                     <asp:Panel ID="isyeripaneli" runat="server" >
                          <hr> 
                           <label>Bölüm/Oda Sayısı </label> 
                              <asp:RequiredFieldValidator runat="server" ControlToValidate="bolum"
                    CssClass="text-danger" ErrorMessage="*" />
                           <asp:TextBox runat="server" placeholder="_______________" type="text" class="form-control" ID="bolum"  />
                      
                          <hr>
                          <label>Bina Yaşı </label> 
                          <asp:RequiredFieldValidator runat="server" ControlToValidate="bina_i"
                    CssClass="text-danger" ErrorMessage="*" />
                           <asp:TextBox runat="server" placeholder="_______________" type="text" class="form-control" ID="bina_i"  />
                           

                     </asp:Panel>
                                <hr>
                     <label>Resmi Güncelle</label> <div class="row"><div class="col-md-5"><br/>
                               <asp:FileUpload ID="resimupload" CssClass="form-control" runat="server" />
                               </div><div class="col-md-5">
                                   <asp:Image runat="server" ID="ufakresim" Width="80px" Height="70px"  />
                                   </div>
                                     </div>
                     <hr>
                     <label>Açıklama</label> 
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="aciklama"
                    CssClass="text-danger" ErrorMessage="*" />
                            <asp:TextBox runat="server" placeholder="Açıklama Bölümü..."  type="submit"  Height="60px" Width="100%" ID="aciklama" TextMode="MultiLine" />
                            <hr>
                            <asp:Button runat="server" type="submit" Text="GÜNCELLE" class="btn btn-primary" ID="guncelle" OnClientClick="alert('İlan Güncellendi.');" OnClick="guncelle_Click"  />
     <asp:Button runat="server" type="submit" Text="KALDIR" class="btn btn-primary" ID="kaldir" OnClientClick="alert('İlan Silindi.');" OnClick="kaldir_Click"  />

                                </asp:Panel>
                 
           <%     } %>
                        
                        
                    
   </td></tr> </table>

                   </div>

     </div>
</asp:Content>
