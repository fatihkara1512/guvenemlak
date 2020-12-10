<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="arama.aspx.cs" Inherits="guvenemlak.arama" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
  <div class="row"><div class="col-md-3">
   <table class='table'><tr><td class='text-center'><b>Arama Sonuçları ></b></td></tr></table></div><div class='col-md-9'>
  

         <%if (Request.QueryString["kelime"] != null)
             {
                getir( Request.QueryString["kelime"]);
                 getir(Request.QueryString["kelime"]);
             }
           %>
                   
       </div></div>
</asp:Content>
