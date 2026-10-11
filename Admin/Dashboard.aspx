<%@ Page Title="Dashboard" MasterPageFile="~/AdminLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="HostelHub.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1 class="page-title"><%: DateTime.Now.Hour < 12 ? "Good Morning" : (DateTime.Now.Hour < 17 ? "Good Afternoon" : "Good Evening") %>, Admin</h1>
    <p class="page-sub">Here is the current status of HostelHub today.</p>

    <div class="row g-3 mb-3">
        <div class="col-md-3"><div class="stat-card">
            <div class="stat-top">
                <div><div class="label">Total Students</div><div class="value">520</div></div>
                <div class="stat-icon blue"><i class="bi bi-people"></i></div>
            </div>
        </div></div>
        <div class="col-md-3"><div class="stat-card">
            <div class="stat-top">
                <div><div class="label">Occupied Rooms</div><div class="value">245 <small>/ 280</small></div></div>
                <div class="stat-icon blue"><i class="bi bi-door-open"></i></div>
            </div>
            <div class="bar"><div class="bar-fill" style="width:87.5%"></div></div>
        </div></div>
        <div class="col-md-3"><div class="stat-card">
            <div class="stat-top">
                <div><div class="label">Pending Complaints</div><div class="value red">18</div></div>
                <div class="stat-icon red"><i class="bi bi-exclamation-triangle"></i></div>
            </div>
        </div></div>
        <div class="col-md-3"><div class="stat-card">
            <div class="stat-top">
                <div><div class="label">Available Beds</div><div class="value blue">35</div></div>
                <div class="stat-icon grey"><i class="bi bi-house"></i></div>
            </div>
        </div></div>
    </div>

    <div class="row g-3 mb-3">
        <div class="col-lg-8">
            <div class="panel h-100">
                <div class="panel-head">
                    <h5>Occupancy Overview</h5>
                    <a href="~/Admin/RoomManagement.aspx" runat="server">View Details</a>
                </div>
                <div class="bar big"><div class="bar-fill" style="width:87.5%"></div></div>
                <div class="legend">
                    <span class="dot occ"></span>Occupied (87.5%)
                    <span class="dot avail"></span>Available (12.5%)
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="panel h-100">
                <div class="panel-head"><h5>Quick Actions</h5></div>
                <div class="quick-grid">
                    <a class="quick-btn" href="~/Admin/StudentManagement.aspx" runat="server"><i class="bi bi-person-plus"></i>Add Student</a>
                    <a class="quick-btn" href="~/Admin/RoomManagement.aspx" runat="server"><i class="bi bi-plus-square"></i>Add Room</a>
                    <a class="quick-btn" href="~/Admin/ComplaintManagement.aspx" runat="server"><i class="bi bi-clipboard-check"></i>Manage Complaints</a>
                    <a class="quick-btn" href="~/Admin/MessManagement.aspx" runat="server"><i class="bi bi-cup-hot"></i>Update Mess Menu</a>
                </div>
            </div>
        </div>
    </div>

    <div class="table-card">
        <div class="panel-head" style="padding:16px 16px 4px">
            <h5>Recent Complaints</h5>
            <a href="~/Admin/ComplaintManagement.aspx" runat="server">View All →</a>
        </div>
        <table class="hh-table">
            <thead><tr><th>Complaint</th><th>Student</th><th>Room</th><th>Category</th><th>Status</th></tr></thead>
            <tbody>
                <tr><td>Leaking pipe in bathroom</td><td>John Doe</td><td>A-102</td><td>Plumbing</td><td><span class="status pending">PENDING</span></td></tr>
                <tr><td>Fan regulator not working</td><td>Jane Smith</td><td>B-205</td><td>Electrical</td><td><span class="status progress">IN PROGRESS</span></td></tr>
                <tr><td>Broken window latch</td><td>Alex Johnson</td><td>C-310</td><td>Carpentry</td><td><span class="status resolved">RESOLVED</span></td></tr>
                <tr><td>Wi-Fi router unstable</td><td>Michael Brown</td><td>A-401</td><td>IT/Network</td><td><span class="status pending">PENDING</span></td></tr>
            </tbody>
        </table>
    </div>

</asp:Content>