using System.Configuration;
using System.Data.SqlClient;

namespace HostelHub.Helpers
{
    public static class Db
    {
        public static SqlConnection GetConnection()
        {
            string cs = ConfigurationManager.ConnectionStrings["HostelHubDb"].ConnectionString;
            return new SqlConnection(cs);
        }
    }
}