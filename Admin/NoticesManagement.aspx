<%@ Page Title="Notices" MasterPageFile="~/AdminLayout.master"
    Language="C#" AutoEventWireup="true"
    CodeBehind="NoticesManagement.aspx.cs"
    Inherits="HostelHub.Admin.NoticesManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .notice-page { padding:20px; color:#344054; }
    .notice-head { display:flex; justify-content:space-between; align-items:center; gap:15px; margin-bottom:22px; }
    .page-title { font-size:26px; font-weight:700; margin-bottom:6px; }
    .page-sub { color:#667085; }
    .notice-stats { display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:15px; margin-bottom:22px; }
    .notice-stat { background:#fff; border:1px solid #eaecf0; border-radius:12px; padding:20px; display:flex; justify-content:space-between; align-items:center; }
    .notice-stat .label { color:#667085; font-size:13px; }
    .notice-stat .value { font-size:27px; font-weight:700; margin-top:5px; }
    .notice-stat .note { display:block; color:#667085; font-size:12px; font-weight:400; }
    .notice-stat .stat-icon { font-size:22px; padding:12px; border-radius:10px; background:#eff8ff; color:#1570ef; }
    .notice-stat .green { background:#ecfdf3; color:#039855; }
    .notice-stat .amber { background:#fffaeb; color:#dc6803; }
    .notice-form { background:#fff; border:1px solid #e4e7ec; border-radius:12px; padding:20px; margin-bottom:20px; }
    .notice-form h3 { font-size:20px; font-weight:700; margin:0 0 18px; }
    .notice-form-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:15px; }
    .notice-form-grid .full { grid-column:1/-1; }
    .notice-form-grid label { display:block; font-weight:600; margin-bottom:6px; }
    .notice-form-grid .form-control, .notice-form-grid .form-select { min-height:42px; }
    .notice-form-actions { display:flex; gap:10px; flex-wrap:wrap; margin-top:18px; }
    .notice-toolbar { display:flex; align-items:center; justify-content:space-between; gap:12px; padding:16px; flex-wrap:wrap; }
    .notice-toolbar-left, .notice-toolbar-right { display:flex; align-items:center; gap:8px; flex-wrap:wrap; }
    .notice-toolbar .form-control, .notice-toolbar .form-select { width:auto; min-width:145px; }
    .notice-table-wrap { overflow-x:auto; }
    .notice-table { width:100%; min-width:850px; border-collapse:collapse; }
    .notice-table th { background:#f8fafc; color:#475467; text-align:left; font-size:12px; padding:14px 12px; border-bottom:1px solid #e4e7ec; }
    .notice-table td { padding:14px 12px; border-bottom:1px solid #edf0f4; vertical-align:top; }
    .td-sub { display:block; font-size:12px; color:#667085; margin-top:5px; max-width:300px; }
    .notice-category, .notice-status { display:inline-block; padding:5px 9px; border-radius:20px; font-size:12px; white-space:nowrap; }
    .cat-general { background:#eff8ff; color:#175cd3; }
    .cat-mess { background:#fffaeb; color:#b54708; }
    .cat-maintenance { background:#fef3f2; color:#b42318; }
    .cat-events { background:#f4f3ff; color:#5925dc; }
    .cat-other { background:#f2f4f7; color:#344054; }
    .status-published { background:#ecfdf3; color:#027a48; }
    .status-scheduled { background:#fffaeb; color:#b54708; }
    .status-expired { background:#f2f4f7; color:#475467; }
    .notice-actions { display:flex; gap:5px; flex-wrap:wrap; }
    .notice-actions .btn { font-size:12px; padding:5px 8px; }
    .notice-footer { display:flex; justify-content:space-between; align-items:center; gap:12px; flex-wrap:wrap; padding:16px; }
    .notice-pager { display:flex; gap:5px; align-items:center; }
    .notice-message { display:block; margin-bottom:14px; }
    @media(max-width:800px) {
        .notice-stats { grid-template-columns:1fr; }
        .notice-head { align-items:flex-start; flex-direction:column; }
    }
    @media(max-width:600px) {
        .notice-form-grid { grid-template-columns:1fr; }
        .notice-form-grid .full { grid-column:auto; }
        .notice-page { padding:10px; }
    }
</style>

<div class="notice-page">

    <div class="notice-head">
        <div>
            <h1 class="page-title">Notices &amp; Announcements</h1>
            <p class="page-sub">Manage and publish hostel-wide communications.</p>
        </div>
        <asp:Button ID="btnCreateNotice" runat="server"
            Text="+ Create New Notice" CssClass="btn btn-primary"
            OnClick="btnCreateNotice_Click" />
    </div>

    <asp:Label ID="lblMessage" runat="server"
        EnableViewState="false" CssClass="notice-message" />

    <div class="notice-stats">
        <div class="notice-stat">
            <div>
                <div class="label">Total Notices</div>
                <div class="value"><asp:Label ID="lblTotalNotices" runat="server" Text="0" /></div>
                <span class="note">All notices</span>
            </div>
            <div class="stat-icon"><i class="bi bi-megaphone"></i></div>
        </div>

        <div class="notice-stat">
            <div>
                <div class="label">Published Notices</div>
                <div class="value"><asp:Label ID="lblPublished" runat="server" Text="0" /></div>
                <span class="note">Currently published</span>
            </div>
            <div class="stat-icon green"><i class="bi bi-eye"></i></div>
        </div>

        <div class="notice-stat">
            <div>
                <div class="label">Scheduled Notices</div>
                <div class="value"><asp:Label ID="lblScheduled" runat="server" Text="0" /></div>
                <span class="note">Upcoming announcements</span>
            </div>
            <div class="stat-icon amber"><i class="bi bi-clock"></i></div>
        </div>
    </div>

    <asp:Panel ID="pnlNoticeForm" runat="server" CssClass="notice-form" Visible="false">
        <h3><asp:Label ID="lblFormTitle" runat="server" Text="Create New Notice" /></h3>
        <asp:HiddenField ID="hfNoticeId" runat="server" />

        <div class="notice-form-grid">
            <div class="full">
                <label for="<%= txtTitle.ClientID %>">Notice Title *</label>
                <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control"
                    MaxLength="200" placeholder="Enter notice title" />
            </div>

            <div>
                <label for="<%= ddlCategory.ClientID %>">Category *</label>
                <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                    <asp:ListItem Value="General">General</asp:ListItem>
                    <asp:ListItem Value="Mess">Mess</asp:ListItem>
                    <asp:ListItem Value="Maintenance">Maintenance</asp:ListItem>
                    <asp:ListItem Value="Events">Events</asp:ListItem>
                    <asp:ListItem Value="Other">Other</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div>
                <label for="<%= ddlAudience.ClientID %>">Target Audience *</label>
                <asp:DropDownList ID="ddlAudience" runat="server" CssClass="form-select">
                    <asp:ListItem Value="All Students">All Students</asp:ListItem>
                    <asp:ListItem Value="All Students, Staff">All Students, Staff</asp:ListItem>
                    <asp:ListItem Value="Block A">Block A</asp:ListItem>
                    <asp:ListItem Value="Block B">Block B</asp:ListItem>
                    <asp:ListItem Value="Block C">Block C</asp:ListItem>
                    <asp:ListItem Value="Staff">Staff</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div>
                <label for="<%= txtPublishDate.ClientID %>">Publish Date *</label>
                <asp:TextBox ID="txtPublishDate" runat="server" CssClass="form-control"
                    TextMode="Date" />
            </div>

            <div>
                <label for="<%= ddlStatus.ClientID %>">Status *</label>
                <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Value="Published">Published</asp:ListItem>
                    <asp:ListItem Value="Scheduled">Scheduled</asp:ListItem>
                    <asp:ListItem Value="Expired">Expired</asp:ListItem>
                </asp:DropDownList>
            </div>

            <div class="full">
                <label for="<%= txtDescription.ClientID %>">Notice Description *</label>
                <asp:TextBox ID="txtDescription" runat="server"
                    CssClass="form-control" TextMode="MultiLine" Rows="5"
                    MaxLength="5000" placeholder="Write the complete announcement..." />
            </div>
        </div>

        <div class="notice-form-actions">
            <asp:Button ID="btnSaveNotice" runat="server" Text="Save Notice"
                CssClass="btn btn-primary" OnClick="btnSaveNotice_Click" />
            <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                CssClass="btn btn-outline-secondary" CausesValidation="false"
                OnClick="btnCancel_Click" />
        </div>
    </asp:Panel>

    <div class="table-card">

        <div class="notice-toolbar">
            <div class="notice-toolbar-left">
                <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                    placeholder="Search notices..." />
                <asp:Button ID="btnSearch" runat="server" Text="Search"
                    CssClass="btn btn-primary" OnClick="btnSearch_Click" />
                <asp:Button ID="btnReset" runat="server" Text="Reset"
                    CssClass="btn btn-outline-secondary" OnClick="btnReset_Click" />
            </div>

            <div class="notice-toolbar-right">
                <asp:DropDownList ID="ddlFilterCategory" runat="server"
                    CssClass="form-select">
                    <asp:ListItem Value="">All Categories</asp:ListItem>
                    <asp:ListItem Value="General">General</asp:ListItem>
                    <asp:ListItem Value="Mess">Mess</asp:ListItem>
                    <asp:ListItem Value="Maintenance">Maintenance</asp:ListItem>
                    <asp:ListItem Value="Events">Events</asp:ListItem>
                    <asp:ListItem Value="Other">Other</asp:ListItem>
                </asp:DropDownList>

                <asp:DropDownList ID="ddlFilterStatus" runat="server"
                    CssClass="form-select">
                    <asp:ListItem Value="">All Statuses</asp:ListItem>
                    <asp:ListItem Value="Published">Published</asp:ListItem>
                    <asp:ListItem Value="Scheduled">Scheduled</asp:ListItem>
                    <asp:ListItem Value="Expired">Expired</asp:ListItem>
                </asp:DropDownList>

                <asp:Button ID="btnFilter" runat="server" Text="Apply Filter"
                    CssClass="btn btn-outline-primary" OnClick="btnFilter_Click" />

                <asp:Button ID="btnExportCsv" runat="server" Text="Export CSV"
                    CssClass="btn btn-outline-secondary" OnClick="btnExportCsv_Click" />
            </div>
        </div>

        <div class="notice-table-wrap">
            <table class="notice-table">
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Publish Date</th>
                        <th>Target Audience</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptNotices" runat="server"
                        OnItemCommand="rptNotices_ItemCommand">
                        <ItemTemplate>
                            <tr>
                                <td>
                                    <b><%#: Eval("Title") %></b>
                                    <span class="td-sub"><%#: Eval("Description") %></span>
                                </td>
                                <td>
                                    <span class='notice-category <%# GetCategoryCss(Convert.ToString(Eval("Category"))) %>'>
                                        <%#: Eval("Category") %>
                                    </span>
                                </td>
                                <td><%#: Convert.ToDateTime(Eval("PublishDate")).ToString("dd MMM yyyy") %></td>
                                <td><%#: Eval("Audience") %></td>
                                <td>
                                    <span class='notice-status <%# GetStatusCss(Convert.ToString(Eval("Status"))) %>'>
                                        <%#: Eval("Status") %>
                                    </span>
                                </td>
                                <td>
                                    <div class="notice-actions">
                                        <asp:LinkButton ID="btnView" runat="server" Text="View"
                                            CssClass="btn btn-outline-secondary"
                                            CausesValidation="false" CommandName="ViewNotice"
                                            CommandArgument='<%# Eval("Id") %>' />

                                        <asp:LinkButton ID="btnEdit" runat="server" Text="Edit"
                                            CssClass="btn btn-outline-primary"
                                            CausesValidation="false" CommandName="EditNotice"
                                            CommandArgument='<%# Eval("Id") %>' />

                                        <asp:LinkButton ID="btnDelete" runat="server" Text="Delete"
                                            CssClass="btn btn-outline-danger"
                                            CausesValidation="false" CommandName="DeleteNotice"
                                            CommandArgument='<%# Eval("Id") %>'
                                            OnClientClick="return confirm('Are you sure you want to delete this notice?');" />
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>

                    <tr id="trNoNotices" runat="server" visible="false">
                        <td colspan="6" class="text-center text-muted" style="padding:25px;">
                            No notices found.
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <div class="notice-footer">
            <asp:Label ID="lblPageInfo" runat="server" Text="Showing 0 notices" />
            <div class="notice-pager">
                <asp:Button ID="btnPrevious" runat="server" Text="‹ Previous"
                    CssClass="btn btn-sm btn-outline-secondary"
                    CausesValidation="false" OnClick="btnPrevious_Click" />
                <asp:Label ID="lblPageNumber" runat="server"
                    CssClass="btn btn-sm btn-primary" Text="1" />
                <asp:Button ID="btnNext" runat="server" Text="Next ›"
                    CssClass="btn btn-sm btn-outline-secondary"
                    CausesValidation="false" OnClick="btnNext_Click" />
            </div>
        </div>

    </div>
</div>

</asp:Content>