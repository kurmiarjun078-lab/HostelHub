<%@ Page Title="Complaints" MasterPageFile="~/StudentLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="MyComplaints.aspx.cs" Inherits="HostelHub.Student.MyComplaints" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="page-head">
        <div>
            <h1 class="page-title">My Complaints</h1>
            <p class="page-sub">Track and manage your hostel maintenance requests.</p>
        </div>
        <div class="page-actions"><a class="btn-sm-hh dark"><i class="bi bi-plus-lg"></i> New Complaint</a></div>
    </div>

    <div class="row g-3 mb-3">
        <div class="col-md-4"><div class="stat-card"><div class="stat-top">
            <div><div class="label">Total</div><div class="value">12</div></div>
            <div class="stat-icon grey"><i class="bi bi-folder"></i></div></div></div></div>
        <div class="col-md-4"><div class="stat-card"><div class="stat-top">
            <div><div class="label" style="color:#B45309">Pending</div><div class="value">3</div></div>
            <div class="stat-icon amber"><i class="bi bi-hourglass-split"></i></div></div></div></div>
        <div class="col-md-4"><div class="stat-card"><div class="stat-top">
            <div><div class="label" style="color:#15803D">Resolved</div><div class="value">9</div></div>
            <div class="stat-icon green"><i class="bi bi-check-circle"></i></div></div></div></div>
    </div>

    <div class="panel form-accent mb-3">
        <h5 class="fw-bold">Submit New Complaint</h5>
        <hr />
        <div class="row g-3">
            <div class="col-md-6 fgrp">
                <label>Category</label>
                <select class="form-control-hh">
                    <option>Electrical</option><option>Plumbing</option><option>Carpentry</option>
                    <option>Cleaning</option><option>Internet</option><option>Other</option>
                </select>
            </div>
            <div class="col-md-6 fgrp">
                <label>Date</label>
                <input type="text" class="form-control-hh" readonly value="<%= DateTime.Now.ToString("dd MMM yyyy") %>" />
            </div>
            <div class="col-12 fgrp">
                <label>Subject</label>
                <input type="text" class="form-control-hh" placeholder="Brief summary of the issue" />
            </div>
            <div class="col-12 fgrp">
                <label>Description</label>
                <textarea class="form-control-hh" rows="4" placeholder="Provide details about the problem, exact location, etc."></textarea>
            </div>
        </div>
        <div class="text-end">
            <button type="button" class="btn-sm-hh">Cancel</button>
            <button type="button" class="btn-sm-hh blue">Submit Request</button>
        </div>
    </div>

    <div class="table-card">
        <div class="panel-head" style="padding:16px"><h5>Recent Complaints</h5><a class="btn-sm-hh"><i class="bi bi-funnel"></i> Filter</a></div>
        <table class="hh-table">
            <thead><tr><th>ID</th><th>Issue</th><th>Category</th><th>Date</th><th>Status</th></tr></thead>
            <tbody>
                <tr><td><code>#C-1042</code></td><td>Fan regulator not working</td><td>Electrical</td><td>Oct 24, 2024</td><td><span class="status pending">Pending</span></td></tr>
                <tr><td><code>#C-1041</code></td><td>Leaking tap in washroom</td><td>Plumbing</td><td>Oct 22, 2024</td><td><span class="status resolved">Resolved</span></td></tr>
                <tr><td><code>#C-1038</code></td><td>Broken study chair</td><td>Carpentry</td><td>Oct 15, 2024</td><td><span class="status resolved">Resolved</span></td></tr>
                <tr><td><code>#C-1035</code></td><td>Wi-Fi router dead in corridor</td><td>Electrical</td><td>Oct 10, 2024</td><td><span class="status progress">In Progress</span></td></tr>
            </tbody>
        </table>
    </div>

</asp:Content>