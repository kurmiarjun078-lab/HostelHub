using System;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using HostelHub.Helpers;

namespace HostelHub.Public
{
    public partial class Contact : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        protected void btnSend_Click(object sender, EventArgs e)
        {
            string name = txtName.Text.Trim();
            string email = txtEmail.Text.Trim();
            string subject = txtSubject.Text.Trim();
            string message = txtMessage.Text.Trim();

            if (name == "" || email == "" || subject == "" || message == "")
            {
                Show("Please fill all fields.", true);
                return;
            }
            if (!Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                Show("Please enter a valid email address.", true);
                return;
            }
            if (message.Length > 2000)
            {
                Show("Message is too long (maximum 2000 characters).", true);
                return;
            }

            try
            {
                using (SqlConnection con = Db.GetConnection())
                using (var cmd = new SqlCommand(
                    @"INSERT INTO ContactMessages (FullName, Email, Subject, Message)
                      VALUES (@Name, @Email, @Subject, @Message)", con))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@Subject", subject);
                    cmd.Parameters.AddWithValue("@Message", message);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }

                txtName.Text = txtEmail.Text = txtSubject.Text = txtMessage.Text = "";
                Show("Thank you! Your message has been sent.", false);
            }
            catch (Exception ex)
            {
                // Abhi debugging ke liye, baad mein hata denge
                Show("Could not send message: " + ex.Message, true);
            }
        }

        private void Show(string text, bool isError)
        {
            lblMessage.CssClass = isError ? "msg error" : "msg success";
            lblMessage.Text = text;
        }
    }
}