<%@ Page Title="Student Management" Language="C#" MasterPageFile="~/AdminLayout.master"
    AutoEventWireup="true" CodeBehind="StudentManagement.aspx.cs"
    Inherits="HostelHub.Admin.StudentManagement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<style>
    .student-page { padding: 20px; color: #344054; }
    .page-heading { display:flex; justify-content:space-between; align-items:center; gap:12px; margin-bottom:20px; }
    .page-heading h2 { margin:0; font-size:25px; font-weight:700; }
    .toolbar {
        display:grid;
        grid-template-columns:minmax(220px,1fr) 170px 110px 90px;
        align-items:center; gap:14px; padding:16px;
        background:#f4f7fb; border:1px solid #dfe5ed;
        border-radius:12px 12px 0 0;
    }
    .toolbar .form-control, .toolbar .form-select {
        min-height:44px; border:1px solid #dce3ec;
        border-radius:8px; box-shadow:none;
    }
    .toolbar .btn { min-height:44px; border-radius:8px; white-space:nowrap; }
    .table-wrap { overflow-x:auto; border:1px solid #dfe5ed; border-top:0; }
    .student-table { width:100%; min-width:850px; border-collapse:collapse; }
    .student-table th { padding:15px 12px; background:#f8fafc; text-align:left;
        font-size:13px; font-weight:700; white-space:nowrap; border-bottom:1px solid #dfe5ed; }
    .student-table td { padding:14px 12px; border-bottom:1px solid #edf0f4; vertical-align:middle; }
    .student-table tr:last-child td { border-bottom:0; }
    .status-badge { display:inline-block; padding:5px 10px; border-radius:20px;
        font-size:12px; font-weight:600; }
    .status-active { color:#067647; background:#dcfae6; }
    .status-inactive { color:#b42318; background:#fee4e2; }
    .action-buttons { display:flex; gap:6px; }
    .action-buttons .btn { padding:5px 9px; font-size:13px; }
    .student-card { background:#fff; border:1px solid #dfe5ed; border-radius:10px; padding:20px; margin-bottom:20px; }
    .student-card h3 { margin:0 0 16px; font-size:19px; }
    .form-grid { display:grid; grid-template-columns:repeat(2,minmax(0,1fr)); gap:15px; }
    .form-field label { display:block; font-weight:600; margin-bottom:6px; }
    .form-field .form-control, .form-field .form-select { min-height:42px; }
    .form-actions { display:flex; gap:10px; margin-top:18px; }
    .summary { display:flex; flex-wrap:wrap; gap:12px; margin-bottom:18px; }
    .summary-item { flex:1; min-width:130px; padding:15px; border:1px solid #e2e8f0; border-radius:10px; background:#fff; }
    .summary-item span { display:block; color:#667085; font-size:13px; }
    .summary-item strong { display:block; font-size:24px; margin-top:5px; }
    .pagination-row { display:flex; justify-content:space-between; align-items:center; gap:10px; padding:15px; }
    .message { display:block; margin:10px 0; }
    @media(max-width:768px) {
        .toolbar { grid-template-columns:1fr 1fr; }
        .toolbar .search-input { grid-column:1/-1; }
        .page-heading { align-items:flex-start; flex-direction:column; }
        .form-grid { grid-template-columns:1fr; }
    }
    @media(max-width:420px) { .toolbar { grid-template-columns:1fr; } .toolbar .search-input { grid-column:auto; } }
</style>

<div class="student-page">

    <div class="page-heading">
        <div>
            <h2>Students Management</h2>
            <div class="text-muted">Manage student records and enrollment details.</div>
        </div>
        <asp:Button ID="btnShowAdd" runat="server" Text="+ Add Student"
            CssClass="btn btn-primary" OnClick="btnShowAdd_Click" />
    </div>

    <asp:Label ID="lblMessage" runat="server" CssClass="message" />

    <div class="summary">
        <div class="summary-item"><span>Total Students</span><strong><asp:Label ID="lblTotal" runat="server" Text="0" /></strong></div>
        <div class="summary-item"><span>Active Students</span><strong><asp:Label ID="lblActive" runat="server" Text="0" /></strong></div>
        <div class="summary-item"><span>Inactive Students</span><strong><asp:Label ID="lblInactive" runat="server" Text="0" /></strong></div>
    </div>

    <asp:Panel ID="pnlStudentForm" runat="server" CssClass="student-card" Visible="false">
        <h3><asp:Label ID="lblFormTitle" runat="server" Text="Add Student" /></h3>

        <asp:HiddenField ID="hfStudentId" runat="server" />

        <div class="form-grid">
            <div class="form-field">
                <label for="<%= txtName.ClientID %>">Student Name</label>
                <asp:TextBox ID="txtName" runat="server" CssClass="form-control" MaxLength="100" />
            </div>
            <div class="form-field">
                <label for="<%= txtEnrollment.ClientID %>">Enrollment No.</label>
                <asp:TextBox ID="txtEnrollment" runat="server" CssClass="form-control" MaxLength="50" />
            </div>
            <div class="form-field">
                <label for="<%= txtDepartment.ClientID %>">Department</label>
                <asp:TextBox ID="txtDepartment" runat="server" CssClass="form-control" MaxLength="100" />
            </div>
            <div class="form-field">
                <label for="<%= txtRoom.ClientID %>">Room No.</label>
                <asp:TextBox ID="txtRoom" runat="server" CssClass="form-control" MaxLength="30" />
            </div>
            <div class="form-field">
                <label for="<%= ddlStudentStatus.ClientID %>">Status</label>
                <asp:DropDownList ID="ddlStudentStatus" runat="server" CssClass="form-select">
                    <asp:ListItem Value="Active">Active</asp:ListItem>
                    <asp:ListItem Value="Inactive">Inactive</asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <div class="form-actions">
            <asp:Button ID="btnSaveStudent" runat="server" Text="Save Student"
                CssClass="btn btn-primary" OnClick="btnSaveStudent_Click" />
            <asp:Button ID="btnCancelForm" runat="server" Text="Cancel"
                CssClass="btn btn-outline-secondary" CausesValidation="false"
                OnClick="btnCancelForm_Click" />
        </div>
    </asp:Panel>

    <div class="toolbar">
        <div class="search-input">
            <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control"
                placeholder="Search by name or enrollment." />
        </div>
         <div>
            <asp:Button ID="btnSearch" runat="server" Text="Search"
            CssClass="btn btn-primary w-100" OnClick="btnSearch_Click" />
        </div>

        <div>
            <asp:DropDownList ID="ddlFilterStatus" runat="server" CssClass="form-select">
                <asp:ListItem Value="">All Statuses</asp:ListItem>
                <asp:ListItem Value="Active">Active</asp:ListItem>
                <asp:ListItem Value="Inactive">Inactive</asp:ListItem>
            </asp:DropDownList>
        </div>

       
    </div>

    <div class="table-wrap">
        <table class="student-table">
            <thead>
                <tr>
                    <th>STUDENT NAME</th>
                    <th>ENROLLMENT NO.</th>
                    <th>DEPARTMENT</th>
                    <th>ROOM NO.</th>
                    <th>STATUS</th>
                    <th>ACTIONS</th>
                </tr>
            </thead>
            <tbody>
                <asp:Repeater ID="rptStudents" runat="server" OnItemCommand="rptStudents_ItemCommand">
                    <ItemTemplate>
                        <tr>
                            <td><strong><%#: Eval("Name") %></strong></td>
                            <td><%#: Eval("Enrollment") %></td>
                            <td><%#: Eval("Department") %></td>
                            <td><%#: Eval("Room") %></td>
                            <td>
                                <span class='status-badge <%# Convert.ToString(Eval("Status")) == "Active" ? "status-active" : "status-inactive" %>'>
                                    <%#: Eval("Status") %>
                                </span>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <asp:LinkButton ID="btnView" runat="server" Text="View"
                                        CssClass="btn btn-outline-info"
                                        CommandName="ViewStudent" CommandArgument='<%# Eval("Id") %>'
                                        CausesValidation="false" />
                                    <asp:LinkButton ID="btnEdit" runat="server" Text="Edit"
                                        CssClass="btn btn-outline-primary"
                                        CommandName="EditStudent" CommandArgument='<%# Eval("Id") %>'
                                        CausesValidation="false" />
                                    <asp:LinkButton ID="btnDelete" runat="server" Text="Delete"
                                        CssClass="btn btn-outline-danger"
                                        CommandName="DeleteStudent" CommandArgument='<%# Eval("Id") %>'
                                        CausesValidation="false"
                                        OnClientClick="return confirm('Are you sure you want to delete this student?');" />
                                </div>
                            </td>
                        </tr>
                    </ItemTemplate>
                </asp:Repeater>

                <tr runat="server" id="trNoRecords" visible="false">
                    <td colspan="6" class="text-center text-muted py-4">No students found.</td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="pagination-row">
        <asp:Label ID="lblPageInfo" runat="server" Text="Page 1" />
        <div class="d-flex gap-2">
            <asp:Button ID="btnPrevious" runat="server" Text="Previous"
                CssClass="btn btn-outline-secondary" OnClick="btnPrevious_Click" />
            <asp:Button ID="btnNext" runat="server" Text="Next"
                CssClass="btn btn-outline-secondary" OnClick="btnNext_Click" />
        </div>
    </div>

</div>
</asp:Content>