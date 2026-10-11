<%@ Page Title="Register" MasterPageFile="~/PublicLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="HostelHub.Account.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="auth-wrap">
        <div class="auth-card wide">
            <h2>Create Account</h2>
            <p class="sub">Enter your details below to register your student profile.</p>

            <asp:ValidationSummary ID="vsSummary" runat="server" CssClass="val-summary"
                HeaderText="Please fix the following:" DisplayMode="BulletList" />

            <div class="form-section"><i class="bi bi-person"></i> Personal Information</div>
            <div class="row g-3">
                <div class="col-md-6">
                    <label class="form-label-hh">Full Name</label>
                    <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control-hh" MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFullName" Display="Dynamic"
                        CssClass="field-error" Text="Required" ErrorMessage="Full Name is required." />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtFullName" Display="Dynamic"
                        CssClass="field-error" ValidationExpression="^[A-Za-z .'-]{2,100}$"
                        Text="Invalid name" ErrorMessage="Full Name can contain only letters, spaces, . ' and -" />
                </div>
                <div class="col-md-6">
                    <label class="form-label-hh">Enrollment Number</label>
                    <asp:TextBox ID="txtEnrollment" runat="server" CssClass="form-control-hh" MaxLength="20"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEnrollment" Display="Dynamic"
                        CssClass="field-error" Text="Required" ErrorMessage="Enrollment Number is required." />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEnrollment" Display="Dynamic"
                        CssClass="field-error" ValidationExpression="^[A-Za-z0-9-]{6,20}$"
                        Text="Invalid" ErrorMessage="Enrollment Number must be 6 to 20 letters or digits." />
                </div>
                <div class="col-md-6">
                    <label class="form-label-hh">University Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" TextMode="Email" CssClass="form-control-hh"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" Display="Dynamic"
                        CssClass="field-error" Text="Required" ErrorMessage="Email is required." />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtEmail" Display="Dynamic"
                        CssClass="field-error" ValidationExpression="^[^@\s]+@[^@\s]+\.[^@\s]+$"
                        Text="Invalid email" ErrorMessage="Please enter a valid email address." />
                </div>
                <div class="col-md-6">
                    <label class="form-label-hh">Phone Number</label>
                    <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control-hh" MaxLength="10"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPhone" Display="Dynamic"
                        CssClass="field-error" Text="Required" ErrorMessage="Phone Number is required." />
                    <asp:RegularExpressionValidator runat="server" ControlToValidate="txtPhone" Display="Dynamic"
                        CssClass="field-error" ValidationExpression="^[6-9]\d{9}$"
                        Text="Invalid phone" ErrorMessage="Phone Number must be a 10-digit mobile number starting with 6, 7, 8 or 9." />
                </div>
                <div class="col-md-6">
                    <label class="form-label-hh">Password</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control-hh"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtPassword" Display="Dynamic"
                        CssClass="field-error" Text="Required" ErrorMessage="Password is required." />
                    <asp:CustomValidator ID="cvPassword" runat="server" ControlToValidate="txtPassword" Display="Dynamic"
                        CssClass="field-error" ClientValidationFunction="validatePassword"
                        OnServerValidate="cvPassword_ServerValidate"
                        Text="Weak password" ErrorMessage="Password must be at least 8 characters with at least one letter and one number." />
                </div>
                <div class="col-md-6">
                    <label class="form-label-hh">Confirm Password</label>
                    <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" CssClass="form-control-hh"></asp:TextBox>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirm" Display="Dynamic"
                        CssClass="field-error" Text="Required" ErrorMessage="Confirm Password is required." />
                    <asp:CompareValidator runat="server" ControlToValidate="txtConfirm" ControlToCompare="txtPassword"
                        Operator="Equal" Type="String" Display="Dynamic" CssClass="field-error"
                        Text="Does not match" ErrorMessage="Password and Confirm Password do not match." />
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
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlCourse" InitialValue=""
                        Display="Dynamic" CssClass="field-error" Text="Required" ErrorMessage="Please select a Course." />
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
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="ddlDepartment" InitialValue=""
                        Display="Dynamic" CssClass="field-error" Text="Required" ErrorMessage="Please select a Department." />
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
                    <asp:TextBox ID="txtRoom" runat="server" CssClass="form-control-hh" placeholder="e.g. 204" MaxLength="3"></asp:TextBox>
                    <asp:RangeValidator runat="server" ControlToValidate="txtRoom" Type="Integer"
                        MinimumValue="1" MaximumValue="999" Display="Dynamic" CssClass="field-error"
                        Text="Invalid room" ErrorMessage="Room Number must be a number between 1 and 999." />
                </div>
            </div>

            <asp:CustomValidator ID="cvDuplicate" runat="server" Display="None" EnableClientScript="false"
                ErrorMessage="An account with this email or enrollment number already exists." />

            <asp:Label ID="lblMessage" runat="server" EnableViewState="false"></asp:Label>

            <div style="margin-top:20px">
                <asp:Button ID="btnRegister" runat="server" Text="CREATE ACCOUNT →"
                    CssClass="btn-hh-dark btn-block" OnClick="btnRegister_Click" />
            </div>

            <p class="auth-foot">Already have an account? <a href="~/Account/Login.aspx" runat="server">Log in here</a></p>
        </div>
    </div>

    <script>
        // CustomValidator ka client-side function (browser mein turant check)
        function validatePassword(sender, args) {
            var v = args.Value;
            args.IsValid = v.length >= 8 && /[A-Za-z]/.test(v) && /[0-9]/.test(v);
        }
    </script>
</asp:Content>