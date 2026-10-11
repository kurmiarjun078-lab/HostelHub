<%@ Page Title="Rooms" MasterPageFile="~/AdminLayout.master"
    Language="C#" AutoEventWireup="true"
    CodeBehind="RoomManagement.aspx.cs"
    Inherits="HostelHub.Admin.RoomManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .room-page { padding: 20px; color: #344054; }
    .page-head { display:flex; justify-content:space-between; align-items:center; gap:15px; margin-bottom:22px; }
    .page-title { margin:0; font-size:26px; font-weight:700; }
    .page-sub { margin:6px 0 0; color:#667085; }
    .room-stats { display:grid; grid-template-columns:repeat(3,minmax(0,1fr)); gap:16px; margin-bottom:20px; }
    .room-stat { padding:20px; background:#fff; border:1px solid #e4e7ec; border-radius:12px; }
    .room-stat .label { color:#667085; font-size:14px; }
    .room-stat .value { font-size:28px; font-weight:700; margin-top:7px; }
    .room-toolbar { display:grid; grid-template-columns:minmax(200px,1fr) 180px 180px 100px; gap:12px; padding:16px; background:#f4f7fb; border:1px solid #dfe5ed; border-radius:12px 12px 0 0; }
    .room-toolbar .form-control, .room-toolbar .form-select { min-height:44px; border-radius:8px; }
    .room-toolbar .btn { min-height:44px; border-radius:8px; }
    .room-table-wrap { overflow-x:auto; border:1px solid #dfe5ed; border-top:0; }
    .hh-table { width:100%; min-width:850px; border-collapse:collapse; }
    .hh-table th { padding:15px 12px; background:#f8fafc; text-align:left; font-size:13px; white-space:nowrap; border-bottom:1px solid #e4e7ec; }
    .hh-table td { padding:14px 12px; border-bottom:1px solid #edf0f4; vertical-align:middle; }
    .room-status { display:inline-block; padding:5px 10px; border-radius:20px; font-size:12px; font-weight:600; }
    .status-available { color:#067647; background:#dcfae6; }
    .status-full { color:#b42318; background:#fee4e2; }
    .status-empty { color:#175cd3; background:#dbeafe; }
    .status-partial { color:#b54708; background:#fef0c7; }
    .room-actions { display:flex; gap:5px; }
    .room-actions .btn { padding:5px 8px; font-size:12px; }
    .room-form { padding:20px; background:#fff; border:1px solid #e4e7ec; border-radius:12px; margin-bottom:20px; }
    .room-form h3 { font-size:20px; margin:0 0 18px; }
    .room-form-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:15px; }
    .room-form-grid label { display:block; margin-bottom:6px; font-weight:600; }
    .room-form-grid .form-control, .room-form-grid .form-select { min-height:42px; }
    .room-form-actions { display:flex; gap:10px; margin-top:18px; }
    .room-pagination { display:flex; justify-content:space-between; align-items:center; gap:10px; padding:15px; }
    @media(max-width:800px) {
        .room-toolbar { grid-template-columns:1fr 1fr; }
        .room-stats { grid-template-columns:1fr; }
    }
    @media(max-width:500px) {
        .page-head { align-items:flex-start; flex-direction:column; }
        .room-toolbar, .room-form-grid { grid-template-columns:1fr; }
    }
</style>

<div class="room-page">

    <div class="page-head">
        <div>
            <h1 class="page-title">Room Management</h1>
            <p class="page-sub">Manage capacity, allocations, and room status across all blocks.</p>
        </div>
        <asp:Button ID="btnAddRoom" runat="server" Text="+ Add Room"
            CssClass="btn btn-dark" OnClick="btnAddRoom_Click" />
    </div>

    <asp:Label ID="lblMessage" runat="server" EnableViewState="false" />

    <div class="room-stats">
        <div class="room-stat">
            <div class="label">Total Rooms</div>
            <div class="value"><asp:Label ID="lblTotalRooms" runat="server" Text="0" /></div>
        </div>
        <div class="room-stat">
            <div class="label">Total Occupied Beds</div>
            <div class="value"><asp:Label ID="lblOccupiedBeds" runat="server" Text="0" /></div>
        </div>
        <div class="room-stat">
            <div class="label">Available Beds</div>
            <div class="value"><asp:Label ID="lblAvailableBeds" runat="server" Text="0" /></div>
        </div>
    </div>

    <asp:Panel ID="pnlRoomForm" runat="server" CssClass="room-form" Visible="false">
        <h3><asp:Label ID="lblFormTitle" runat="server" Text="Add Room" /></h3>
        <asp:HiddenField ID="hfRoomId" runat="server" />

        <div class="room-form-grid">
            <div>
                <label for="<%= txtRoomNumber.ClientID %>">Room Number</label>
                <asp:TextBox ID="txtRoomNumber" runat="server" CssClass="form-control"
                    MaxLength="30" placeholder="e.g. A-101" />
            </div>
            <div>
                <label for="<%= ddlBlock.ClientID %>">Block</label>
                <asp:DropDownList ID="ddlBlock" runat="server" CssClass="form-select">
                    <asp:ListItem Value="Block A">Block A</asp:ListItem>
                    <asp:ListItem Value="Block B">Block B</asp:ListItem>
                    <asp:ListItem Value="Block C">Block C</asp:ListItem>
                    <asp:ListItem Value="Block D">Block D</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div>
                <label for="<%= txtFloor.ClientID %>">Floor</label>
                <asp:TextBox ID="txtFloor" runat="server" CssClass="form-control"
                    TextMode="Number" Text="1" />
            </div>
            <div>
                <label for="<%= txtCapacity.ClientID %>">Bed Capacity</label>
                <asp:TextBox ID="txtCapacity" runat="server" CssClass="form-control"
                    TextMode="Number" Text="4" />
            </div>
            <div>
                <label for="<%= txtOccupied.ClientID %>">Occupied Beds</label>
                <asp:TextBox ID="txtOccupied" runat="server" CssClass="form-control"
                    TextMode="Number" Text="0" />
            </div>
        </div>

        <div class="room-form-actions">
            <asp:Button ID="btnSaveRoom" runat="server" Text="Save Room"
                CssClass="btn btn-primary" OnClick="btnSaveRoom_Click" />
            <asp:Button ID="btnCancelRoom" runat="server" Text="Cancel"
                CssClass="btn btn-outline-secondary" CausesValidation="false"
                OnClick="btnCancelRoom_Click" />
        </div>
    </asp:Panel>

    <div class="room-toolbar">
        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
            placeholder="Search room or block..." />
        <asp:Button ID="btnSearch" runat="server" Text="Search"
            CssClass="btn btn-primary" OnClick="btnSearch_Click" />

        <asp:DropDownList ID="ddlBlockFilter" runat="server" CssClass="form-select">
            <asp:ListItem Value="">All Blocks</asp:ListItem>
            <asp:ListItem Value="Block A">Block A</asp:ListItem>
            <asp:ListItem Value="Block B">Block B</asp:ListItem>
            <asp:ListItem Value="Block C">Block C</asp:ListItem>
            <asp:ListItem Value="Block D">Block D</asp:ListItem>
        </asp:DropDownList>

        <asp:DropDownList ID="ddlStatusFilter" runat="server" CssClass="form-select">
            <asp:ListItem Value="">All Statuses</asp:ListItem>
            <asp:ListItem Value="Available">Available</asp:ListItem>
            <asp:ListItem Value="Full">Full</asp:ListItem>
            <asp:ListItem Value="Empty">Empty</asp:ListItem>
            <asp:ListItem Value="Partial">Partial</asp:ListItem>
        </asp:DropDownList>


    </div>

    <div class="room-table-wrap">
        <table class="hh-table">
            <thead>
                <tr>
                    <th>ROOM</th>
                    <th>BLOCK</th>
                    <th>FLOOR</th>
                    <th>CAPACITY</th>
                    <th>OCCUPIED</th>
                    <th>AVAILABLE</th>
                    <th>STATUS</th>
                    <th>ACTIONS</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptRooms" runat="server" OnItemCommand="rptRooms_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <td><strong><%#: Eval("RoomNumber") %></strong></td>
                            <td><%#: Eval("Block") %></td>
                            <td><%#: Eval("Floor") %></td>
                            <td><%#: Eval("Capacity") %></td>
                            <td><%#: Eval("Occupied") %></td>
                            <td><%#: Convert.ToInt32(Eval("Capacity")) - Convert.ToInt32(Eval("Occupied")) %></td>
                            <td>
                                <span class='room-status <%# GetStatusCss(Convert.ToString(Eval("Status"))) %>'>
                                    <%#: Eval("Status") %>
                                </span>
                            </td>
                            <td>
                                <div class="room-actions">
                                    <asp:LinkButton ID="btnView" runat="server" Text="View"
                                        CssClass="btn btn-outline-info" CausesValidation="false"
                                        CommandName="ViewRoom" CommandArgument='<%# Eval("Id") %>' />
                                    <asp:LinkButton ID="btnEdit" runat="server" Text="Edit"
                                        CssClass="btn btn-outline-primary" CausesValidation="false"
                                        CommandName="EditRoom" CommandArgument='<%# Eval("Id") %>' />
                                    <asp:LinkButton ID="btnDelete" runat="server" Text="Delete"
                                        CssClass="btn btn-outline-danger" CausesValidation="false"
                                        CommandName="DeleteRoom" CommandArgument='<%# Eval("Id") %>'
                                        OnClientClick="return confirm('Delete this room?');" />
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>
                <tr id="trNoRooms" runat="server" visible="false">
                    <td colspan="8" class="text-center text-muted py-4">No rooms found.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="room-pagination">
        <asp:Label ID="lblPageInfo" runat="server" Text="Page 1 of 1" />
        <div class="d-flex gap-2">
            <asp:Button ID="btnPrevious" runat="server" Text="Previous"
                CssClass="btn btn-outline-secondary" OnClick="btnPrevious_Click" />
            <asp:Button ID="btnNext" runat="server" Text="Next"
                CssClass="btn btn-outline-secondary" OnClick="btnNext_Click" />
        </div>
    </div>

</div>
</asp:Content>