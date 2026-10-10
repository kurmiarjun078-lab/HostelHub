<%@ Page Title="Login" MasterPageFile="~/PublicLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="HostelHub.Account.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-wrap">
        <div class="auth-card">
            <h2>Welcome Back</h2>
            <p class="sub">Login to your HostelHub account</p>

            <div class="form-group-hh">
                <label class="form-label-hh">Email or Enrollment Number</label>
                <asp:TextBox ID="txtUser" runat="server" CssClass="form-control-hh" placeholder="e.g., admin@hostelhub.edu"></asp:TextBox>
            </div>

            <div class="form-group-hh">
                <label class="form-label-hh">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control-hh" placeholder="••••••••"></asp:TextBox>
            </div>

            <div class="auth-links">
                <label><asp:CheckBox ID="chkRemember" runat="server" /> Remember me</label>
                <a href="~/Account/ForgotPassword.aspx" runat="server">Forgot Password?</a>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Login →" CssClass="btn-hh-dark btn-block" />

            <p class="auth-foot">Don't have an account? <a href="~/Account/Register.aspx" runat="server">Register</a></p>
        </div>
    </div>
</asp:Content>
