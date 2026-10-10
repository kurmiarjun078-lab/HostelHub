<%@ Page Title="Home" Language="C#" MasterPageFile="~/PublicLayout.master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="HostelHub.Public.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <section class="hero">
        <div class="row align-items-center">
            <div class="col-lg-6">
                <h1>Smart Hostel Management, <span>Made Simple.</span></h1>
                <p>Manage students, rooms, complaints, mess services, and hostel communication from one powerful, intuitive platform designed for operational excellence.</p>
                <a class="btn-hh-primary me-2" href="~/Account/Register.aspx" runat="server">Get Started Free →</a>
                <a class="btn-hh-outline" href="#features">Explore Features</a>
            </div>
            <div class="col-lg-6">
                <img src="~/Images/images (5).jpg" runat="server" alt="Hostel building" />
            </div>
        </div>
    </section>

    <section id="features" class="py-5">
        <div class="container">
            <h2 class="section-title">Everything You Need</h2>
            <p class="section-sub">A comprehensive suite of tools to automate daily tasks and improve the living experience for our students.</p>

            <div class="row g-4">
                <div class="col-md-4"><div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-door-open"></i></div>
                    <h5>Room Management</h5>
                    <p>Easily allocate rooms, track availability in real-time, and manage transfers with a visual floor plan.</p>
                </div></div>
                <div class="col-md-4"><div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-people"></i></div>
                    <h5>Student Database</h5>
                    <p>Maintain digital records of all residents, including emergency contacts, fee status, and attendance.</p>
                </div></div>
                <div class="col-md-4"><div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-exclamation-triangle"></i></div>
                    <h5>Complaint Resolution</h5>
                    <p>Streamline maintenance requests with automated ticketing, status tracking, and resolution updates.</p>
                </div></div>
                <div class="col-md-4"><div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-cup-hot"></i></div>
                    <h5>Mess Management</h5>
                    <p>Publish weekly menus, track meal attendance, and manage vendor supplies and feedback.</p>
                </div></div>
                <div class="col-md-4"><div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-megaphone"></i></div>
                    <h5>Digital Notices</h5>
                    <p>Broadcast important announcements instantly to all students via email and in-app notifications.</p>
                </div></div>
                <div class="col-md-4"><div class="feature-card">
                    <div class="feature-icon"><i class="bi bi-chat-dots"></i></div>
                    <h5>Seamless Communication</h5>
                    <p>Facilitate two-way communication between administration and residents for a transparent environment.</p>
                </div></div>
            </div>
        </div>
    </section>

    <section id="how" class="py-5">
        <div class="container text-center">
            <h2 class="section-title">How It Works</h2>
            <p class="section-sub">Get your hostel up and running on our platform in three simple steps.</p>
            <div class="row">
                <div class="col-md-4">
                    <div class="step-circle">1</div>
                    <h6 class="fw-bold">Register &amp; Setup</h6>
                    <p class="text-muted small">Create your institution profile, define room structures, and import student data securely.</p>
                </div>
                <div class="col-md-4">
                    <div class="step-circle active">2</div>
                    <h6 class="fw-bold">Manage Operations</h6>
                    <p class="text-muted small">Handle daily tasks like attendance, complaints, and mess scheduling from the central dashboard.</p>
                </div>
                <div class="col-md-4">
                    <div class="step-circle">3</div>
                    <h6 class="fw-bold">Stay Connected</h6>
                    <p class="text-muted small">Keep students informed with real-time notices and monitor overall hostel health through reports.</p>
                </div>
            </div>
        </div>
    </section>

</asp:Content>