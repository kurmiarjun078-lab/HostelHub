<%@ Page Title="Dashboard" MasterPageFile="~/StudentLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="HostelHub.Student.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-head">
        <div>
            <h1 class="page-title"><%: DateTime.Now.Hour < 12 ? "Good Morning" : (DateTime.Now.Hour < 17 ? "Good Afternoon" : "Good Evening") %></h1>
            <p class="page-sub">Here is what's happening in HostelHub today.</p>
        </div>
        <div class="page-actions">
            <a class="btn-sm-hh" href="~/Student/MyComplaints.aspx" runat="server"><i class="bi bi-exclamation-circle"></i> Submit Complaint</a>
            <a class="btn-sm-hh" href="~/Student/MessMenu.aspx" runat="server"><i class="bi bi-cup-hot"></i> View Menu</a>
        </div>
    </div>

    <div class="row g-3 mb-3">
        <div class="col-md-3"><div class="stat-card">
            <div class="stat-top"><div><div class="label">My Room</div><div class="value">A-204</div></div>
                <div class="stat-icon blue"><i class="bi bi-door-open"></i></div></div>
            <div style="font-size:12px;font-weight:600;color:var(--hh-primary);margin-top:4px"><i class="bi bi-building"></i> Block A</div>
        </div></div>
        <div class="col-md-3"><div class="stat-card">
            <div class="stat-top"><div><div class="label">Complaints</div><div class="value">2 <small>Total</small></div></div>
                <div class="stat-icon red"><i class="bi bi-clipboard-x"></i></div></div>
            <div style="font-size:12px;font-weight:600;color:#B91C1C;margin-top:4px"><i class="bi bi-dash-circle"></i> 1 Pending</div>
        </div></div>
        <div class="col-md-3"><div class="stat-card">
            <div class="stat-top"><div><div class="label">Current Fees</div><div class="value">₹8,500</div></div>
                <div class="stat-icon blue"><i class="bi bi-cash-stack"></i></div></div>
            <div style="font-size:12px;color:var(--hh-muted);margin-top:4px"><i class="bi bi-calendar"></i> Due: N/A</div>
        </div></div>
        <div class="col-md-3"><div class="stat-card">
            <div class="stat-top"><div><div class="label">Attendance</div><div class="value">92%</div></div>
                <div class="stat-icon grey"><i class="bi bi-card-checklist"></i></div></div>
            <div class="bar"><div class="bar-fill" style="width:92%"></div></div>
            <div style="font-size:12px;font-weight:600;margin-top:6px">Last updated: Today</div>
        </div></div>
    </div>

    <div class="row g-3 mb-3">
        <div class="col-lg-8">
            <div class="panel h-100">
                <div class="panel-head"><h5>Room Overview</h5><a href="~/Student/MyRoom.aspx" runat="server">View Details</a></div>
                <hr />
                <div class="row g-3 align-items-center">
                    <div class="col-md-6">
                        <div class="info-grid" style="grid-template-columns:1fr 1fr">
                            <div class="info-item"><div class="k">Room Number</div><div class="v"><b>A-204</b></div></div>
                            <div class="info-item"><div class="k">Block &amp; Floor</div><div class="v">Block A, 2nd Floor</div></div>
                            <div class="info-item" style="grid-column:1 / -1"><div class="k">Roommates</div><div class="v">3 Occupied, 1 Vacant</div></div>
                        </div>
                    </div>
                    <div class="col-md-6"><div class="room-photo"><span class="seat">4-Seater</span></div></div>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="panel h-100">
                <div class="panel-head"><h5><i class="bi bi-cup-hot text-primary"></i> Today's Mess</h5></div>
                <hr />
                <div class="meal-item"><small>Breakfast (7:30 AM - 9:00 AM)</small><b>Idli, Sambar, Coconut Chutney, Tea/Coffee</b></div>
                <div class="meal-item now"><small>Lunch (12:30 PM - 2:00 PM) • Now Serving</small><b>Rajma Chawal, Roti, Seasonal Veg, Curd</b></div>
                <div class="meal-item"><small>Dinner (7:30 PM - 9:00 PM)</small><b>Paneer Butter Masala, Naan, Jeera Rice, Gulab Jamun</b></div>
            </div>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-lg-8">
            <div class="table-card h-100">
                <div class="panel-head" style="padding:16px 16px 4px"><h5>Recent Complaints</h5><a href="~/Student/MyComplaints.aspx" runat="server">View All</a></div>
                <table class="hh-table">
                    <thead><tr><th>Complaint ID</th><th>Category</th><th>Date</th><th>Status</th></tr></thead>
                    <tbody>
                        <tr><td><b>#CMP-8902</b></td><td><i class="bi bi-wrench"></i> Plumbing</td><td>Oct 24, 2023</td><td><span class="status pending">Pending</span></td></tr>
                        <tr><td><b>#CMP-8845</b></td><td><i class="bi bi-plug"></i> Electrical</td><td>Oct 18, 2023</td><td><span class="status progress">Resolved</span></td></tr>
                        <tr><td><b>#CMP-8711</b></td><td><i class="bi bi-trash"></i> Cleaning</td><td>Oct 10, 2023</td><td><span class="status progress">Resolved</span></td></tr>
                    </tbody>
                </table>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="panel h-100">
                <div class="panel-head"><h5><i class="bi bi-megaphone text-primary"></i> Latest Notices</h5></div>
                <hr />
                <div class="notice-mini">
                    <div class="top"><span class="tag maintenance">Maintenance</span><span>2h ago</span></div>
                    <h6>Water Supply Maintenance</h6><p>Water supply in Block A and B will be interrupted tomorrow from 10…</p>
                </div>
                <div class="notice-mini">
                    <div class="top"><span class="tag admin">Admin</span><span>Yesterday</span></div>
                    <h6>Semester Fee Submission Deadline</h6><p>The last date for submitting the hostel fees for the upcoming…</p>
                </div>
                <div class="notice-mini">
                    <div class="top"><span class="tag general">Event</span><span>Oct 20</span></div>
                    <h6>Diwali Cultural Night Updates</h6><p>Join us for the annual Diwali celebration in the main quad.…</p>
                </div>
                <a class="btn-grey" href="~/Student/Notices.aspx" runat="server">View All Notices</a>
            </div>
        </div>
    </div>

</asp:Content>