using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Linq;
using System.Web;

namespace IslandEscape.Core.App_Code.Helpers
{
    public static class ValidationHelper
    {
        public static bool IsEmail(string email)
        {
            if (string.IsNullOrEmpty(email)) return false;

            string pattern = @"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";
            return Regex.IsMatch(email, pattern);
        }

        public static bool IsPhone(string phone)
        {
            if (string.IsNullOrEmpty(phone)) return true;

            string pattern = @"^[\d\s\-+()]{8,20}$";
            return Regex.IsMatch(phone, pattern);
        }

        public static bool IsUrl(string url)
        {
            if (string.IsNullOrEmpty(url)) return false;

            string pattern = @"^(https?://)?([\da-z.-]+)\.([a-z.]{2,6})([/\w .-]*)*/?$";
            return Regex.IsMatch(url, pattern, RegexOptions.IgnoreCase);
        }

        public static bool IsPostalCode(string code)
        {
            if (string.IsNullOrEmpty(code)) return false;

            string pattern = @"^[A-Z0-9\s\-]{3,10}$";
            return Regex.IsMatch(code.ToUpper(), pattern);
        }

        public static bool IsPositiveInteger(string value)
        {
            if (string.IsNullOrEmpty(value)) return false;

            int result;
            if (!int.TryParse(value, out result)) return false;

            return result > 0;
        }

        public static bool IsNonNegativeInteger(string value)
        {
            if (string.IsNullOrEmpty(value)) return false;

            int result;
            if (!int.TryParse(value, out result)) return false;

            return result >= 0;
        }

        public static bool IsPositiveDecimal(string value)
        {
            if (string.IsNullOrEmpty(value)) return false;

            decimal result;
            if (!decimal.TryParse(value, out result)) return false;

            return result > 0;
        }

        public static bool IsDate(string value)
        {
            if (string.IsNullOrEmpty(value)) return false;

            DateTime result;
            return DateTime.TryParse(value, out result);
        }

        public static bool IsFutureDate(DateTime date)
        {
            return date > DateTime.Now;
        }

        public static bool IsPastDate(DateTime date)
        {
            return date < DateTime.Now;
        }

        public static bool IsValidCreditCard(string cardNumber)
        {
            if (string.IsNullOrEmpty(cardNumber)) return false;

            cardNumber = Regex.Replace(cardNumber, @"[\s\-]", "");

            if (!Regex.IsMatch(cardNumber, @"^\d{13,19}$")) return false;

            int sum = 0;
            bool alternate = false;

            for (int i = cardNumber.Length - 1; i >= 0; i--)
            {
                int n = int.Parse(cardNumber[i].ToString());
                if (alternate)
                {
                    n *= 2;
                    if (n > 9) n -= 9;
                }
                sum += n;
                alternate = !alternate;
            }

            return sum % 10 == 0;
        }

        public static string SanitizeInput(string input)
        {
            if (string.IsNullOrEmpty(input)) return input;

            string sanitized = input;
            sanitized = Regex.Replace(sanitized, @"<script.*?>.*?</script>", "", RegexOptions.IgnoreCase | RegexOptions.Singleline);
            sanitized = Regex.Replace(sanitized, @"<.*?on\w+=\s*""[^""]*""", "", RegexOptions.IgnoreCase);
            sanitized = Regex.Replace(sanitized, @"javascript:", "", RegexOptions.IgnoreCase);
            sanitized = Regex.Replace(sanitized, @"<.*?>", "");

            return sanitized;
        }
    }
}