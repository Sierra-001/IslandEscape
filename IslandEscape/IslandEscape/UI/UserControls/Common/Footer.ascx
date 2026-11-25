<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Footer.ascx.cs" Inherits="IslandEscape.UI.UserControls.Common.Footer" %>

<footer class="footer">
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <h5>Island Escape Adventures</h5>
                <p>Discover the beauty of Mauritius with our premium travel packages.</p>
            </div>
            <div class="col-md-4">
                <h5>Quick Links</h5>
                <ul class="list-unstyled">
                    <li><asp:HyperLink ID="lnkPackages" runat="server" NavigateUrl="~/UI/Public/Packages.aspx"><i class="bi bi-box"></i> Our Packages</asp:HyperLink></li>
                    <li><asp:HyperLink ID="lnkAbout" runat="server" NavigateUrl="~/UI/Public/About.aspx"><i class="bi bi-info-circle"></i> About Us</asp:HyperLink></li>
                    <li><asp:HyperLink ID="lnkContact" runat="server" NavigateUrl="~/UI/Public/Contact.aspx"><i class="bi bi-envelope"></i> Contact Us</asp:HyperLink></li>
                    <li><asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/UI/Public/Register.aspx"><i class="bi bi-person-plus"></i> Register</asp:HyperLink></li>
                </ul>
            </div>
            <div class="col-md-4">
                <h5>Contact Information</h5>
                <p><i class="bi bi-envelope"></i> <strong>Email:</strong> info@islandescape.mu</p>
                <p><i class="bi bi-telephone"></i> <strong>Phone:</strong> +230 5901 2408</p>
                <p><i class="bi bi-geo-alt"></i> <strong>Address:</strong> Port Louis, Mauritius</p>
                <div class="social-icons">
                    <a href="#"><i class="bi bi-facebook"></i></a>
                    <a href="#"><i class="bi bi-instagram"></i></a>
                    <a href="#"><i class="bi bi-twitter"></i></a>
                    <a href="#"><i class="bi bi-youtube"></i></a>
                </div>
            </div>
        </div>
        <div class="footer-bottom text-center">
            &copy; 2026 Island Escape Adventures. All rights reserved.
            <p>Made By Tonta Jonathan From BSE/25A/FT2</p>
        </div>
    </div>
</footer>