using System;
using System.Text;
using System.IO;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace IslandEscape.Core.App_Code.Extension
{
    public static class PDFGenerator
    {
        public static byte[] GenerateInvoice(
            string bookingNumber,
            string customerName,
            string email,
            string phone,
            string packageName,
            string description,
            int persons,
            decimal total,
            DateTime bookingDate,
            DateTime? travelDate,
            string status)
        {
            // ---- Build the invoice lines ----
            var lines = new List<string>();

            lines.Add("ISLAND ESCAPE ADVENTURES");
            lines.Add("Mauritius - Travel & Hospitality");
            lines.Add("------------------------------------------------");
            lines.Add("");
            lines.Add("INVOICE");
            lines.Add("Booking #: " + bookingNumber);
            lines.Add("Date: " + bookingDate.ToString("dd MMMM yyyy"));
            lines.Add("");
            lines.Add("CUSTOMER INFORMATION");
            lines.Add("Name   : " + customerName);
            lines.Add("Email  : " + email);
            lines.Add("Phone  : " + phone);
            lines.Add("");
            lines.Add("BOOKING DETAILS");
            lines.Add("Package     : " + packageName);
            lines.Add("Description : " + description);
            lines.Add("Persons     : " + persons);
            lines.Add("Status      : " + status);
            if (travelDate.HasValue)
                lines.Add("Travel Date : " + travelDate.Value.ToString("dd MMMM yyyy"));
            lines.Add("");
            lines.Add("TOTAL AMOUNT");
            lines.Add("------------------------------------------------");
            lines.Add("TOTAL: " + total.ToString("N0") + " MUR");
            lines.Add("");
            lines.Add("Thank you for choosing Island Escape Adventures!");
            lines.Add("support@islandescape.mu");
            lines.Add(DateTime.Now.ToString("dd MMM yyyy HH:mm"));

            // ---- Build PDF ----
            using (MemoryStream ms = new MemoryStream())
            using (StreamWriter writer = new StreamWriter(ms, Encoding.ASCII))
            {
                // Header
                writer.WriteLine("%PDF-1.4");

                // Object 1: Catalog
                long obj1Start = ms.Position;
                writer.WriteLine("1 0 obj");
                writer.WriteLine("<< /Type /Catalog /Pages 2 0 R >>");
                writer.WriteLine("endobj");

                // Object 2: Pages
                long obj2Start = ms.Position;
                writer.WriteLine("2 0 obj");
                writer.WriteLine("<< /Type /Pages /Kids [3 0 R] /Count 1 >>");
                writer.WriteLine("endobj");

                // Object 3: Page with Resources
                long obj3Start = ms.Position;
                writer.WriteLine("3 0 obj");
                writer.WriteLine("<< /Type /Page /Parent 2 0 R /MediaBox [0 0 612 792]");
                writer.WriteLine("   /Resources << /Font << /F1 << /Type /Font /Subtype /Type1 /BaseFont /Helvetica >> >> >>");
                writer.WriteLine("   /Contents 4 0 R");
                writer.WriteLine(">>");
                writer.WriteLine("endobj");

                // ---- Build Content Stream (separate BT/ET per line) ----
                StringBuilder content = new StringBuilder();

                int y = 750; // start from top
                int fontSize = 12;

                foreach (string line in lines)
                {
                    if (string.IsNullOrEmpty(line))
                    {
                        y -= 10; // blank line spacing
                        continue;
                    }

                    // Escape parentheses and backslashes
                    string escaped = line.Replace("\\", "\\\\").Replace("(", "\\(").Replace(")", "\\)");

                    content.AppendLine("BT");
                    content.AppendLine("/F1 " + fontSize + " Tf");
                    content.AppendLine(string.Format("{0} {1} Td", 50, y));
                    content.AppendLine("(" + escaped + ") Tj");
                    content.AppendLine("ET");

                    y -= 16; // line spacing
                }

                string contentString = content.ToString();
                byte[] contentBytes = Encoding.ASCII.GetBytes(contentString);
                int contentLength = contentBytes.Length;

                // Object 4: Content Stream
                long obj4Start = ms.Position;
                writer.WriteLine("4 0 obj");
                writer.WriteLine("<< /Length " + contentLength + " >>");
                writer.WriteLine("stream");
                writer.Write(contentString);
                writer.WriteLine();
                writer.WriteLine("endstream");
                writer.WriteLine("endobj");

                // Xref
                long xrefStart = ms.Position;
                writer.WriteLine("xref");
                writer.WriteLine("0 5");
                writer.WriteLine("0000000000 65535 f");
                writer.WriteLine(obj1Start.ToString("D10") + " 00000 n");
                writer.WriteLine(obj2Start.ToString("D10") + " 00000 n");
                writer.WriteLine(obj3Start.ToString("D10") + " 00000 n");
                writer.WriteLine(obj4Start.ToString("D10") + " 00000 n");

                // Trailer
                writer.WriteLine("trailer");
                writer.WriteLine("<< /Size 5 /Root 1 0 R >>");
                writer.WriteLine("startxref");
                writer.WriteLine(xrefStart.ToString());
                writer.WriteLine("%%EOF");

                writer.Flush();
                return ms.ToArray();
            }
        }
    }
}