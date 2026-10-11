<%@ Page Title="Login" MasterPageFile="~/PublicLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="HostelHub.Account.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-wrap">
        <div class="auth-card">
            <h2>Welcome Back</h2>
            <p class="sub">Login to your HostelHub account</p>

            <asp:ValidationSummary runat="server" CssClass="val-summary"
                HeaderText="Please fix the following:" DisplayMode="BulletList" />

            <div class="form-group-hh">
                <label class="form-label-hh">Email or Enrollment Number</label>
                <asp:TextBox ID="txtUser" runat="server" CssClass="form-control-hh" placeholder="e.g., admin@hostelhub.edu"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUser" Display="Dynamic"
                    CssClass="field-error" Text="Required" ErrorMessage="Email or Enrollment Number is required." />
            </div>

            <div class="form-group-hh">
                <label class="form-label-hh">Password</label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control-hh" placeholder="••••••••"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" Display="Dynamic"
                    CssClass="field-error" Text="Required" ErrorMessage="Password is required." />
            </div>

            <div class="auth-links">
                <label><asp:CheckBox ID="chkRemember" runat="server" /> Remember me</label>
                <a href="~/Account/ForgotPassword.aspx" runat="server">Forgot Password?</a>
            </div>

            <asp:Label ID="lblMessage" runat="server" EnableViewState="false"></asp:Label>

            <div style="margin-top:20px">
                <asp:Button ID="btnLogin" runat="server" Text="Login →" CssClass="btn-hh-dark btn-block" OnClick="btnLogin_Click" />
            </div>

            <p class="auth-foot">Don't have an account? <a href="~/Account/Register.aspx" runat="server">Register</a></p>
        </div>
    </div>
</asp:Content>