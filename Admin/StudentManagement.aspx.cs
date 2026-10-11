using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HostelHub.Admin
{
    [Serializable]
    public class StudentRecord
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Enrollment { get; set; }
        public string Department { get; set; }
        public string Room { get; set; }
        public string Status { get; set; }
    }

    public partial class StudentManagement : Page
    {
        private const string SessionKey = "HostelHub_Students";
        private const int PageSize = 5;

        private List<StudentRecord> Students
        {
            get
            {
                if (Session[SessionKey] == null)
                {
                    Session[SessionKey] = new List<StudentRecord>
                    {
                        new StudentRecord { Id = 1, Name = "Rahul Sharma", Enrollment = "HH2024001", Department = "Computer Science", Room = "101", Status = "Active" },
                        new StudentRecord { Id = 2, Name = "Priya Patel", Enrollment = "HH2024002", Department = "Information Technology", Room = "102", Status = "Active" },
                        new StudentRecord { Id = 3, Name = "Amit Kumar", Enrollment = "HH2024003", Department = "Mechanical Engineering", Room = "103", Status = "Inactive" },
                        new StudentRecord { Id = 4, Name = "Neha Singh", Enrollment = "HH2024004", Department = "Computer Science", Room = "104", Status = "Active" },
                        new StudentRecord { Id = 5, Name = "Rohan Verma", Enrollment = "HH2024005", Department = "Civil Engineering", Room = "105", Status = "Inactive" },
                        new StudentRecord { Id = 6, Name = "Pooja Shah", Enrollment = "HH2024006", Department = "Information Technology", Room = "106", Status = "Active" }
                    };
                }

                return (List<StudentRecord>)Session[SessionKey];
            }
            set
            {
                Session[SessionKey] = value;
            }
        }

        private int CurrentPage
        {
            get { return ViewState["CurrentPage"] == null ? 0 : (int)ViewState["CurrentPage"]; }
            set { ViewState["CurrentPage"] = value; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindStudents();
            }
        }

        private void BindStudents()
        {
            IEnumerable<StudentRecord> query = Students;

            string search = (txtSearch.Text ?? "").Trim();
            string status = ddlFilterStatus.SelectedValue;

            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(s =>
                    (s.Name ?? "").IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0 ||
                    (s.Enrollment ?? "").IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            if (!string.IsNullOrWhiteSpace(status))
            {
                query = query.Where(s => s.Status == status);
            }

            List<StudentRecord> filtered = query
                .OrderBy(s => s.Id)
                .ToList();

            lblTotal.Text = Students.Count.ToString();
            lblActive.Text = Students.Count(s => s.Status == "Active").ToString();
            lblInactive.Text = Students.Count(s => s.Status == "Inactive").ToString();

            int totalPages = Math.Max(1, (int)Math.Ceiling(filtered.Count / (double)PageSize));

            if (CurrentPage >= totalPages)
                CurrentPage = totalPages - 1;

            if (CurrentPage < 0)
                CurrentPage = 0;

            List<StudentRecord> pageRecords = filtered
                .Skip(CurrentPage * PageSize)
                .Take(PageSize)
                .ToList();

            rptStudents.DataSource = pageRecords;
            rptStudents.DataBind();

            trNoRecords.Visible = pageRecords.Count == 0;

            lblPageInfo.Text = "Page " + (CurrentPage + 1) + " of " + totalPages;

            btnPrevious.Enabled = CurrentPage > 0;
            btnNext.Enabled = CurrentPage < totalPages - 1;
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            CurrentPage = 0;
            BindStudents();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlFilterStatus.SelectedIndex = 0;
            CurrentPage = 0;
            HideStudentForm();
            lblMessage.Text = "";
            BindStudents();
        }

        protected void btnShowAdd_Click(object sender, EventArgs e)
        {
            ClearForm();
            lblFormTitle.Text = "Add Student";
            btnSaveStudent.Text = "Save Student";
            btnSaveStudent.Visible = true;
            SetFormReadOnly(false);
            pnlStudentForm.Visible = true;
            lblMessage.Text = "";
        }

        protected void btnSaveStudent_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string enrollment = txtEnrollment.Text.Trim();
            string department = txtDepartment.Text.Trim();
            string room = txtRoom.Text.Trim();
            string status = ddlStudentStatus.SelectedValue;

            if (name.Length == 0 || enrollment.Length == 0 ||
                department.Length == 0 || room.Length == 0)
            {
                lblMessage.CssClass = "message text-danger";
                lblMessage.Text = "Please fill in all student fields.";
                pnlStudentForm.Visible = true;
                return;
            }

            int id;
            int.TryParse(hfStudentId.Value, out id);

            bool duplicate = Students.Any(s =>
                string.Equals(s.Enrollment, enrollment, StringComparison.OrdinalIgnoreCase)
                && s.Id != id);

            if (duplicate)
            {
                lblMessage.CssClass = "message text-danger";
                lblMessage.Text = "This enrollment number already exists.";
                pnlStudentForm.Visible = true;
                return;
            }

            if (id == 0)
            {
                int nextId = Students.Count == 0 ? 1 : Students.Max(s => s.Id) + 1;

                Students.Add(new StudentRecord
                {
                    Id = nextId,
                    Name = name,
                    Enrollment = enrollment,
                    Department = department,
                    Room = room,
                    Status = status
                });

                lblMessage.CssClass = "message text-success";
                lblMessage.Text = "Student added successfully.";
            }
            else
            {
                StudentRecord student = Students.FirstOrDefault(s => s.Id == id);

                if (student == null)
                {
                    lblMessage.CssClass = "message text-danger";
                    lblMessage.Text = "Student record was not found.";
                    BindStudents();
                    return;
                }

                student.Name = name;
                student.Enrollment = enrollment;
                student.Department = department;
                student.Room = room;
                student.Status = status;

                lblMessage.CssClass = "message text-success";
                lblMessage.Text = "Student updated successfully.";
            }

            HideStudentForm();
            CurrentPage = 0;
            BindStudents();
        }

        protected void btnCancelForm_Click(object sender, EventArgs e)
        {
            HideStudentForm();
            lblMessage.Text = "";
            BindStudents();
        }

        protected void rptStudents_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            int id;

            if (!int.TryParse(Convert.ToString(e.CommandArgument), out id))
                return;

            StudentRecord student = Students.FirstOrDefault(s => s.Id == id);

            if (student == null)
            {
                lblMessage.CssClass = "message text-danger";
                lblMessage.Text = "Student record was not found.";
                BindStudents();
                return;
            }

            if (e.CommandName == "DeleteStudent")
            {
                Students.Remove(student);

                lblMessage.CssClass = "message text-success";
                lblMessage.Text = "Student deleted successfully.";

                BindStudents();
            }
            else if (e.CommandName == "EditStudent")
            {
                LoadStudentIntoForm(student);
                lblFormTitle.Text = "Edit Student";
                btnSaveStudent.Text = "Update Student";
                btnSaveStudent.Visible = true;
                SetFormReadOnly(false);
                pnlStudentForm.Visible = true;

                lblMessage.Text = "";
            }
            else if (e.CommandName == "ViewStudent")
            {
                LoadStudentIntoForm(student);
                lblFormTitle.Text = "Student Details";
                btnSaveStudent.Visible = false;
                SetFormReadOnly(true);
                pnlStudentForm.Visible = true;

                lblMessage.Text = "";
            }
        }

        private void LoadStudentIntoForm(StudentRecord student)
        {
            hfStudentId.Value = student.Id.ToString();
            txtName.Text = student.Name;
            txtEnrollment.Text = student.Enrollment;
            txtDepartment.Text = student.Department;
            txtRoom.Text = student.Room;

            ddlStudentStatus.SelectedValue =
                student.Status == "Inactive" ? "Inactive" : "Active";
        }

        private void ClearForm()
        {
            hfStudentId.Value = "";
            txtName.Text = "";
            txtEnrollment.Text = "";
            txtDepartment.Text = "";
            txtRoom.Text = "";
            ddlStudentStatus.SelectedValue = "Active";
        }

        private void SetFormReadOnly(bool readOnly)
        {
            txtName.ReadOnly = readOnly;
            txtEnrollment.ReadOnly = readOnly;
            txtDepartment.ReadOnly = readOnly;
            txtRoom.ReadOnly = readOnly;
            ddlStudentStatus.Enabled = !readOnly;
        }

        private void HideStudentForm()
        {
            pnlStudentForm.Visible = false;
            btnSaveStudent.Visible = true;
            SetFormReadOnly(false);
            ClearForm();
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 0)
                CurrentPage--;

            BindStudents();
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            CurrentPage++;
            BindStudents();
        }
    }
}