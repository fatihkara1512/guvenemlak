<%@ Page Title="Log in" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="guvenemlak.Account.Login" Async="true" %>

<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">

    <%if(Session["kullanici"]==null){ %>
    <div class="row">
        <div>
            <section id="loginForm">
                <div class="form-horizontal">
                    <h3>Giriş Yap</h3>
                    <hr />
                      <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="email" CssClass="col-md-2 control-label">E-Posta</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="email" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="email"
                                CssClass="text-danger" ErrorMessage="E-Posta Gereklidir." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Şifre</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="Şifre Gereklidir." />
                        </div>
                    </div>
         
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button runat="server" OnClick="LogIn" Text="Giriş Yap" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>
                <p>Hesabınız Yoksa 
                    <asp:HyperLink runat="server" ID="RegisterHyperLink"  NavigateUrl="~/Account/Register.aspx" ViewStateMode="Disabled">Kayıt Ol</asp:HyperLink>
                   
                </p>
            </section>
        </div>
    </div>
    <%} %>
</asp:Content>
