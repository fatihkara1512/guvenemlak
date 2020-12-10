<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="cikis.aspx.cs" Inherits="guvenemlak.cikis" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <%   Session["kullanici"] = null;
         Session["soyad"] = null;
         Session["uye_id"] = null;
       guvenemlak.IdentityHelper.RedirectToReturnUrl(Request.QueryString["ReturnUrl"], Response); %>
</asp:Content>
