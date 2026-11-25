<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="404.aspx.cs" Inherits="IslandEscape.UI.Public._404" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>Page Not Found</title>
    <style>
        body {
            font-family: Arial, sans-serif; background: #f8f9fa; margin: 0; padding: 0;

        }
        .error-container {
            text-align: center; padding: 100px 20px;

        }
        .error-container h1 {
            font-size: 6rem; color: #dc3545; margin: 0;

        }
        .error-container h2 {
            font-size: 2rem; color: #333;

        }
        .error-container p {
            color: #666; font-size: 1.1rem;

        }
        .error-container a {
            color: #0066B3; text-decoration: none;

        }
        .error-container a:hover {
            text-decoration: underline;
            `
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="error-container">
            <h1>404</h1>
            <h2>Page Not Found</h2>
            <p>The page you are looking for could not be found.</p>
            <p><a href="Default.aspx"><i class="bi bi-house"></i> Return to Home</a></p>
        </div>
    </form>
</body>
</html>