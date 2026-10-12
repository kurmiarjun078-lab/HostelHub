<%@ Page Title="Notices" MasterPageFile="~/StudentLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="Notices.aspx.cs" Inherits="HostelHub.Student.Notices" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1 class="page-title">Notices &amp; Announcements</h1>
    <p class="page-sub">Stay updated with the latest hostel information.</p>

    <div class="pills mb-4">
        <span class="pill on">All</span><span class="pill">Important</span><span class="pill">Maintenance</span><span class="pill">Events</span>
    </div>

    <div class="row g-3">
        <div class="col-lg-4"><div class="notice-card">
            <div class="top"><span class="tag important">Important</span><span><i class="bi bi-calendar"></i> Oct 24, 2024</span></div>
            <h5>Mandatory Fire Drill</h5>
            <p>A mandatory fire evacuation drill will be conducted for Blocks A and B. All residents must participate and…</p>
            <a class="btn-grey">Read More</a>
        </div></div>
        <div class="col-lg-4"><div class="notice-card">
            <div class="top"><span class="tag maintenance">Maintenance</span><span><i class="bi bi-calendar"></i> Oct 22, 2024</span></div>
            <h5>Water Supply Interruption</h5>
            <p>Due to scheduled maintenance of the primary overhead tanks, water supply to Block C will be suspended…</p>
            <a class="btn-grey">Read More</a>
        </div></div>
        <div class="col-lg-4"><div class="notice-card">
            <div class="top"><span class="tag events">Events</span><span><i class="bi bi-calendar"></i> Oct 20, 2024</span></div>
            <h5>Annual Hostel Sports Meet</h5>
            <p>Registrations are now open for the Annual Hostel Sports Meet. Events include Cricket, Football, Table…</p>
            <a class="btn-grey">Read More</a>
        </div></div>
        <div class="col-lg-4"><div class="notice-card">
            <div class="top"><span class="tag general">General</span><span><i class="bi bi-calendar"></i> Oct 18, 2024</span></div>
            <h5>Mess Menu Update</h5>
            <p>Based on recent feedback from the student committee, the mess menu for dinner has been revised starting…</p>
            <a class="btn-grey">Read More</a>
        </div></div>
    </div>

</asp:Content>