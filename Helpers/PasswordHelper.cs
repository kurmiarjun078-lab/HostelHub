using System;
using System.Security.Cryptography;

namespace HostelHub.Helpers
{
    public static class PasswordHelper
    {
        private const int Iterations = 100000;

        public static string GenerateSalt()
        {
            var bytes = new byte[16];
            using (var rng = RandomNumberGenerator.Create())
                rng.GetBytes(bytes);
            return Convert.ToBase64String(bytes);
        }

        public static string Hash(string password, string salt)
        {
            using (var pbkdf2 = new Rfc2898DeriveBytes(
                password, Convert.FromBase64String(salt), Iterations, HashAlgorithmName.SHA256))
            {
                return Convert.ToBase64String(pbkdf2.GetBytes(32));
            }
        }

        public static bool Verify(string password, string salt, string hash)
        {
            return Hash(password, salt) == hash;
        }
    }
}