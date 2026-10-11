<%@ Page Title="Contact" MasterPageFile="~/PublicLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="HostelHub.Public.Contact" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <section class="container py-5">
        <h1 style="font-weight:800">Get in Touch</h1>
        <p class="text-muted mb-4">We're here to help you manage your hostel operations efficiently. Reach out with any questions, feedback, or support requests.</p>

        <div class="row g-4">
            <div class="col-lg-7">
                <div class="panel">
                    <h5 class="fw-bold mb-3">Send us a message</h5>
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label-hh">Full Name</label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control-hh"></asp:TextBox>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label-hh">Email Address</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control-hh"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label-hh">Subject</label>
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control-hh" placeholder="How can we help?"></asp:TextBox>
                        </div>
                        <div class="col-12">
                            <label class="form-label-hh">Message</label>
                            <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="6" CssClass="form-control-hh" placeholder="Enter your detailed message here..."></asp:TextBox>
                        </div>
                    </div>
                    <asp:Label ID="lblMessage" runat="server" EnableViewState="false"></asp:Label>

                    <div class="text-end mt-3">
                           <asp:Button ID="btnSend" runat="server" Text="Send Message" CssClass="btn-hh-primary" OnClick="btnSend_Click" />
                    </div>

                </div>
            </div>

            <div class="col-lg-5">
                <div class="panel">
                    <h5 class="fw-bold mb-3">Contact Information</h5>
                    <div class="contact-item"><i class="bi bi-geo-alt"></i><div><strong>Headquarters</strong>Your Hostel Name, City</div></div>
                    <div class="contact-item"><i class="bi bi-telephone"></i><div><strong>Phone Support</strong>+91 00000 00000</div></div>
                    <div class="contact-item"><i class="bi bi-envelope"></i><div><strong>Email Support</strong>support@example.com</div></div>
                    <div class="contact-item"><i class="bi bi-clock"></i><div><strong>Business Hours</strong>Monday - Friday: 9:00 AM - 6:00 PM<br />Saturday - Sunday: Closed</div></div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
