﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="arsa.aspx.cs" Inherits="guvenemlak.arsa" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
         <div class="row">
         <div class="col-md-3">
		<div class="filter-content">
			<div class="list-group list-group-flush">
                <a class="list-group-item active">Arsa ></a>
                <a href='arsa_satilik.aspx' class='list-group-item'>Satılık<span class='float-right badge badge-light round'><% Response.Write(durum_sayisi(0));%></span> </a>
			  <a href='arsa_kiralik.aspx' class="list-group-item">Kiralık<span class="float-right badge badge-light round"><% Response.Write(durum_sayisi(1));%></span>  </a>
			</div>  <!-- list-group .// -->
		</div>
	</div>
 
    <div class="col-md-9">
 
                   <%
                       
                       site_master.div_uretici(2);
                
                
                 %>

         

        
         </div>
 </div>
</asp:Content>
