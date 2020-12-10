<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="guvenemlak._Default" %>
<asp:Content runat="server" ContentPlaceHolderID="head2">
      
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
     <div class="row">
         <div class="col-md-3">
		<div class="filter-content">
			<div class="list-group list-group-flush">
                <a href='konut.aspx' class='list-group-item'>Konut<span class='float-right badge badge-light round'><% Response.Write(site_master.tip_sayisi(0));%></span> </a>
			  <a href='isyeri.aspx' class="list-group-item">İşyeri<span class="float-right badge badge-light round"><% Response.Write(site_master.tip_sayisi(1));%></span>  </a>
			  <a href='arsa.aspx' class="list-group-item">Arsa<span class="float-right badge badge-light round"><% Response.Write(site_master.tip_sayisi(2));%></span>  </a>
			</div>  <!-- list-group .// -->
		</div>
	</div>
    <div class="col-md-9">
                   <%
                       site_master.div_uretici(3);
                
                 %>
    </div>
         
         
 </div>
</asp:Content>
