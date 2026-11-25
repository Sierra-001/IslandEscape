using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Security.Cryptography;
using System.Web.Security;

namespace IslandEscape.Core.App_Code.Helpers
{
    public static class SecurityHelper
    {
        public static string Sha256Hash(string input)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] bytes = Encoding.UTF8.GetBytes(input);
                byte[] hash = sha256.ComputeHash(bytes);
                return Convert.ToBase64String(hash);
            }
        }

        public static string GenerateRandomPassword(int length = 10)
        {
            const string chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()";
            var random = new RNGCryptoServiceProvider();
            byte[] data = new byte[length];
            random.GetBytes(data);

            char[] result = new char[length];
            for (int i = 0; i < length; i++)
            {
                result[i] = chars[data[i] % chars.Length];
            }
            return new string(result);
        }

        public static bool ValidateCsrfToken(string token, string sessionToken)
        {
            if (string.IsNullOrEmpty(token) || string.IsNullOrEmpty(sessionToken))
                return false;

            return token == sessionToken;
        }

        public static string GenerateCsrfToken()
        {
            string token = SiteUtility.GenerateToken();
            HttpContext.Current.Session["CSRF_Token"] = token;
            return token;
        }

        public static string GetCsrfToken()
        {
            return HttpContext.Current.Session["CSRF_Token"] as string;
        }

        public static bool IsAuthenticated()
        {
            return HttpContext.Current.User.Identity.IsAuthenticated;
        }

        public static bool IsInRole(string role)
        {
            return HttpContext.Current.User.IsInRole(role);
        }

        public static string GetCurrentUsername()
        {
            return HttpContext.Current.User.Identity.Name;
        }

        public static string EncryptString(string input, string key)
        {
            using (Aes aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes(key.PadRight(32).Substring(0, 32));
                aes.IV = new byte[16];

                ICryptoTransform encryptor = aes.CreateEncryptor(aes.Key, aes.IV);
                byte[] inputBytes = Encoding.UTF8.GetBytes(input);
                byte[] encrypted = encryptor.TransformFinalBlock(inputBytes, 0, inputBytes.Length);

                return Convert.ToBase64String(encrypted);
            }
        }

        public static string DecryptString(string input, string key)
        {
            using (Aes aes = Aes.Create())
            {
                aes.Key = Encoding.UTF8.GetBytes(key.PadRight(32).Substring(0, 32));
                aes.IV = new byte[16];

                ICryptoTransform decryptor = aes.CreateDecryptor(aes.Key, aes.IV);
                byte[] inputBytes = Convert.FromBase64String(input);
                byte[] decrypted = decryptor.TransformFinalBlock(inputBytes, 0, inputBytes.Length);

                return Encoding.UTF8.GetString(decrypted);
            }
        }
    }
}