<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ilanekle.aspx.cs" Inherits="guvenemlak.ilanekle" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="ilaneklemepaneli" runat="server" Visible="false">
         <div class="row"><div class="col-md-3">
                                     <table class='table'><tr><td class='text-center'><b>İlan > Ekle</b></td></tr></table></div><div class='col-md-9'>

      

                           <table class="table"><tr><td>
                          <div class="form-group ">
                                <label>Ürün Adı  </label> 
                              <asp:RequiredFieldValidator runat="server" ControlToValidate="urun_adi"
                    CssClass="text-danger" ErrorMessage="*" />
                     <asp:TextBox runat="server" type="text" placeholder="_______________" class="form-control" ID="urun_adi"  />
                                 
                     <hr>
                                <label>Konum</label> 
                                <asp:RequiredFieldValidator runat="server" InitialValue="-1" ControlToValidate="ilce_drop"
                    CssClass="text-danger" ErrorMessage="*" />
                              <div class="row">
                                <div class="col-md-6">
                                <asp:DropDownList runat="server" class="form-control" id="il_drop" name="il_drop" AutoPostBack="True" OnSelectedIndexChanged="il_drop_SelectedIndexChanged" >
                                </asp:DropDownList></div><div class="col-md-6">
                                 <asp:DropDownList runat="server" class="form-control" id="ilce_drop" name="ilce_drop">
                                </asp:DropDownList>
                                    </div></div>
                            </div>
                            <hr>
                                   <label>Ürün Tipi  </label> 
                                <asp:RequiredFieldValidator runat="server" InitialValue="-1" ControlToValidate="urun_tipi"
                    CssClass="text-danger" ErrorMessage="*" />
                               <div class="row"><div class="col-md-6">
                     <asp:DropDownList runat="server" class="form-control" id="urun_tipi"  AutoPostBack="True" >
                             <asp:ListItem Selected="True" Value="-1">Tip Seçiniz</asp:ListItem>
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
                             <asp:ListItem Selected="True" Value="-1">Seçiniz</asp:ListItem>
                                  <asp:ListItem  Value="0">1+1</asp:ListItem>
                                   <asp:ListItem  Value="1">2+1</asp:ListItem>
                                   <asp:ListItem  Value="2">3+1</asp:ListItem>
                                   <asp:ListItem  Value="3">4+1</asp:ListItem>
                                   <asp:ListItem  Value="4">5+1</asp:ListItem>
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
                                   <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="bina_k" ErrorMessage="*"  CssClass="text-danger" MaximumValue="255" MinimumValue="0" Type="Integer"></asp:RangeValidator>

                           <asp:TextBox runat="server" placeholder="_______________" type="text" class="form-control" ID="bina_k"  />
                       
                          <hr>
                             
                          <label>Isınma Tipi </label> 
                         <asp:RequiredFieldValidator runat="server" InitialValue="-1" ControlToValidate="isinma"
                    CssClass="text-danger" ErrorMessage="*" />
                         <div class="row"><div class="col-md-5">
                         <asp:DropDownList runat="server" class="form-control" id="isinma" >
                                  <asp:ListItem Selected="True"  Value="-1">Seçiniz</asp:ListItem>
                                  <asp:ListItem  Value="1">Güneş Enerjisi</asp:ListItem>
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
                                   <asp:RangeValidator ID="RangeValidator2" runat="server" ControlToValidate="bina_i" ErrorMessage="*"  CssClass="text-danger" MaximumValue="255" MinimumValue="0" Type="Integer"></asp:RangeValidator>

                           <asp:TextBox runat="server" placeholder="_______________" type="text" class="form-control" ID="bina_i"  />
                           

                     </asp:Panel>
                                <hr />
                     <label>Resim Yükle</label> 
                                 <asp:RequiredFieldValidator runat="server" ControlToValidate="resimupload"
                    CssClass="text-danger" ErrorMessage="*" />
                               <asp:FileUpload ID="resimupload" CssClass="form-control" runat="server" />
                               
                     <hr>
                     <label>Açıklama</label> 
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="aciklama"
                    CssClass="text-danger" ErrorMessage="*" />
                            <asp:TextBox runat="server" placeholder="Açıklama Bölümü..."  type="submit"  Height="60px" Width="100%" ID="aciklama" TextMode="MultiLine" />
                            <hr />
                            <asp:Button runat="server" type="submit" Text="EKLE" class="btn btn-primary" ID="ekle" OnClientClick="alert('İlan Eklendi.');" OnClick="ekle_Click"  />
                                    </td></tr></table>
                                           </div></div>
                               </asp:Panel>
                                       
</asp:Content>
