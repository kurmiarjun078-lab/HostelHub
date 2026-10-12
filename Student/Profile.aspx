<%@ Page Title="Profile" MasterPageFile="~/StudentLayout.master" Language="C#" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="HostelHub.Student.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="panel mb-3">
        <div class="profile-head">
            <div class="profile-id">
                <div class="avatar-lg">R</div>
                <div>
                    <h3>Rahul Sharma</h3>
                    <span class="chip">ENR-2023-001</span><span class="chip blue"><i class="bi bi-check-circle"></i> Active</span>
                </div>
            </div>
            <a class="btn-sm-hh"><i class="bi bi-pencil"></i> Edit Profile</a>
        </div>
    </div>

    <div class="row g-3 mb-3">
        <div class="col-lg-8">
            <div class="panel h-100">
                <div class="sec-title"><i class="bi bi-person"></i> Personal Information</div>
                <div class="info-grid">
                    <div class="info-item"><div class="k">Email Address</div><div class="v">rahul.sharma@university.edu</div></div>
                    <div class="info-item"><div class="k">Phone Number</div><div class="v">+91 98765 43210</div></div>
                    <div class="info-item"><div class="k">Date of Birth</div><div class="v">15 Aug 2002</div></div>
                    <div class="info-item"><div class="k">Gender</div><div class="v">Male</div></div>
                </div>
            </div>
        </div>
        <div class="col-lg-4">
            <div class="panel h-100">
                <div class="sec-title"><i class="bi bi-building text-primary"></i> Hostel Information</div>
                <div class="hostel-box">
                    <div class="row-i"><span class="k">Block</span><span class="v">A-North</span></div>
                    <div class="row-i"><span class="k">Room</span><span class="v">302</span></div>
                    <div class="row-i"><span class="k">Bed</span><span class="v">B</span></div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-3">
        <div class="col-lg-4">
            <div class="panel h-100">
                <div class="sec-title"><i class="bi bi-mortarboard"></i> Academic Information</div>
                <div class="info-item mb-3"><div class="k">Course</div><div class="v">B.Tech Computer Science</div></div>
                <div class="info-item mb-3"><div class="k">Department</div><div class="v">Engineering</div></div>
                <div class="info-item"><div class="k">Semester</div><div class="v">5th Semester</div></div>
            </div>
        </div>
        <div class="col-lg-8">
            <div class="panel h-100">
                <div class="sec-title red"><i class="bi bi-asterisk"></i> Emergency Contact</div>
                <div class="emerg-box">
                    <div class="info-grid three">
                        <div class="info-item"><div class="k">Guardian Name</div><div class="v">Ramesh Sharma</div></div>
                        <div class="info-item"><div class="k">Relationship</div><div class="v">Father</div></div>
                        <div class="info-item"><div class="k">Phone Number</div><div class="v">+91 98765 00000</div></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>