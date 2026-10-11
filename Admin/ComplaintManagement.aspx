<%@ Page Title="Complaints" MasterPageFile="~/AdminLayout.master"
    Language="C#" AutoEventWireup="true"
    CodeBehind="ComplaintManagement.aspx.cs"
    Inherits="HostelHub.Admin.ComplaintManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .complaint-page { padding:20px; color:#344054; }
    .page-head { display:flex; justify-content:space-between; align-items:center; gap:15px; margin-bottom:22px; }
    .page-title { margin:7px 0 0; font-size:26px; font-weight:700; }
    .crumb { color:#667085; font-size:13px; }
    .page-actions { display:flex; flex-wrap:wrap; gap:10px; }
    .complaint-stats { display:grid; grid-template-columns:repeat(4,minmax(0,1fr)); gap:15px; margin-bottom:20px; }
    .complaint-stat { padding:18px; border:1px solid #e4e7ec; border-radius:12px; background:#fff; }
    .stat-label { color:#667085; font-size:13px; }
    .stat-value { font-size:27px; font-weight:700; margin-top:8px; }
    .stat-note { display:block; margin-top:5px; color:#667085; font-size:12px; }
    .stat-note.red { color:#d92d20; }
    .complaint-form { padding:20px; border:1px solid #e4e7ec; border-radius:12px; margin-bottom:20px; background:#fff; }
    .complaint-form h3 { font-size:20px; margin:0 0 18px; }
    .form-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:15px; }
    .form-field label { display:block; font-weight:600; margin-bottom:6px; }
    .form-field .form-control, .form-field .form-select { min-height:42px; }
    .form-actions { display:flex; flex-wrap:wrap; gap:10px; margin-top:18px; }
    .complaint-toolbar { display:grid; grid-template-columns:minmax(200px,1fr) 155px 155px auto auto; gap:10px; align-items:center; padding:16px; border-bottom:1px solid #e4e7ec; }
    .complaint-toolbar .form-control, .complaint-toolbar .form-select { min-height:42px; border-radius:8px; }
    .table-card { border:1px solid #e4e7ec; border-radius:12px; overflow:hidden; background:#fff; }
    .complaint-table-wrap { overflow-x:auto; }
    .hh-table { width:100%; min-width:950px; border-collapse:collapse; }
    .hh-table th { background:#f8fafc; padding:14px 12px; text-align:left; font-size:12px; color:#475467; white-space:nowrap; border-bottom:1px solid #e4e7ec; }
    .hh-table td { padding:14px 12px; border-bottom:1px solid #edf0f4; vertical-align:middle; }
    .hh-table tr:last-child td { border-bottom:0; }
    .status-badge { display:inline-block; padding:5px 10px; border-radius:20px; font-size:12px; font-weight:600; white-space:nowrap; }
    .status-pending { background:#fef0c7; color:#b54708; }
    .status-progress { background:#dbeafe; color:#175cd3; }
    .status-resolved { background:#dcfae6; color:#067647; }
    .avatar-sm { display:inline-flex; width:30px; height:30px; border-radius:50%; background:#e9efff; color:#344a9a; font-weight:700; align-items:center; justify-content:center; margin-right:8px; }
    .action-group { display:flex; flex-wrap:wrap; gap:5px; }
    .action-group .btn { font-size:12px; padding:5px 8px; }
    .table-foot { display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:12px; padding:15px; color:#667085; font-size:13px; }
    .pager { display:flex; align-items:center; gap:5px; }
    .pager .btn { min-width:36px; }
    .message-label { display:block; margin-bottom:12px; }
    @media(max-width:900px) {
        .complaint-stats { grid-template-columns:repeat(2,minmax(0,1fr)); }
        .complaint-toolbar { grid-template-columns:1fr 1fr; }
        .complaint-toolbar .search-field { grid-column:1/-1; }
    }
    @media(max-width:550px) {
        .page-head { align-items:flex-start; flex-direction:column; }
        .complaint-stats, .form-grid, .complaint-toolbar { grid-template-columns:1fr; }
        .complaint-toolbar .search-field { grid-column:auto; }
    }
</style>

<div class="complaint-page">

    <div class="page-head">
        <div>
            <div class="crumb">Dashboard &rsaquo; <b>Complaints</b></div>
            <h1 class="page-title">Complaint Management</h1>
        </div>
        <div class="page-actions">
            <asp:Button ID="btnExportCsv" runat="server" Text="Export CSV"
                CssClass="btn btn-outline-secondary" OnClick="btnExportCsv_Click" />
            <asp:Button ID="btnShowAdd" runat="server" Text="+ Log Complaint"
                CssClass="btn btn-dark" OnClick="btnShowAdd_Click" />
        </div>
    </div>

    <asp:Label ID="lblMessage" runat="server" EnableViewState="false"
        CssClass="message-label" />

    <div class="complaint-stats">
        <div class="complaint-stat">
            <div class="stat-label">Total Complaints</div>
            <div class="stat-value"><asp:Label ID="lblTotal" runat="server" Text="0" /></div>
            <span class="stat-note">All recorded complaints</span>
        </div>
        <div class="complaint-stat">
            <div class="stat-label">Pending</div>
            <div class="stat-value"><asp:Label ID="lblPending" runat="server" Text="0" /></div>
            <span class="stat-note red">Requires attention</span>
        </div>
        <div class="complaint-stat">
            <div class="stat-label">In Progress</div>
            <div class="stat-value"><asp:Label ID="lblInProgress" runat="server" Text="0" /></div>
            <span class="stat-note">Being addressed</span>
        </div>
        <div class="complaint-stat">
            <div class="stat-label">Resolved</div>
            <div class="stat-value"><asp:Label ID="lblResolved" runat="server" Text="0" /></div>
            <span class="stat-note">Completed complaints</span>
        </div>
    </div>

    <asp:Panel ID="pnlComplaintForm" runat="server" CssClass="complaint-form" Visible="false">
        <h3><asp:Label ID="lblFormTitle" runat="server" Text="Log Complaint" /></h3>
        <asp:HiddenField ID="hfComplaintId" runat="server" />

        <div class="form-grid">
            <div class="form-field">
                <label for="<%= txtStudent.ClientID %>">Student Name</label>
                <asp:TextBox ID="txtStudent" runat="server" CssClass="form-control"
                    MaxLength="100" placeholder="Enter student name" />
            </div>
            <div class="form-field">
                <label for="<%= txtRoom.ClientID %>">Room Number</label>
                <asp:TextBox ID="txtRoom" runat="server" CssClass="form-control"
                    MaxLength="30" placeholder="e.g. A-204" />
            </div>
            <div class="form-field">
                <label for="<%= ddlCategory.ClientID %>">Category</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                    <asp:ListItem Value="Plumbing">Plumbing</asp:ListItem>
                    <asp:ListItem Value="Electrical">Electrical</asp:ListItem>
                    <asp:ListItem Value="Internet">Internet</asp:ListItem>
                    <asp:ListItem Value="Carpentry">Carpentry</asp:ListItem>
                    <asp:ListItem Value="Cleaning">Cleaning</asp:ListItem>
                    <asp:ListItem Value="Other">Other</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-field">
                <label for="<%= ddlComplaintStatus.ClientID %>">Status</label>
                <asp:DropDownList ID="ddlComplaintStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Value="Pending">Pending</asp:ListItem>
                    <asp:ListItem Value="In Progress">In Progress</asp:ListItem>
                    <asp:ListItem Value="Resolved">Resolved</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="form-field" style="grid-column:1/-1;">
                <label for="<%= txtDescription.ClientID %>">Complaint Description</label>
                <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control"
                    TextMode="MultiLine" Rows="4" MaxLength="2000"
                    placeholder="Describe the issue..." />
            </div>
            <div class="form-field" style="grid-column:1/-1;">
                <label for="<%= txtAdminRemark.ClientID %>">Admin Remark</label>
                <asp:TextBox ID="txtAdminRemark" runat="server" CssClass="form-control"
                    TextMode="MultiLine" Rows="2" MaxLength="1000"
                    placeholder="Add an update or resolution note..." />
            </div>
        </div>

        <div class="form-actions">
            <asp:Button ID="btnSaveComplaint" runat="server" Text="Save Complaint"
                CssClass="btn btn-primary" OnClick="btnSaveComplaint_Click" />
            <asp:Button ID="btnCancelForm" runat="server" Text="Cancel"
                CssClass="btn btn-outline-secondary" CausesValidation="false"
                OnClick="btnCancelForm_Click" />
        </div>
    </asp:Panel>

    <div class="table-card">
        <div class="complaint-toolbar">
            <div class="search-field">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                    placeholder="Search ID, student, room, category..." />
                
            </div>
            <asp:Button ID="btnSearch" runat="server" Text="Search"
                CssClass="btn btn-primary" OnClick="btnSearch_Click" />
            <div>
                <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Value="">All Statuses</asp:ListItem>
                    <asp:ListItem Value="Pending">Pending</asp:ListItem>
                    <asp:ListItem Value="In Progress">In Progress</asp:ListItem>
                    <asp:ListItem Value="Resolved">Resolved</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div>
                <asp:DropDownList ID="ddlSort" runat="server" CssClass="form-select">
                    <asp:ListItem Value="Newest">Sort: Newest</asp:ListItem>
                    <asp:ListItem Value="Oldest">Sort: Oldest</asp:ListItem>
                </asp:DropDownList>
            </div>
            
            
        </div>

        <div class="complaint-table-wrap">
            <table class="hh-table">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>STUDENT</th>
                        <th>ROOM</th>
                        <th>CATEGORY</th>
                        <th>DATE</th>
                        <th>STATUS</th>
                        <th>ACTIONS</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptComplaints" runat="server"
                        OnItemCommand="rptComplaints_ItemCommand">
                        <ItemTemplate>
                            <tr>
                                <td><strong>#<%#: Eval("Id") %></strong></td>
                                <td>
                                    <span class="avatar-sm"><%#: FirstLetter(Convert.ToString(Eval("Student"))) %></span>
                                    <%#: Eval("Student") %>
                                </td>
                                <td><%#: Eval("Room") %></td>
                                <td><%#: Eval("Category") %></td>
                                <td><%#: Convert.ToDateTime(Eval("Date")).ToString("dd MMM yyyy") %></td>
                                <td>
                                    <span class='status-badge <%# GetStatusCss(Convert.ToString(Eval("Status"))) %>'>
                                        <%#: Eval("Status") %>
                                    </span>
                                </td>
                                <td>
                                    <div class="action-group">
                                        <asp:LinkButton ID="btnView" runat="server" Text="View"
                                            CssClass="btn btn-outline-info" CausesValidation="false"
                                            CommandName="ViewComplaint" CommandArgument='<%# Eval("Id") %>' />
                                        <asp:LinkButton ID="btnEdit" runat="server" Text="Update"
                                            CssClass="btn btn-outline-primary" CausesValidation="false"
                                            CommandName="EditComplaint" CommandArgument='<%# Eval("Id") %>' />
                                        <asp:LinkButton ID="btnDelete" runat="server" Text="Delete"
                                            CssClass="btn btn-outline-danger" CausesValidation="false"
                                            CommandName="DeleteComplaint" CommandArgument='<%# Eval("Id") %>'
                                            OnClientClick="return confirm('Delete this complaint?');" />
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr id="trNoRecords" runat="server" visible="false">
                        <td colspan="7" class="text-center text-muted py-4">
                            No complaints found.
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="table-foot">
            <asp:Label ID="lblPageInfo" runat="server" Text="Showing 0 entries" />
            <div class="pager">
                <asp:Button ID="btnPrevious" runat="server" Text="‹"
                    CssClass="btn btn-outline-secondary" OnClick="btnPrevious_Click" />
                <asp:Button ID="btnNext" runat="server" Text="›"
                    CssClass="btn btn-outline-secondary" OnClick="btnNext_Click" />
            </div>
        </div>
    </div>

</div>
</asp:Content>