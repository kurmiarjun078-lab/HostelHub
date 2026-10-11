using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Globalization;

namespace HostelHub.Admin
{
    [Serializable]
    public class NoticeRecord
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Category { get; set; }
        public DateTime PublishDate { get; set; }
        public string Audience { get; set; }
        public string Status { get; set; }
        public string Description { get; set; }
    }

    public partial class NoticesManagement : Page
    {
        private const string SessionKey = "HostelHub_Notices";
        private const int PageSize = 5;

        private List<NoticeRecord> Notices
        {
            get
            {
                if (Session[SessionKey] == null)
                {
                    Session[SessionKey] = new List<NoticeRecord>
                    {
                        new NoticeRecord
                        {
                            Id = 1,
                            Title = "Mess Timing Change",
                            Category = "Mess",
                            PublishDate = DateTime.Today,
                            Audience = "All Students",
                            Status = "Published",
                            Description = "Updated timings for breakfast, lunch and dinner."
                        },
                        new NoticeRecord
                        {
                            Id = 2,
                            Title = "Annual Maintenance Schedule - Block A",
                            Category = "Maintenance",
                            PublishDate = DateTime.Today.AddDays(2),
                            Audience = "Block A",
                            Status = "Scheduled",
                            Description = "Water supply may be interrupted during maintenance."
                        },
                        new NoticeRecord
                        {
                            Id = 3,
                            Title = "Welcome Incoming Freshmen",
                            Category = "General",
                            PublishDate = DateTime.Today.AddDays(-10),
                            Audience = "All Students, Staff",
                            Status = "Expired",
                            Description = "Guidelines and rules for the academic year."
                        },
                        new NoticeRecord
                        {
                            Id = 4,
                            Title = "Sports Day Registration",
                            Category = "Events",
                            PublishDate = DateTime.Today,
                            Audience = "All Students",
                            Status = "Published",
                            Description = "Register for the upcoming hostel sports event."
                        },
                        new NoticeRecord
                        {
                            Id = 5,
                            Title = "Water Tank Cleaning",
                            Category = "Maintenance",
                            PublishDate = DateTime.Today.AddDays(3),
                            Audience = "Block B",
                            Status = "Scheduled",
                            Description = "Water tank cleaning will take place in Block B."
                        },
                        new NoticeRecord
                        {
                            Id = 6,
                            Title = "Hostel Rules Reminder",
                            Category = "General",
                            PublishDate = DateTime.Today.AddDays(-2),
                            Audience = "All Students",
                            Status = "Published",
                            Description = "Please follow hostel entry timings and rules."
                        }
                    };
                }

                return (List<NoticeRecord>)Session[SessionKey];
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
                return ViewState["NoticePage"] == null
                    ? 0 : (int)ViewState["NoticePage"];
            }
            set
            {
                ViewState["NoticePage"] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindNotices();
            }
        }

        private void BindNotices()
        {
            List<NoticeRecord> all = Notices;

            lblTotalNotices.Text = all.Count.ToString();
            lblPublished.Text = all.Count(n => n.Status == "Published").ToString();
            lblScheduled.Text = all.Count(n => n.Status == "Scheduled").ToString();

            IEnumerable<NoticeRecord> query = all;

            string search = (txtSearch.Text ?? "").Trim();
            string category = ddlFilterCategory.SelectedValue;
            string status = ddlFilterStatus.SelectedValue;

            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(n =>
                    ContainsText(n.Title, search) ||
                    ContainsText(n.Description, search) ||
                    ContainsText(n.Category, search) ||
                    ContainsText(n.Audience, search) ||
                    ContainsText(n.Status, search));
            }

            if (!string.IsNullOrWhiteSpace(category))
                query = query.Where(n => n.Category == category);

            if (!string.IsNullOrWhiteSpace(status))
                query = query.Where(n => n.Status == status);

            List<NoticeRecord> filtered = query
                .OrderByDescending(n => n.PublishDate)
                .ThenByDescending(n => n.Id)
                .ToList();

            int totalPages = Math.Max(
                1, (int)Math.Ceiling(filtered.Count / (double)PageSize));

            if (CurrentPage >= totalPages)
                CurrentPage = totalPages - 1;

            if (CurrentPage < 0)
                CurrentPage = 0;

            List<NoticeRecord> pageNotices = filtered
                .Skip(CurrentPage * PageSize)
                .Take(PageSize)
                .ToList();

            rptNotices.DataSource = pageNotices;
            rptNotices.DataBind();

            trNoNotices.Visible = pageNotices.Count == 0;

            int from = filtered.Count == 0 ? 0 : CurrentPage * PageSize + 1;
            int to = Math.Min((CurrentPage + 1) * PageSize, filtered.Count);

            lblPageInfo.Text = "Showing " + from + " to " + to +
                               " of " + filtered.Count + " notices";

            lblPageNumber.Text = (CurrentPage + 1) + " / " + totalPages;

            btnPrevious.Enabled = CurrentPage > 0;
            btnNext.Enabled = CurrentPage < totalPages - 1;
        }

        private bool ContainsText(string source, string search)
        {
            return !string.IsNullOrEmpty(source) &&
                source.IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0;
        }

        protected string GetCategoryCss(string category)
        {
            switch (category)
            {
                case "General": return "cat-general";
                case "Mess": return "cat-mess";
                case "Maintenance": return "cat-maintenance";
                case "Events": return "cat-events";
                default: return "cat-other";
            }
        }

        protected string GetStatusCss(string status)
        {
            switch (status)
            {
                case "Published": return "status-published";
                case "Scheduled": return "status-scheduled";
                default: return "status-expired";
            }
        }

        protected void btnCreateNotice_Click(object sender, EventArgs e)
        {
            ClearForm();
            lblFormTitle.Text = "Create New Notice";
            btnSaveNotice.Text = "Create Notice";
            pnlNoticeForm.Visible = true;
            lblMessage.Text = "";
        }

        protected void btnSaveNotice_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            string category = ddlCategory.SelectedValue;
            string audience = ddlAudience.SelectedValue;
            string status = ddlStatus.SelectedValue;
            string dateText = txtPublishDate.Text.Trim();

            if (title.Length == 0 || description.Length == 0 ||
                dateText.Length == 0)
            {
                ShowMessage(
                    "Please enter the title, description, and publish date.",
                    false);
                pnlNoticeForm.Visible = true;
                return;
            }

            DateTime publishDate;

            if (!DateTime.TryParseExact(
                dateText,
                "yyyy-MM-dd",
                CultureInfo.InvariantCulture,
                DateTimeStyles.None,
                out publishDate))
            {
                ShowMessage("Please select a valid publish date.", false);
                pnlNoticeForm.Visible = true;
                return;
            }

            if (!new[] { "General", "Mess", "Maintenance", "Events", "Other" }
                .Contains(category) ||
                !new[] { "Published", "Scheduled", "Expired" }.Contains(status))
            {
                ShowMessage("Please select a valid category and status.", false);
                pnlNoticeForm.Visible = true;
                return;
            }

            int id;
            int.TryParse(hfNoticeId.Value, out id);

            if (id == 0)
            {
                int nextId = Notices.Count == 0
                    ? 1 : Notices.Max(n => n.Id) + 1;

                Notices.Add(new NoticeRecord
                {
                    Id = nextId,
                    Title = title,
                    Category = category,
                    PublishDate = publishDate,
                    Audience = audience,
                    Status = status,
                    Description = description
                });

                ShowMessage("Notice created successfully.", true);
            }
            else
            {
                NoticeRecord notice = Notices.FirstOrDefault(n => n.Id == id);

                if (notice == null)
                {
                    ShowMessage("Notice not found.", false);
                    BindNotices();
                    return;
                }

                notice.Title = title;
                notice.Category = category;
                notice.PublishDate = publishDate;
                notice.Audience = audience;
                notice.Status = status;
                notice.Description = description;

                ShowMessage("Notice updated successfully.", true);
            }

            HideForm();
            CurrentPage = 0;
            BindNotices();
        }

        protected void rptNotices_ItemCommand(
            object source, RepeaterCommandEventArgs e)
        {
            int id;

            if (!int.TryParse(Convert.ToString(e.CommandArgument), out id))
                return;

            NoticeRecord notice = Notices.FirstOrDefault(n => n.Id == id);

            if (notice == null)
            {
                ShowMessage("Notice not found.", false);
                BindNotices();
                return;
            }

            if (e.CommandName == "DeleteNotice")
            {
                Notices.Remove(notice);
                ShowMessage("Notice deleted successfully.", true);
                BindNotices();
            }
            else if (e.CommandName == "EditNotice")
            {
                LoadForm(notice);
                lblFormTitle.Text = "Edit Notice";
                btnSaveNotice.Text = "Update Notice";
                pnlNoticeForm.Visible = true;
                lblMessage.Text = "";
            }
            else if (e.CommandName == "ViewNotice")
            {
                LoadForm(notice);
                lblFormTitle.Text = "Notice Details";
                btnSaveNotice.Text = "Update Notice";
                pnlNoticeForm.Visible = true;

                // View mode: hide the save button and disable the fields.
                txtTitle.ReadOnly = true;
                txtDescription.ReadOnly = true;
                txtPublishDate.ReadOnly = true;
                ddlCategory.Enabled = false;
                ddlAudience.Enabled = false;
                ddlStatus.Enabled = false;
                btnSaveNotice.Visible = false;

                lblMessage.Text = "";
            }
        }

        private void LoadForm(NoticeRecord notice)
        {
            hfNoticeId.Value = notice.Id.ToString();
            txtTitle.Text = notice.Title;
            txtDescription.Text = notice.Description;
            txtPublishDate.Text = notice.PublishDate.ToString("yyyy-MM-dd");

            ddlCategory.SelectedValue = notice.Category;
            ddlAudience.SelectedValue = notice.Audience;
            ddlStatus.SelectedValue = notice.Status;

            SetEditMode();
        }

        private void SetEditMode()
        {
            txtTitle.ReadOnly = false;
            txtDescription.ReadOnly = false;
            txtPublishDate.ReadOnly = false;
            ddlCategory.Enabled = true;
            ddlAudience.Enabled = true;
            ddlStatus.Enabled = true;
            btnSaveNotice.Visible = true;
        }

        private void ClearForm()
        {
            hfNoticeId.Value = "";
            txtTitle.Text = "";
            txtDescription.Text = "";
            txtPublishDate.Text = DateTime.Today.ToString("yyyy-MM-dd");

            ddlCategory.SelectedValue = "General";
            ddlAudience.SelectedValue = "All Students";
            ddlStatus.SelectedValue = "Published";

            SetEditMode();
        }

        private void HideForm()
        {
            pnlNoticeForm.Visible = false;
            ClearForm();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            HideForm();
            lblMessage.Text = "";
            BindNotices();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindNotices();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindNotices();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlFilterCategory.SelectedIndex = 0;
            ddlFilterStatus.SelectedIndex = 0;
            CurrentPage = 0;
            lblMessage.Text = "";
            BindNotices();
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 0)
                CurrentPage--;

            BindNotices();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            CurrentPage++;
            BindNotices();
        }

        protected void btnExportCsv_Click(object sender, EventArgs e)
        {
            IEnumerable<NoticeRecord> query = Notices;

            string search = (txtSearch.Text ?? "").Trim();
            string category = ddlFilterCategory.SelectedValue;
            string status = ddlFilterStatus.SelectedValue;

            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(n =>
                    ContainsText(n.Title, search) ||
                    ContainsText(n.Description, search) ||
                    ContainsText(n.Category, search) ||
                    ContainsText(n.Audience, search) ||
                    ContainsText(n.Status, search));
            }

            if (!string.IsNullOrWhiteSpace(category))
                query = query.Where(n => n.Category == category);

            if (!string.IsNullOrWhiteSpace(status))
                query = query.Where(n => n.Status == status);

            StringBuilder csv = new StringBuilder();
            csv.AppendLine("ID,Title,Category,Publish Date,Target Audience,Status,Description");

            foreach (NoticeRecord n in query.OrderByDescending(n => n.PublishDate))
            {
                csv.Append(CsvField(n.Id.ToString())).Append(",");
                csv.Append(CsvField(n.Title)).Append(",");
                csv.Append(CsvField(n.Category)).Append(",");
                csv.Append(CsvField(n.PublishDate.ToString("yyyy-MM-dd"))).Append(",");
                csv.Append(CsvField(n.Audience)).Append(",");
                csv.Append(CsvField(n.Status)).Append(",");
                csv.AppendLine(CsvField(n.Description));
            }

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "text/csv";
            Response.ContentEncoding = Encoding.UTF8;
            Response.AddHeader(
                "Content-Disposition",
                "attachment;filename=HostelNotices.csv");

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

        private void ShowMessage(string message, bool success)
        {
            lblMessage.CssClass = success
                ? "notice-message text-success"
                : "notice-message text-danger";

            lblMessage.Text = message;
        }
    }
}