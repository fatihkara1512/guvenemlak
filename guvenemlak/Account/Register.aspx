<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="guvenemlak.Account.Register" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
     <%if(Session["kullanici"]==null){ %>
    <p class="text-danger">
        <asp:Literal runat="server" ID="ErrorMessage" />
    </p>

    <div class="form-horizontal">
        <h3>Üyelik Oluştur&nbsp;</h3>
        <hr />
        <asp:ValidationSummary runat="server" CssClass="text-danger" />
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="name" CssClass="col-md-2 control-label">Ad</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="name" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="name"
                    CssClass="text-danger" ErrorMessage="İsim Gereklidir." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="surname" CssClass="col-md-2 control-label">Soyad</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="surname" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="surname"
                    CssClass="text-danger" ErrorMessage="Soyisim Gereklidir." />
            </div>
        </div>
          <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="email" CssClass="col-md-2 control-label">E-Posta</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="email" CssClass="form-control" />
                <asp:RegularExpressionValidator  CssClass="text-danger"  ControlToValidate="email" ValidationExpression="^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$"  ID="RegularExpressionValidator1" runat="server" ErrorMessage="E-mail Giriniz."></asp:RegularExpressionValidator>
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Şifre</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="Password"
                    CssClass="text-danger" ErrorMessage="Şifre Gereklidir." />
            </div>
        </div>
        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="ConfirmPassword" CssClass="col-md-2 control-label">Şifre(Tekrar)</asp:Label>
            <div class="col-md-10">
                <asp:TextBox runat="server" ID="ConfirmPassword" TextMode="Password" CssClass="form-control" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="Şifre Gereklidir." />
                <asp:CompareValidator runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                    CssClass="text-danger" Display="Dynamic" ErrorMessage="Şifreler Uyuşmuyor." />
            </div>
        </div>
        <div class="form-group">
            <div class="col-md-offset-2 col-md-10">
                <asp:Button runat="server" OnClick="CreateUser_Click" Text="Kayıt Ol" CssClass="btn btn-default" />
            </div>
        </div>
    </div>
    <%} %>
</asp:Content>
