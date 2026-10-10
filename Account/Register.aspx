<%@ Page Title="Register" MasterPageFile="~/PublicLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="HostelHub.Account.Register" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-wrap">
        <div class="auth-card wide">
            <h2>Create Account</h2>
            <p class="sub">Enter your details below to register your student profile.</p>

            <div class="form-section"><i class="bi bi-person"></i> Personal Information</div>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label-hh">Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control-hh"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label class="form-label-hh">Enrollment Number</label>
                    <asp:TextBox ID="txtEnrollment" runat="server" CssClass="form-control-hh"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label class="form-label-hh">University Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control-hh"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label class="form-label-hh">Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control-hh"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label class="form-label-hh">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control-hh"></asp:TextBox>
                </div>
                <div class="col-md-6">
                    <label class="form-label-hh">Confirm Password</label>
                    <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" CssClass="form-control-hh"></asp:TextBox>
                </div>
            </div>

            <div class="form-section"><i class="bi bi-mortarboard"></i> Academic Details</div>
            <div class="row g-3">
                <div class="col-md-4">
                    <label class="form-label-hh">Course</label>
                    <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-control-hh">
                        <asp:ListItem Text="Select" Value=""></asp:ListItem>
                        <asp:ListItem>B.Tech</asp:ListItem>
                        <asp:ListItem>BBA</asp:ListItem>
                        <asp:ListItem>BCA</asp:ListItem>
                        <asp:ListItem>M.Tech</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-8">
                    <label class="form-label-hh">Department</label>
                    <asp:DropDownList ID="ddlDepartment" runat="server" CssClass="form-control-hh">
                        <asp:ListItem Text="Choose Department" Value=""></asp:ListItem>
                        <asp:ListItem>Computer Engineering</asp:ListItem>
                        <asp:ListItem>Electrical Engineering</asp:ListItem>
                        <asp:ListItem>Mechanical Engineering</asp:ListItem>
                        <asp:ListItem>Civil Engineering</asp:ListItem>
                        <asp:ListItem>Information Technology</asp:ListItem>
                    </asp:DropDownList>
                </div>
            </div>

            <div class="form-section"><i class="bi bi-door-open"></i> Hostel Allocation</div>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label-hh">Assigned Block</label>
                    <asp:DropDownList ID="ddlBlock" runat="server" CssClass="form-control-hh">
                        <asp:ListItem Text="Select Block" Value=""></asp:ListItem>
                        <asp:ListItem>Block A</asp:ListItem>
                        <asp:ListItem>Block B</asp:ListItem>
                        <asp:ListItem>Block C</asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-6">
                    <label class="form-label-hh">Room Number</label>
                    <asp:TextBox ID="txtRoom" runat="server" CssClass="form-control-hh" placeholder="e.g. 204"></asp:TextBox>
                </div>
            </div>

            <div style="margin-top:28px">
                <asp:Button ID="btnRegister" runat="server" Text="CREATE ACCOUNT →" CssClass="btn-hh-dark btn-block" />
            </div>

            <p class="auth-foot">Already have an account? <a href="~/Account/Login.aspx" runat="server">Log in here</a></p>
        </div>
    </div>
</asp:Content>
