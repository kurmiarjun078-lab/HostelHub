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
    public class MessMenuRecord
    {
        public string Day { get; set; }
        public string Breakfast { get; set; }
        public string Lunch { get; set; }
        public string Dinner { get; set; }
    }

    [Serializable]
    public class MessFeedbackRecord
    {
        public string Room { get; set; }
        public int Rating { get; set; }
        public string Comment { get; set; }
        public DateTime Date { get; set; }
    }

    public partial class MessManagement : Page
    {
        private const string MenuSessionKey = "HostelHub_MessMenu";
        private const string FeedbackSessionKey = "HostelHub_MessFeedback";

        private static readonly string[] Days =
        {
            "Monday", "Tuesday", "Wednesday", "Thursday",
            "Friday", "Saturday", "Sunday"
        };

        private List<MessMenuRecord> Menus
        {
            get
            {
                if (Session[MenuSessionKey] == null)
                {
                    Session[MenuSessionKey] = new List<MessMenuRecord>
                    {
                        new MessMenuRecord
                        {
                            Day = "Monday",
                            Breakfast = "Poha, Jalebi, Milk",
                            Lunch = "Kadhi Pakora, Rice, Roti, Salad",
                            Dinner = "Aloo Gobi, Dal Makhani, Roti, Rice"
                        },
                        new MessMenuRecord
                        {
                            Day = "Tuesday",
                            Breakfast = "Aloo Paratha, Curd, Tea",
                            Lunch = "Rajma, Jeera Rice, Roti, Mixed Veg",
                            Dinner = "Paneer Butter Masala, Roti, Dal, Sweet"
                        },
                        new MessMenuRecord
                        {
                            Day = "Wednesday",
                            Breakfast = "Idli, Sambar, Chutney",
                            Lunch = "Chole Bhature, Onion Salad, Lassi",
                            Dinner = "Mix Veg Curry, Roti, Jeera Rice"
                        },
                        new MessMenuRecord
                        {
                            Day = "Thursday",
                            Breakfast = "Bread Omelette / Veg Sandwich",
                            Lunch = "Lemon Rice, Curd, Papad, Poriyal",
                            Dinner = "Chicken Curry / Soya Chaap, Roti, Rice"
                        },
                        new MessMenuRecord
                        {
                            Day = "Friday",
                            Breakfast = "Upma, Coconut Chutney, Tea",
                            Lunch = "Dal Fry, Rice, Aloo Bhujia, Roti",
                            Dinner = "Egg Curry / Matar Paneer, Roti, Pulao"
                        },
                        new MessMenuRecord
                        {
                            Day = "Saturday",
                            Breakfast = "Puri Sabzi, Halwa",
                            Lunch = "Khichdi, Kadhi, Papad, Pickle",
                            Dinner = "Chinese Combo (Noodles, Manchurian)"
                        },
                        new MessMenuRecord
                        {
                            Day = "Sunday",
                            Breakfast = "Masala Dosa, Sambar",
                            Lunch = "Special Veg Biryani, Raita, Salan",
                            Dinner = "Light Dinner (Soup, Sandwich, Fruit)"
                        }
                    };
                }

                return (List<MessMenuRecord>)Session[MenuSessionKey];
            }
            set
            {
                Session[MenuSessionKey] = value;
            }
        }

        private List<MessFeedbackRecord> Feedback
        {
            get
            {
                if (Session[FeedbackSessionKey] == null)
                {
                    Session[FeedbackSessionKey] = new List<MessFeedbackRecord>
                    {
                        new MessFeedbackRecord
                        {
                            Room = "112",
                            Rating = 5,
                            Comment = "Breakfast parathas were excellent! Best meal of the week.",
                            Date = DateTime.Today.AddDays(-1)
                        },
                        new MessFeedbackRecord
                        {
                            Room = "305",
                            Rating = 2,
                            Comment = "Not enough seating during lunch rush. Food was okay.",
                            Date = DateTime.Today.AddDays(-2)
                        },
                        new MessFeedbackRecord
                        {
                            Room = "204",
                            Rating = 4,
                            Comment = "Lunch was tasty and served on time.",
                            Date = DateTime.Today.AddDays(-3)
                        }
                    };
                }

                return (List<MessFeedbackRecord>)Session[FeedbackSessionKey];
            }
            set
            {
                Session[FeedbackSessionKey] = value;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindAll();
            }
        }

        private void BindAll()
        {
            BindMenu();
            BindTodayMenu();
            BindFeedback();
        }

        private void BindMenu()
        {
            IEnumerable<MessMenuRecord> query = Menus;
            string search = (txtSearch.Text ?? "").Trim();

            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(m =>
                    ContainsText(m.Day, search) ||
                    ContainsText(m.Breakfast, search) ||
                    ContainsText(m.Lunch, search) ||
                    ContainsText(m.Dinner, search));
            }

            List<MessMenuRecord> results = query
                .OrderBy(m => Array.IndexOf(Days, m.Day))
                .ToList();

            rptMenu.DataSource = results;
            rptMenu.DataBind();

            trNoMenu.Visible = results.Count == 0;
        }

        private void BindTodayMenu()
        {
            string today = DateTime.Today.DayOfWeek.ToString();

            lblToday.Text = today;

            MessMenuRecord menu = Menus.FirstOrDefault(
                m => string.Equals(m.Day, today, StringComparison.OrdinalIgnoreCase));

            if (menu == null)
            {
                lblTodayBreakfast.Text = "No breakfast menu has been added.";
                lblTodayLunch.Text = "No lunch menu has been added.";
                lblTodayDinner.Text = "No dinner menu has been added.";
            }
            else
            {
                lblTodayBreakfast.Text = menu.Breakfast;
                lblTodayLunch.Text = menu.Lunch;
                lblTodayDinner.Text = menu.Dinner;
            }
        }

        private void BindFeedback()
        {
            List<MessFeedbackRecord> feedback = Feedback
                .OrderByDescending(f => f.Date)
                .ToList();

            rptFeedback.DataSource = feedback;
            rptFeedback.DataBind();

            lblNoFeedback.Visible = feedback.Count == 0;

            double average = feedback.Count == 0
                ? 0
                : feedback.Average(f => f.Rating);

            lblAverageRating.Text = average.ToString("0.0");
        }

        protected string GetStars(int rating)
        {
            rating = Math.Max(0, Math.Min(5, rating));

            return new string('★', rating) +
                   new string('☆', 5 - rating);
        }

        private bool ContainsText(string source, string search)
        {
            return !string.IsNullOrEmpty(source) &&
                source.IndexOf(search, StringComparison.OrdinalIgnoreCase) >= 0;
        }

        protected void btnAddMenu_Click(object sender, EventArgs e)
        {
            string availableDay = Days.FirstOrDefault(
                d => !Menus.Any(m => m.Day == d));

            if (availableDay == null)
            {
                ShowMessage("All seven days already have menu records. Edit an existing day instead.",
                    false);
                return;
            }

            ClearForm();
            ddlDay.SelectedValue = availableDay;
            ddlDay.Enabled = true;

            lblFormTitle.Text = "Add Menu";
            btnSaveMenu.Text = "Add Menu";
            pnlMenuForm.Visible = true;

            lblMessage.Text = "";
        }

        protected void btnSaveMenu_Click(object sender, EventArgs e)
        {
            string day = ddlDay.SelectedValue;
            string breakfast = txtBreakfast.Text.Trim();
            string lunch = txtLunch.Text.Trim();
            string dinner = txtDinner.Text.Trim();
            string originalDay = hfOriginalDay.Value;

            if (!Days.Contains(day))
            {
                ShowMessage("Please select a valid day.", false);
                return;
            }

            if (breakfast.Length == 0 ||
                lunch.Length == 0 ||
                dinner.Length == 0)
            {
                ShowMessage("Please enter breakfast, lunch, and dinner menus.", false);
                pnlMenuForm.Visible = true;
                return;
            }

            if (string.IsNullOrEmpty(originalDay))
            {
                bool exists = Menus.Any(m =>
                    string.Equals(m.Day, day, StringComparison.OrdinalIgnoreCase));

                if (exists)
                {
                    ShowMessage("A menu already exists for " + day + ". Please edit that menu.",
                        false);
                    pnlMenuForm.Visible = true;
                    return;
                }

                Menus.Add(new MessMenuRecord
                {
                    Day = day,
                    Breakfast = breakfast,
                    Lunch = lunch,
                    Dinner = dinner
                });

                ShowMessage("Menu for " + day + " added successfully.", true);
            }
            else
            {
                MessMenuRecord menu = Menus.FirstOrDefault(
                    m => m.Day == originalDay);

                if (menu == null)
                {
                    ShowMessage("The selected menu was not found.", false);
                    BindAll();
                    return;
                }

                if (day != originalDay &&
                    Menus.Any(m => m.Day == day))
                {
                    ShowMessage("A menu already exists for " + day + ".", false);
                    pnlMenuForm.Visible = true;
                    return;
                }

                menu.Day = day;
                menu.Breakfast = breakfast;
                menu.Lunch = lunch;
                menu.Dinner = dinner;

                ShowMessage("Menu for " + day + " updated successfully.", true);
            }

            HideForm();
            BindAll();
        }

        protected void btnCancelMenu_Click(object sender, EventArgs e)
        {
            HideForm();
            lblMessage.Text = "";
            BindAll();
        }

        protected void rptMenu_ItemCommand(
            object source, RepeaterCommandEventArgs e)
        {
            string day = Convert.ToString(e.CommandArgument);

            MessMenuRecord menu = Menus.FirstOrDefault(m => m.Day == day);

            if (menu == null)
            {
                ShowMessage("The selected menu was not found.", false);
                BindAll();
                return;
            }

            if (e.CommandName == "EditMenu")
            {
                hfOriginalDay.Value = menu.Day;
                ddlDay.SelectedValue = menu.Day;
                txtBreakfast.Text = menu.Breakfast;
                txtLunch.Text = menu.Lunch;
                txtDinner.Text = menu.Dinner;

                ddlDay.Enabled = true;
                lblFormTitle.Text = "Edit " + menu.Day + " Menu";
                btnSaveMenu.Text = "Update Menu";
                pnlMenuForm.Visible = true;

                lblMessage.Text = "";
            }
            else if (e.CommandName == "DeleteMenu")
            {
                Menus.Remove(menu);

                ShowMessage("Menu for " + day + " deleted successfully.", true);
                BindAll();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindMenu();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            lblMessage.Text = "";
            BindAll();
        }

        protected void btnExportCsv_Click(object sender, EventArgs e)
        {
            IEnumerable<MessMenuRecord> query = Menus;
            string search = (txtSearch.Text ?? "").Trim();

            if (!string.IsNullOrWhiteSpace(search))
            {
                query = query.Where(m =>
                    ContainsText(m.Day, search) ||
                    ContainsText(m.Breakfast, search) ||
                    ContainsText(m.Lunch, search) ||
                    ContainsText(m.Dinner, search));
            }

            List<MessMenuRecord> records = query
                .OrderBy(m => Array.IndexOf(Days, m.Day))
                .ToList();

            StringBuilder csv = new StringBuilder();
            csv.AppendLine("Day,Breakfast,Lunch,Dinner");

            foreach (MessMenuRecord menu in records)
            {
                csv.Append(CsvField(menu.Day)).Append(",");
                csv.Append(CsvField(menu.Breakfast)).Append(",");
                csv.Append(CsvField(menu.Lunch)).Append(",");
                csv.AppendLine(CsvField(menu.Dinner));
            }

            Response.Clear();
            Response.Buffer = true;
            Response.ContentType = "text/csv";
            Response.ContentEncoding = Encoding.UTF8;
            Response.AddHeader(
                "Content-Disposition",
                "attachment;filename=WeeklyMessMenu.csv");

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

        private void ClearForm()
        {
            hfOriginalDay.Value = "";
            txtBreakfast.Text = "";
            txtLunch.Text = "";
            txtDinner.Text = "";

            ddlDay.Enabled = true;
        }

        private void HideForm()
        {
            pnlMenuForm.Visible = false;
            ClearForm();
        }

        private void ShowMessage(string message, bool success)
        {
            lblMessage.CssClass = success
                ? "mess-message text-success"
                : "mess-message text-danger";

            lblMessage.Text = message;
        }
    }
}