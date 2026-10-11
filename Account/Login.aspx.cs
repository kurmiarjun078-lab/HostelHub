using System;
using System.Data.SqlClient;
using HostelHub.Helpers;

namespace HostelHub.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack && Request.QueryString["registered"] == "1")
            {
                lblMessage.CssClass = "msg success";
                lblMessage.Text = "Account created successfully. Please log in.";
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Khali fields ka check validators karte hain
            if (!Page.IsValid) return;

            string id = txtUser.Text.Trim();
            string password = txtPassword.Text;

            try
            {
                using (SqlConnection con = Db.GetConnection())
                {
                    con.Open();
                    using (var cmd = new SqlCommand(
                        @"SELECT UserId, FullName, Role, PasswordHash, PasswordSalt, IsActive
                          FROM Users
                          WHERE Email = @Id OR EnrollmentNo = @Id", con))
                    {
                        cmd.Parameters.AddWithValue("@Id", id);

                        using (SqlDataReader r = cmd.ExecuteReader())
                        {
                            if (r.Read())
                            {
                                bool active = (bool)r["IsActive"];
                                string salt = (string)r["PasswordSalt"];
                                string hash = (string)r["PasswordHash"];

                                if (active && PasswordHelper.Verify(password, salt, hash))
                                {
                                    string role = (string)r["Role"];
                                    Session["UserId"] = (int)r["UserId"];
                                    Session["FullName"] = (string)r["FullName"];
                                    Session["Role"] = role;

                                    Response.Redirect(AuthHelper.DashboardUrl(role), false);
                                    Context.ApplicationInstance.CompleteRequest();
                                    return;
                                }
                            }
                        }
                    }
                }

                // Email galat ho ya password, dono ke liye same message
                ShowError("Invalid email/enrollment number or password.");
            }
            catch (Exception ex)
            {
                // Abhi debugging ke liye, baad mein hata denge
                ShowError("Login failed: " + ex.Message);
            }
        }

        private void ShowError(string message)
        {
            lblMessage.CssClass = "msg error";
            lblMessage.Text = message;
        }
    }
}