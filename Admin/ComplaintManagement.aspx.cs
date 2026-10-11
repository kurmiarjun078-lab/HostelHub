using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HostelHub.Admin
{
    [Serializable]
    public class ComplaintRecord
    {
        public int Id { get; set; }
        public string Student { get; set; }
        public string Room { get; set; }
        public string Category { get; set; }
        public DateTime Date { get; set; }
        public string Status { get; set; }
        public string Description { get; set; }
        public string AdminRemark { get; set; }
    }

    public partial class ComplaintManagement : Page
    {
        private const string SessionKey = "HostelHub_Complaints";
        private const int PageSize = 5;

        private List<ComplaintRecord> Complaints
        {
            get
            {
                if (Session[SessionKey] == null)
                {
                    Session[SessionKey] = new List<ComplaintRecord>
                    {
                        new ComplaintRecord
                        {
                            Id = 1, Student = "Rahul", Room = "A-204",
                            Category = "Plumbing",
                            Date = new DateTime(2026, 10, 8),
                            Status = "Pending",
                            Description = "Water leakage in the bathroom.",
                            AdminRemark = ""
                        },
                        new ComplaintRecord
                        {
                            Id = 2, Student = "Amit", Room = "B-112",
                            Category = "Electrical",
                            Date = new DateTime(2026, 10, 7),
                            Status = "In Progress",
                            Description = "The room light is not working.",
                            AdminRemark = "Electrician has been assigned."
                        },
                        new ComplaintRecord
                        {
                            Id = 3, Student = "Sneha Gupta", Room = "C-305",
                            Category = "Internet",
                            Date = new DateTime(2026, 10, 6),
                            Status = "Resolved",
                            Description = "Wi-Fi connection was unavailable.",
                            AdminRemark = "Router restarted; connection restored."
                        },
                        new ComplaintRecord
                        {
                            Id = 4, Student = "Vikram", Room = "A-101",
                            Category = "Carpentry",
                            Date = new DateTime(2026, 10, 5),
                            Status = "Pending",
                            Description = "The cupboard door is damaged.",
                            AdminRemark = ""
                        },
                        new ComplaintRecord
                        {
                            Id = 5, Student = "Priya Patel", Room = "B-205",
                            Category = "Cleaning",
                            Date = new DateTime(2026, 10, 4),
                            Status = "In Progress",
                            Description = "Room cleaning has been missed.",
                            AdminRemark = "Cleaning team notified."
                        },
                        new ComplaintRecord
                        {
                            Id = 6, Student = "Rohan Verma", Room = "C-306",
                            Category = "Other",
                            Date = new DateTime(2026, 10, 3),
                            Status = "Resolved",
                            Description = "Room key replacement requested.",
                            AdminRemark = "Replacement key provided."
                        }
                    };
                }

                return (List<ComplaintRecord>)Session[SessionKey];
            }
            set
            {
                Session[SessionKey] = value;
            }
        }

        private int CurrentPage
        {
            get
            {
                return ViewState["ComplaintPage"] == null
                    ? 0 : (int)ViewState["ComplaintPage"];
            }
            set
            {
                ViewState["ComplaintPage"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindComplaints();
            }
        }

        private void BindComplaints()
        {
            List<ComplaintRecord> all = Complaints;

            lblTotal.Text = all.Count.ToString();
            lblPending.Text = all.Count(c => c.Status == "Pending").ToString();
            lblInProgress.Text = all.Count(c => c.Status == "In Progress").ToString();
            lblResolved.Text = all.Count(c => c.Status == "Resolved").ToString();

            IEnumerable<ComplaintRecord> query = all;

            string search = (txtSearch.Text ?? "").Trim();
            string status = ddlFilterStatus.SelectedValue;

            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(c =>
                    c.Id.ToString().IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    (c.Student ?? "").IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    (c.Room ?? "").IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    (c.Category ?? "").IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            if (!string.IsNullOrWhiteSpace(status))
            {
                query = query.Where(c => c.Status == status);
            }

            if (ddlSort.SelectedValue == "Oldest")
                query = query.OrderBy(c => c.Date).ThenBy(c => c.Id);
            else
                query = query.OrderByDescending(c => c.Date).ThenByDescending(c => c.Id);

            List<ComplaintRecord> filtered = query.ToList();

            int totalPages = Math.Max(
                1, (int)Math.Ceiling(filtered.Count / (double)PageSize));

            if (CurrentPage >= totalPages)
                CurrentPage = totalPages - 1;

            if (CurrentPage < 0)
                CurrentPage = 0;

            List<ComplaintRecord> pageRecords = filtered
                .Skip(CurrentPage * PageSize)
                .Take(PageSize)
                .ToList();

            rptComplaints.DataSource = pageRecords;
            rptComplaints.DataBind();

            trNoRecords.Visible = pageRecords.Count == 0;

            int showingFrom = filtered.Count == 0 ? 0 : CurrentPage * PageSize + 1;
            int showingTo = Math.Min((CurrentPage + 1) * PageSize, filtered.Count);

            lblPageInfo.Text = "Showing " + showingFrom + " to " +
                               showingTo + " of " + filtered.Count + " entries";

            btnPrevious.Enabled = CurrentPage > 0;
            btnNext.Enabled = CurrentPage < totalPages - 1;
        }

        protected string GetStatusCss(string status)
        {
            switch (status)
            {
                case "Pending":
                    return "status-pending";

                case "In Progress":
                    return "status-progress";

                case "Resolved":
                    return "status-resolved";

                default:
                    return "status-pending";
            }
        }

        protected string FirstLetter(string name)
        {
            if (string.IsNullOrWhiteSpace(name))
                return "?";

            return name.Trim().Substring(0, 1).ToUpperInvariant();
        }

        protected void btnShowAdd_Click(object sender, EventArgs e)
        {
            ClearForm();
            lblFormTitle.Text = "Log Complaint";
            btnSaveComplaint.Text = "Save Complaint";
            SetFormReadOnly(false);
            pnlComplaintForm.Visible = true;
            lblMessage.Text = "";
        }

        protected void btnSaveComplaint_Click(object sender, EventArgs e)
        {
            string student = txtStudent.Text.Trim();
            string room = txtRoom.Text.Trim();
            string description = txtDescription.Text.Trim();
            string category = ddlCategory.SelectedValue;
            string status = ddlComplaintStatus.SelectedValue;
            string remark = txtAdminRemark.Text.Trim();

            if (student.Length == 0 || room.Length == 0 || description.Length == 0)
            {
                ShowError("Please enter the student name, room number, and complaint description.");
                return;
            }

            int id;
            int.TryParse(hfComplaintId.Value, out id);

            if (id == 0)
            {
                int nextId = Complaints.Count == 0
                    ? 1 : Complaints.Max(c => c.Id) + 1;

                Complaints.Add(new ComplaintRecord
                {
                    Id = nextId,
                    Student = student,
                    Room = room,
                    Category = category,
                    Date = DateTime.Today,
                    Status = status,
                    Description = description,
                    AdminRemark = remark
                });

                lblMessage.CssClass = "message-label text-success";
                lblMessage.Text = "Complaint logged successfully.";
            }
            else
            {
                ComplaintRecord complaint =
                    Complaints.FirstOrDefault(c => c.Id == id);

                if (complaint == null)
                {
                    ShowError("Complaint record was not found.");
                    BindComplaints();
                    return;
                }

                complaint.Student = student;
                complaint.Room = room;
                complaint.Category = category;
                complaint.Status = status;
                complaint.Description = description;
                complaint.AdminRemark = remark;

                lblMessage.CssClass = "message-label text-success";
                lblMessage.Text = "Complaint updated successfully.";
            }

            HideForm();
            CurrentPage = 0;
            BindComplaints();
        }

        protected void btnCancelForm_Click(object sender, EventArgs e)
        {
            HideForm();
            lblMessage.Text = "";
            BindComplaints();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindComplaints();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlFilterStatus.SelectedIndex = 0;
            ddlSort.SelectedValue = "Newest";
            CurrentPage = 0;

            HideForm();
            lblMessage.Text = "";

            BindComplaints();
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 0)
                CurrentPage--;

            BindComplaints();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            CurrentPage++;
            BindComplaints();
        }

        protected void rptComplaints_ItemCommand(
            object source, RepeaterCommandEventArgs e)
        {
            int id;

            if (!int.TryParse(Convert.ToString(e.CommandArgument), out id))
                return;

            ComplaintRecord complaint =
                Complaints.FirstOrDefault(c => c.Id == id);

            if (complaint == null)
            {
                ShowError("Complaint record was not found.");
                BindComplaints();
                return;
            }

            if (e.CommandName == "DeleteComplaint")
            {
                Complaints.Remove(complaint);

                lblMessage.CssClass = "message-label text-success";
                lblMessage.Text = "Complaint deleted successfully.";

                BindComplaints();
            }
            else if (e.CommandName == "EditComplaint")
            {
                LoadComplaint(complaint);
                lblFormTitle.Text = "Update Complaint";
                btnSaveComplaint.Text = "Update Complaint";
                SetFormReadOnly(false);
                pnlComplaintForm.Visible = true;
                lblMessage.Text = "";
            }
            else if (e.CommandName == "ViewComplaint")
            {
                LoadComplaint(complaint);
                lblFormTitle.Text = "Complaint Details";
                SetFormReadOnly(true);
                pnlComplaintForm.Visible = true;
                lblMessage.Text = "";
            }
        }

        private void LoadComplaint(ComplaintRecord complaint)
        {
            hfComplaintId.Value = complaint.Id.ToString();
            txtStudent.Text = complaint.Student;
            txtRoom.Text = complaint.Room;
            txtDescription.Text = complaint.Description;
            txtAdminRemark.Text = complaint.AdminRemark;

            ddlCategory.SelectedValue = complaint.Category;
            ddlComplaintStatus.SelectedValue = complaint.Status;
        }

        private void ClearForm()
        {
            hfComplaintId.Value = "";
            txtStudent.Text = "";
            txtRoom.Text = "";
            txtDescription.Text = "";
            txtAdminRemark.Text = "";

            ddlCategory.SelectedValue = "Plumbing";
            ddlComplaintStatus.SelectedValue = "Pending";
        }

        private void SetFormReadOnly(bool readOnly)
        {
            txtStudent.ReadOnly = readOnly;
            txtRoom.ReadOnly = readOnly;
            txtDescription.ReadOnly = readOnly;
            txtAdminRemark.ReadOnly = readOnly;

            ddlCategory.Enabled = !readOnly;
            ddlComplaintStatus.Enabled = !readOnly;
            btnSaveComplaint.Visible = !readOnly;
        }

        private void HideForm()
        {
            pnlComplaintForm.Visible = false;
            SetFormReadOnly(false);
            ClearForm();
        }

        private void ShowError(string message)
        {
            lblMessage.CssClass = "message-label text-danger";
            lblMessage.Text = message;
            pnlComplaintForm.Visible = true;
        }

        protected void btnExportCsv_Click(object sender, EventArgs e)
        {
            IEnumerable<ComplaintRecord> query = Complaints;

            string search = (txtSearch.Text ?? "").Trim();
            string status = ddlFilterStatus.SelectedValue;

            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(c =>
                    c.Id.ToString().IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    (c.Student ?? "").IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    (c.Room ?? "").IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    (c.Category ?? "").IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            if (!string.IsNullOrWhiteSpace(status))
                query = query.Where(c => c.Status == status);

            if (ddlSort.SelectedValue == "Oldest")
                query = query.OrderBy(c => c.Date);
            else
                query = query.OrderByDescending(c => c.Date);

            StringBuilder csv = new StringBuilder();

            csv.AppendLine("ID,Student,Room,Category,Date,Status,Description,Admin Remark");

            foreach (ComplaintRecord c in query)
            {
                csv.Append(CsvField(c.Id.ToString())).Append(",");
                csv.Append(CsvField(c.Student)).Append(",");
                csv.Append(CsvField(c.Room)).Append(",");
                csv.Append(CsvField(c.Category)).Append(",");
                csv.Append(CsvField(c.Date.ToString("yyyy-MM-dd"))).Append(",");
                csv.Append(CsvField(c.Status)).Append(",");
                csv.Append(CsvField(c.Description)).Append(",");
                csv.AppendLine(CsvField(c.AdminRemark));
            }

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "text/csv";
            Response.ContentEncoding = Encoding.UTF8;
            Response.AddHeader(
                "Content-Disposition",
                "attachment;filename=Complaints.csv");

            Response.BinaryWrite(Encoding.UTF8.GetPreamble());
            Response.Write(csv.ToString());
            Response.Flush();
            HttpContext.Current.ApplicationInstance.CompleteRequest();
        }

        private string CsvField(string value)
        {
            if (value == null)
                value = "";

            return "\"" + value.Replace("\"", "\"\"") + "\"";
        }
    }
}