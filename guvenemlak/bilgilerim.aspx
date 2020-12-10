<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="bilgilerim.aspx.cs" Inherits="guvenemlak.bilgilerim" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head2" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="row"><div class="col-md-3">
        		<table class="table"><tr><td class="text-center"><b><asp:Label runat="server" ID="soltaraf" Text="Kişisel Bilgiler >" /></b></td></tr></table>


                     </div><div class="col-md-9">
        <%if(Session["kullanici"]!=null){ %>
         <asp:Panel ID="guncelle" runat="server" >
              <table class="table"><tr><td>
                   <label>Üye Bilgileri :  </label> 
                  <hr /> 
                <div class="form-group ">
                                <label>Ad :  </label> 
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="adg"
                    CssClass="text-danger" ErrorMessage="*" />
                     <asp:TextBox runat="server" Text="" type="text" placeholder="_______________" class="form-control" ID="adg"  />
                                 
                     <hr />
                             <label>Soyad :  </label> 
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="soyadg"
                    CssClass="text-danger" ErrorMessage="*" />
                     <asp:TextBox runat="server" Text="" type="text" placeholder="_______________" class="form-control" ID="soyadg"  />
                                 
                     <hr /> <label>E-Posta :  </label> 

                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="epostag"
                    CssClass="text-danger" ErrorMessage="*" />
                    <asp:RegularExpressionValidator  CssClass="text-danger"  ControlToValidate="epostag" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"  ID="RegularExpressionValidator1" runat="server" ErrorMessage="E-mail Giriniz."></asp:RegularExpressionValidator>
                     <asp:TextBox runat="server" Text="" type="text" placeholder="_______________" class="form-control" ID="epostag"  />
                                 
                     <hr /><label>Şifre :  </label> 
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="sifreg"
                    CssClass="text-danger" ErrorMessage="*" />
                     <asp:TextBox runat="server" Text="" type="text" placeholder="_______________" class="form-control" ID="sifreg"  />
                                 
                     <hr />
                            <asp:Button runat="server" type="submit" Text="GÜNCELLE" class="btn btn-primary" ID="guncellebtn" OnClientClick="alert('Üye Güncellendi.');" OnClick="guncellebtn_Click" />
                             
                            </div></td></tr></table>
              </asp:Panel><%} %>

                                                 </div></div>
</asp:Content>
