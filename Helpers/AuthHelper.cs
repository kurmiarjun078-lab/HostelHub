using System.Web;

namespace HostelHub.Helpers
{
    public static class AuthHelper
    {
        public static bool IsLoggedIn
        {
            get { return HttpContext.Current.Session["UserId"] != null; }
        }

        public static string Role
        {
            get { return HttpContext.Current.Session["Role"] as string; }
        }

        // Kisi protected page ke Page_Load mein use karenge
        public static void RequireRole(string role)
        {
            if (!IsLoggedIn || Role != role)
            {
                HttpContext.Current.Response.Redirect("~/Account/Login.aspx", true);
            }
        }

        public static string DashboardUrl(string role)
        {
            return role == "Admin" ? "~/Admin/Dashboard.aspx" : "~/Student/Dashboard.aspx";
        }
    }
}