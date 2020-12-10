<%@ Page Title="" Language="C#" MasterPageFile="~/admin/Site1.Master" AutoEventWireup="true" CodeBehind="cikis.aspx.cs" Inherits="guvenemlak.admin.cikis" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head2" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <%   Session["admin"] = null;
             Session["admin_kullanici"] = null;
             Session["admin_sifre"] = null;
             Session["admin_id"] = null;
             Session["asil_uye_id"] = null;
             Response.Redirect("default.aspx"); %>
</asp:Content>
