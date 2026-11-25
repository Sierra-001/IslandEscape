using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.IO;

namespace IslandEscape.Core.App_Code.Helpers
{
    public static class SiteUtility
    {
        #region Security
        public static string HashPassword(string password, string salt)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                string combined = password + salt;
                byte[] bytes = Encoding.UTF8.GetBytes(combined);
                byte[] hash = sha256.ComputeHash(bytes);
                return Convert.ToBase64String(hash);
            }
        }

        public static string GenerateSalt()
        {
            byte[] saltBytes = new byte[16];
            using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(saltBytes);
            }
            return Convert.ToBase64String(saltBytes);
        }

        public static string GenerateToken()
        {
            byte[] tokenBytes = new byte[32];
            using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
            {
                rng.GetBytes(tokenBytes);
            }
            return Convert.ToBase64String(tokenBytes).Replace("/", "_").Replace("+", "-");
        }
        #endregion

        #region Validation
        public static bool IsValidEmail(string email)
        {
            if (string.IsNullOrEmpty(email)) return false;

            string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
            return Regex.IsMatch(email, pattern);
        }

        public static bool IsValidPhone(string phone)
        {
            if (string.IsNullOrEmpty(phone)) return true; // Optional field

            string pattern = @"^[\d\s\-+()]{8,20}$";
            return Regex.IsMatch(phone, pattern);
        }

        public static bool IsStrongPassword(string password)
        {
            if (string.IsNullOrEmpty(password) || password.Length < 6) return false;

            bool hasUpper = false;
            bool hasLower = false;
            bool hasDigit = false;

            foreach (char c in password)
            {
                if (char.IsUpper(c)) hasUpper = true;
                if (char.IsLower(c)) hasLower = true;
                if (char.IsDigit(c)) hasDigit = true;
            }

            return hasUpper && hasLower && hasDigit;
        }
        #endregion

        #region Formatting
        public static string FormatCurrency(decimal amount)
        {
            return "MUR " + amount.ToString("N2");
        }

        public static string TruncateText(string text, int maxLength)
        {
            if (string.IsNullOrEmpty(text)) return text;
            if (text.Length <= maxLength) return text;

            return text.Substring(0, maxLength) + "...";
        }

        public static string ToSlug(string text)
        {
            if (string.IsNullOrEmpty(text)) return "";

            text = text.ToLowerInvariant();
            text = Regex.Replace(text, @"[^a-z0-9\s-]", "");
            text = Regex.Replace(text, @"\s+", "-");
            return text;
        }

        public static string HtmlEncode(string text)
        {
            return HttpUtility.HtmlEncode(text ?? "");
        }

        public static string HtmlDecode(string text)
        {
            return HttpUtility.HtmlDecode(text ?? "");
        }

        public static string FormatDate(DateTime date)
        {
            return date.ToString("dd MMMM yyyy");
        }

        public static string FormatDateTime(DateTime date)
        {
            return date.ToString("dd MMMM yyyy HH:mm");
        }

        public static string GetFriendlyDateDifference(DateTime date)
        {
            TimeSpan diff = DateTime.Now - date;

            if (diff.TotalMinutes < 1) return "Just now";
            if (diff.TotalMinutes < 60) return $"{(int)diff.TotalMinutes} minute{(diff.TotalMinutes > 1 ? "s" : "")} ago";
            if (diff.TotalHours < 24) return $"{(int)diff.TotalHours} hour{(diff.TotalHours > 1 ? "s" : "")} ago";
            if (diff.TotalDays < 7) return $"{(int)diff.TotalDays} day{(diff.TotalDays > 1 ? "s" : "")} ago";
            if (diff.TotalDays < 30) return $"{(int)(diff.TotalDays / 7)} week{(diff.TotalDays / 7 > 1 ? "s" : "")} ago";
            if (diff.TotalDays < 365) return $"{(int)(diff.TotalDays / 30)} month{(diff.TotalDays / 30 > 1 ? "s" : "")} ago";

            return $"{(int)(diff.TotalDays / 365)} year{(diff.TotalDays / 365 > 1 ? "s" : "")} ago";
        }
        #endregion

        #region Random Generators
        private static Random _random = new Random();

        public static string GenerateBookingNumber()
        {
            string prefix = "IE";
            string year = DateTime.Now.ToString("yy");
            string month = DateTime.Now.ToString("MM");
            string random = _random.Next(10000, 99999).ToString();

            return $"{prefix}{year}{month}{random}";
        }

        public static string GenerateTransactionId()
        {
            string prefix = "TXN";
            string date = DateTime.Now.ToString("yyyyMMdd");
            string random = _random.Next(100000, 999999).ToString();

            return $"{prefix}{date}{random}";
        }
        #endregion

        #region File Handling
        public static string GetSafeFilename(string filename)
        {
            if (string.IsNullOrEmpty(filename)) return "";

            string extension = Path.GetExtension(filename);
            if (!string.IsNullOrEmpty(extension))
            {
                extension = extension.ToLower();
            }

            string name = Guid.NewGuid().ToString("N");

            return name + extension;
        }

        public static bool IsAllowedImageExtension(string filename)
        {
            string[] allowedExtensions = { ".jpg", ".jpeg", ".png", ".gif", ".bmp", ".webp" };
            string ext = Path.GetExtension(filename).ToLower();
            return Array.IndexOf(allowedExtensions, ext) >= 0;
        }
        #endregion
    }
}

#region Old SiteUtilityHelper
//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Security.Cryptography;
//using System.Text;
//using System.Text.RegularExpressions;
//using System.Web;

//namespace IslandEscape.Core.App_Code.Helpers
//{
//    public class SiteUtility
//    {
//        public static string HashPassword(string password, string salt)
//        {
//            using (SHA256 sha256 = SHA256.Create())
//            {
//                string combined = password + salt;
//                byte[] bytes = Encoding.UTF8.GetBytes(combined);
//                byte[] hash = sha256.ComputeHash(bytes);
//                return Convert.ToBase64String(hash);
//            }
//        }

//        public static string GenerateSalt()
//        {
//            byte[] saltBytes = new byte[16];
//            using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
//            {
//                rng.GetBytes(saltBytes);
//            }
//            return Convert.ToBase64String(saltBytes);
//        }

//        public static string GenerateToken()
//        {
//            byte[] tokenBytes = new byte[32];
//            using (RNGCryptoServiceProvider rng = new RNGCryptoServiceProvider())
//            {
//                rng.GetBytes(tokenBytes);
//            }
//            return Convert.ToBase64String(tokenBytes).Replace("/", "_").Replace("+", "-");
//        }

//        public static bool IsValidEmail(string email)
//        {
//            if (string.IsNullOrEmpty(email)) return false;
//            string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
//            return Regex.IsMatch(email, pattern);
//        }

//        public static bool IsStrongPassword(string password)
//        {
//            if (string.IsNullOrEmpty(password) || password.Length < 6) return false;
//            bool hasUpper = false, hasLower = false, hasDigit = false;
//            foreach (char c in password)
//            {
//                if (char.IsUpper(c)) hasUpper = true;
//                if (char.IsLower(c)) hasLower = true;
//                if (char.IsDigit(c)) hasDigit = true;
//            }
//            return hasUpper && hasLower && hasDigit;
//        }

//        public static string FormatCurrency(decimal amount)
//        {
//            return "MUR " + amount.ToString("N2");
//        }

//        public static string TruncateText(string text, int maxLength)
//        {
//            if (string.IsNullOrEmpty(text)) return text;
//            if (text.Length <= maxLength) return text;
//            return text.Substring(0, maxLength) + "...";
//        }

//        public static string GenerateBookingNumber()
//        {
//            Random rand = new Random();
//            string prefix = "IE";
//            string year = DateTime.Now.ToString("yy");
//            string month = DateTime.Now.ToString("MM");
//            string random = rand.Next(10000, 99999).ToString();
//            return $"{prefix}{year}{month}{random}";
//        }
//    }
//}
#endregion