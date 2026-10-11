using System;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using HostelHub.Helpers;

namespace HostelHub.Account
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e) { }

        // CustomValidator ka server-side check (client-side bypass ho jaye tab bhi)
        protected void cvPassword_ServerValidate(object source, ServerValidateEventArgs args)
        {
            string v = args.Value ?? "";
            args.IsValid = v.Length >= 8
                           && Regex.IsMatch(v, "[A-Za-z]")
                           && Regex.IsMatch(v, "[0-9]");
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            string fullName = txtFullName.Text.Trim();
            string enrollment = txtEnrollment.Text.Trim();
            string email = txtEmail.Text.Trim().ToLower();
            string phone = txtPhone.Text.Trim();
            string password = txtPassword.Text;

            try
            {
                using (SqlConnection con = Db.GetConnection())
                {
                    con.Open();
                    using (SqlTransaction tx = con.BeginTransaction())
                    {
                        using (var chk = new SqlCommand(
                            "SELECT COUNT(*) FROM Users WHERE Email=@Email OR EnrollmentNo=@Enr", con, tx))
                        {
                            chk.Parameters.AddWithValue("@Email", email);
                            chk.Parameters.AddWithValue("@Enr", enrollment);
                            if ((int)chk.ExecuteScalar() > 0)
                            {
                                cvDuplicate.IsValid = false;   // summary mein error dikhega
                                return;
                            }
                        }

                        string salt = PasswordHelper.GenerateSalt();
                        string hash = PasswordHelper.Hash(password, salt);

                        int userId;
                        using (var cmd = new SqlCommand(
                            @"INSERT INTO Users (FullName, Email, EnrollmentNo, Phone, PasswordHash, PasswordSalt, Role)
                              VALUES (@Name, @Email, @Enr, @Phone, @Hash, @Salt, 'Student');
                              SELECT CAST(SCOPE_IDENTITY() AS INT);", con, tx))
                        {
                            cmd.Parameters.AddWithValue("@Name", fullName);
                            cmd.Parameters.AddWithValue("@Email", email);
                            cmd.Parameters.AddWithValue("@Enr", enrollment);
                            cmd.Parameters.AddWithValue("@Phone", phone);
                            cmd.Parameters.AddWithValue("@Hash", hash);
                            cmd.Parameters.AddWithValue("@Salt", salt);
                            userId = (int)cmd.ExecuteScalar();
                        }

                        using (var cmd = new SqlCommand(
                            @"INSERT INTO Students (UserId, Course, Department, Block, RoomNumber)
                              VALUES (@UserId, @Course, @Dept, @Block, @Room);", con, tx))
                        {
                            cmd.Parameters.AddWithValue("@UserId", userId);
                            cmd.Parameters.AddWithValue("@Course", ddlCourse.SelectedValue);
                            cmd.Parameters.AddWithValue("@Dept", ddlDepartment.SelectedValue);
                            cmd.Parameters.AddWithValue("@Block", ddlBlock.SelectedValue);
                            cmd.Parameters.AddWithValue("@Room", txtRoom.Text.Trim());
                            cmd.ExecuteNonQuery();
                        }

                        tx.Commit();
                    }
                }

                Response.Redirect("~/Account/Login.aspx?registered=1", false);
                Context.ApplicationInstance.CompleteRequest();
            }
            catch (Exception ex)
            {
                // Abhi debugging ke liye, baad mein hata denge
                lblMessage.CssClass = "msg error";
                lblMessage.Text = "Registration failed: " + ex.Message;
            }
        }
    }
}