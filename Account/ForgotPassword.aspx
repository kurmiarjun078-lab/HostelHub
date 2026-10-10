<%@ Page Title="Forgot Password" MasterPageFile="~/PublicLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="HostelHub.Account.ForgotPassword" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-wrap">
        <div class="auth-card">
            <h2 style="text-align:center">HostelHub</h2>
            <p class="sub" style="text-align:center">Recover your account access</p>

            <div class="form-group-hh">
                <label class="form-label-hh">Email address or Enrollment ID</label>
                <asp:TextBox ID="txtIdentity" runat="server" CssClass="form-control-hh"></asp:TextBox>
            </div>

            <asp:Button ID="btnSendCode" runat="server" Text="Send Reset Code" CssClass="btn-hh-dark btn-block" />

            <p class="auth-foot"><a href="~/Account/Login.aspx" runat="server">← Back to Login</a></p>
        </div>
    </div>
</asp:Content>
