<%@ Page Title="Mess" MasterPageFile="~/AdminLayout.master"
    Language="C#" AutoEventWireup="true"
    CodeBehind="MessManagement.aspx.cs"
    Inherits="HostelHub.Admin.MessManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .mess-page { padding:20px; color:#344054; }
    .page-title { font-size:26px; font-weight:700; margin:0 0 6px; }
    .page-sub { color:#667085; margin-bottom:22px; }
    .mess-panels { display:grid; grid-template-columns:1fr 1.35fr; gap:18px; margin-bottom:22px; }
    .mess-panel { background:#fff; border:1px solid #e4e7ec; border-radius:12px; padding:20px; }
    .panel-head { display:flex; align-items:center; justify-content:space-between; gap:12px; }
    .panel-head h5 { margin:0; font-size:18px; font-weight:700; }
    .badge-day { background:#eef4ff; color:#3538cd; padding:6px 10px; border-radius:20px; font-size:12px; }
    .meal { display:flex; gap:12px; padding:15px 0; border-bottom:1px solid #eaecf0; line-height:1.5; }
    .meal:last-child { border-bottom:0; }
    .meal .ico { min-width:40px; height:40px; display:flex; align-items:center; justify-content:center; border-radius:10px; background:#f2f4f7; font-size:20px; }
    .meal small { display:block; color:#667085; margin-bottom:4px; }
    .fb { padding:15px 0; border-bottom:1px solid #eaecf0; line-height:1.6; }
    .fb:last-child { border-bottom:0; }
    .fb .top { display:flex; justify-content:space-between; gap:10px; margin-bottom:6px; }
    .stars { color:#f79009; white-space:nowrap; }
    .mess-form { padding:20px; border:1px solid #e4e7ec; border-radius:12px; background:#fff; margin-bottom:20px; }
    .mess-form h3 { font-size:20px; margin:0 0 18px; }
    .form-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:15px; }
    .form-grid label { display:block; font-weight:600; margin-bottom:6px; }
    .form-grid .form-control, .form-grid .form-select { min-height:42px; }
    .form-actions { display:flex; flex-wrap:wrap; gap:10px; margin-top:18px; }
    .menu-toolbar { display:flex; flex-wrap:wrap; align-items:center; justify-content:space-between; gap:12px; padding:16px; }
    .menu-toolbar h5 { margin:0; font-size:18px; font-weight:700; }
    .menu-table-wrap { overflow-x:auto; }
    .hh-table { width:100%; min-width:850px; border-collapse:collapse; }
    .hh-table th { background:#f8fafc; padding:14px 12px; text-align:left; font-size:12px; color:#475467; border-bottom:1px solid #e4e7ec; }
    .hh-table td { padding:14px 12px; border-bottom:1px solid #edf0f4; vertical-align:top; }
    .menu-actions { display:flex; flex-wrap:wrap; gap:5px; }
    .menu-actions .btn { padding:5px 8px; font-size:12px; }
    .mess-message { display:block; margin-bottom:12px; }
    .today-menu-list { margin-top:15px; }
    @media(max-width:900px) { .mess-panels { grid-template-columns:1fr; } }
    @media(max-width:600px) { .form-grid { grid-template-columns:1fr; } .panel-head { align-items:flex-start; flex-direction:column; } }
</style>

<div class="mess-page">

    <h1 class="page-title">Mess Management</h1>
    <p class="page-sub">Oversee daily menus, track student feedback, and manage weekly meal schedules.</p>

    <asp:Label ID="lblMessage" runat="server" EnableViewState="false"
        CssClass="mess-message" />

    <div class="mess-panels">
        <div class="mess-panel">
            <div class="panel-head">
                <h5><i class="bi bi-calendar-event"></i> Today's Menu</h5>
                <asp:Label ID="lblToday" runat="server" CssClass="badge-day" />
            </div>
            <hr />
            <asp:Panel ID="pnlTodayMenu" runat="server" CssClass="today-menu-list">
                <div class="meal">
                    <div class="ico"><i class="bi bi-brightness-high"></i></div>
                    <div><small>Breakfast (7:30 - 9:30 AM)</small>
                        <asp:Label ID="lblTodayBreakfast" runat="server" /></div>
                </div>
                <div class="meal">
                    <div class="ico"><i class="bi bi-egg-fried"></i></div>
                    <div><small>Lunch (12:30 - 2:30 PM)</small>
                        <asp:Label ID="lblTodayLunch" runat="server" /></div>
                </div>
                <div class="meal">
                    <div class="ico"><i class="bi bi-moon-stars"></i></div>
                    <div><small>Dinner (7:30 - 9:30 PM)</small>
                        <asp:Label ID="lblTodayDinner" runat="server" /></div>
                </div>
            </asp:Panel>
        </div>

        <div class="mess-panel">
            <div class="panel-head">
                <h5><i class="bi bi-chat-square-text"></i> Feedback Overview</h5>
                <span class="badge-day">
                    <i class="bi bi-star-fill"></i>
                    <asp:Label ID="lblAverageRating" runat="server" Text="0.0" /> / 5.0
                </span>
            </div>
            <hr />
            <asp:Repeater ID="rptFeedback" runat="server">
                <ItemTemplate>
                    <div class="fb">
                        <div class="top">
                            <span>
                                <b>Room <%#: Eval("Room") %></b>
                                <span class="stars"><%#: GetStars(Convert.ToInt32(Eval("Rating"))) %></span>
                            </span>
                            <span><%#: Convert.ToDateTime(Eval("Date")).ToString("dd MMM yyyy") %></span>
                        </div>
                        <%#: Eval("Comment") %>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            <asp:Label ID="lblNoFeedback" runat="server" Visible="false"
                Text="No feedback has been submitted yet." CssClass="text-muted" />
        </div>
    </div>

    <asp:Panel ID="pnlMenuForm" runat="server" CssClass="mess-form" Visible="false">
        <h3><asp:Label ID="lblFormTitle" runat="server" Text="Update Menu" /></h3>
        <asp:HiddenField ID="hfOriginalDay" runat="server" />

        <div class="form-grid">
            <div>
                <label for="<%= ddlDay.ClientID %>">Day</label>
                <asp:DropDownList ID="ddlDay" runat="server" CssClass="form-select">
                    <asp:ListItem>Monday</asp:ListItem>
                    <asp:ListItem>Tuesday</asp:ListItem>
                    <asp:ListItem>Wednesday</asp:ListItem>
                    <asp:ListItem>Thursday</asp:ListItem>
                    <asp:ListItem>Friday</asp:ListItem>
                    <asp:ListItem>Saturday</asp:ListItem>
                    <asp:ListItem>Sunday</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div>
                <label for="<%= txtBreakfast.ClientID %>">Breakfast</label>
                <asp:TextBox ID="txtBreakfast" runat="server" CssClass="form-control"
                    MaxLength="500" placeholder="Breakfast menu" />
            </div>
            <div>
                <label for="<%= txtLunch.ClientID %>">Lunch</label>
                <asp:TextBox ID="txtLunch" runat="server" CssClass="form-control"
                    MaxLength="500" placeholder="Lunch menu" />
            </div>
            <div>
                <label for="<%= txtDinner.ClientID %>">Dinner</label>
                <asp:TextBox ID="txtDinner" runat="server" CssClass="form-control"
                    MaxLength="500" placeholder="Dinner menu" />
            </div>
        </div>

        <div class="form-actions">
            <asp:Button ID="btnSaveMenu" runat="server" Text="Save Menu"
                CssClass="btn btn-primary" OnClick="btnSaveMenu_Click" />
            <asp:Button ID="btnCancelMenu" runat="server" Text="Cancel"
                CssClass="btn btn-outline-secondary" CausesValidation="false"
                OnClick="btnCancelMenu_Click" />
        </div>
    </asp:Panel>

    <div class="table-card">
        <div class="menu-toolbar">
            <h5><i class="bi bi-table"></i> Weekly Menu Management</h5>
            <div class="d-flex flex-wrap gap-2">
                <asp:Button ID="btnAddMenu" runat="server" Text="+ Add Menu"
                    CssClass="btn btn-dark" CausesValidation="false" OnClick="btnAddMenu_Click" />
            </div>
        </div>

        <div class="menu-table-wrap">
            <table class="hh-table">
                <thead>
                    <tr>
                        <th>DAY</th>
                        <th>BREAKFAST</th>
                        <th>LUNCH</th>
                        <th>DINNER</th>
                        <th>ACTIONS</th>
                    </tr>
                </thead>
                <tbody>
                    <asp:Repeater ID="rptMenu" runat="server" OnItemCommand="rptMenu_ItemCommand">
                        <ItemTemplate>
                            <tr>
                                <td><b><%#: Eval("Day") %></b></td>
                                <td><%#: Eval("Breakfast") %></td>
                                <td><%#: Eval("Lunch") %></td>
                                <td><%#: Eval("Dinner") %></td>
                                <td>
                                    <div class="menu-actions">
                                        <asp:LinkButton ID="btnEdit" runat="server" Text="Edit"
                                            CssClass="btn btn-outline-primary" CausesValidation="false"
                                            CommandName="EditMenu" CommandArgument='<%# Eval("Day") %>' />
                                        <asp:LinkButton ID="btnDelete" runat="server" Text="Delete"
                                            CssClass="btn btn-outline-danger" CausesValidation="false"
                                            CommandName="DeleteMenu" CommandArgument='<%# Eval("Day") %>'
                                            OnClientClick="return confirm('Delete this day menu?');" />
                                    </div>
                                </td>
                            </tr>
                        </ItemTemplate>
                    </asp:Repeater>
                    <tr id="trNoMenu" runat="server" visible="false">
                        <td colspan="5" class="text-center text-muted py-4">No menu records found.</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>

</div>
</asp:Content>