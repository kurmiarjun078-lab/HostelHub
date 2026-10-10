<%@ Page Title="About" MasterPageFile="~/PublicLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="HostelHub.Public.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Hero -->
    <section class="page-hero has-image">
        <h1>Empowering Hostel Management Everywhere</h1>
        <p>Modern tools for modern spaces. We provide the operational clarity you need to deliver exceptional resident experiences.</p>
        <a class="btn-hh-primary me-2" href="~/Public/Contact.aspx" runat="server">Schedule Demo</a>
        <a class="btn-hh-outline" href="#values">Learn More</a>
    </section>

    <!-- Mission -->
    <section class="container py-5">
        <div class="row align-items-center g-4">
            <div class="col-lg-6">
                <h2 class="fw-bold">Our Mission</h2>
                <p class="text-muted">At HostelHub, we believe that managing a modern living space shouldn't be a logistical nightmare. Our mission is to simplify operations for owners and operators while simultaneously elevating the everyday experience for residents.</p>
                <p class="text-muted">By providing an intuitive, centralized platform, we reduce cognitive load, automate the mundane, and free up your team to focus on what truly matters: building community.</p>
            </div>
            <div class="col-lg-6">
                <img src="~/Images/about.png" runat="server" class="about-img" alt="HostelHub dashboard on a tablet" />
            </div>
        </div>
    </section>

    <!-- Core Values -->
    <section id="values" class="container pb-5">
        <h2 class="section-title">Core Values</h2>
        <p class="section-sub">The principles that guide our product and our people.</p>
        <div class="row g-4">
            <div class="col-md-3"><div class="value-card">
                <div class="feature-icon"><i class="bi bi-lightning"></i></div>
                <h5>Efficiency</h5>
                <p>Automating complex workflows to save time and reduce errors across all operational levels.</p>
            </div></div>
            <div class="col-md-3"><div class="value-card">
                <div class="feature-icon"><i class="bi bi-eye"></i></div>
                <h5><Trans></Trans>parency</h5>
                <p>Providing clear, actionable data and insights to foster trust and better decision-making.</p>
            </div></div>
            <div class="col-md-3"><div class="value-card">
                <div class="feature-icon"><i class="bi bi-chat-square-text"></i></div>
                <h5>Community</h5>
                <p>Designing tools that help operators build stronger, more connected resident communities.</p>
            </div></div>
            <div class="col-md-3"><div class="value-card">
                <div class="feature-icon"><i class="bi bi-lightbulb"></i></div>
                <h5>Innovation</h5>
                <p>Continuously evolving our platform to meet the changing needs of the modern hospitality industry.</p>
            </div></div>
        </div>
    </section>

    <!-- CTA -->
    <section class="cta-band">
        <h2>Join the HostelHub Family</h2>
        <p>Ready to transform your hostel operations? Let us show you how our platform can streamline your daily tasks and improve resident satisfaction.</p>
        <a class="btn-white" href="~/Public/Contact.aspx" runat="server">Schedule a Demo →</a>
    </section>

</asp:Content>