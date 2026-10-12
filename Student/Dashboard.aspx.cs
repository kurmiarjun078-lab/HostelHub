
using System;

namespace HostelHub.Student
{
    public partial class Dashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Page.Title = "Dashboard";
            }
        }
    }
}
