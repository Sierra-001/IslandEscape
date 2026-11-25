<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="Navigation.ascx.cs" Inherits="IslandEscape.UI.UserControls.Common.Navigation" %>

<nav class="navbar navbar-expand-lg navbar-dark fixed-top">
    <div class="container">
        <a class="navbar-brand" href="<%= ResolveUrl("~/UI/Public/Default.aspx") %>">
            <img src="<%= ResolveUrl("~/Assets/Images/Logo/IslandEscape_Logo_Blend.png") %>" alt="Island Escape" style="height:40px;" />
            Island Escape
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#mainNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="mainNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <asp:HyperLink ID="lnkHome" runat="server" CssClass="nav-link" NavigateUrl="~/UI/Public/Default.aspx">
                        <i class="bi bi-house"></i> Home
                    </asp:HyperLink>
                </li>
                <li class="nav-item">
                    <asp:HyperLink ID="lnkPackages" runat="server" CssClass="nav-link" NavigateUrl="~/UI/Public/Packages.aspx">
                        <i class="bi bi-box"></i> Packages
                    </asp:HyperLink>
                </li>
                <li class="nav-item">
                    <asp:HyperLink ID="lnkAbout" runat="server" CssClass="nav-link" NavigateUrl="~/UI/Public/About.aspx">
                        <i class="bi bi-info-circle"></i> About
                    </asp:HyperLink>
                </li>
                <li class="nav-item">
                    <asp:HyperLink ID="lnkContact" runat="server" CssClass="nav-link" NavigateUrl="~/UI/Public/Contact.aspx">
                        <i class="bi bi-envelope"></i> Contact
                    </asp:HyperLink>
                </li>
                <li class="nav-item">
                    <asp:HyperLink ID="lnkCart" runat="server" CssClass="nav-link" NavigateUrl="~/UI/Public/Cart.aspx">
                        <i class="bi bi-cart"></i> Cart
                    </asp:HyperLink>
                </li>
                <li class="nav-item dropdown" id="accountDropdown" runat="server" visible="false">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                        <i class="bi bi-person"></i> Account
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><asp:HyperLink ID="lnkProfile" runat="server" CssClass="dropdown-item" NavigateUrl="~/UI/Secure/Profile.aspx"><i class="bi bi-person-gear"></i> Profile</asp:HyperLink></li>
                        <li><asp:HyperLink ID="lnkMyQueries" runat="server" CssClass="dropdown-item" NavigateUrl="~/UI/Secure/MyQueries.aspx"><i class="bi bi-envelope"></i> My Queries</asp:HyperLink></li>
                        <li><asp:HyperLink ID="lnkHistory" runat="server" CssClass="dropdown-item" NavigateUrl="~/UI/Secure/PurchaseHistory.aspx"><i class="bi bi-clock-history"></i> History</asp:HyperLink></li>
                        <li><hr class="dropdown-divider" /></li>
                        <li><asp:HyperLink ID="lnkLogout" runat="server" CssClass="dropdown-item" NavigateUrl="~/UI/Public/Logout.aspx"><i class="bi bi-box-arrow-right"></i> Logout</asp:HyperLink></li>
                    </ul>
                </li>
                <li class="nav-item" id="registerItem" runat="server">
                    <asp:HyperLink ID="lnkRegister" runat="server" CssClass="nav-link" NavigateUrl="~/UI/Public/Register.aspx">
                        <i class="bi bi-person-plus"></i> Register
                    </asp:HyperLink>
                </li>
                <li class="nav-item" id="loginItem" runat="server">
                    <asp:HyperLink ID="lnkLogin" runat="server" CssClass="nav-link" NavigateUrl="~/UI/Public/Login.aspx">
                        <i class="bi bi-box-arrow-in-right"></i> Login
                    </asp:HyperLink>
                </li>
                <li class="nav-item" id="adminItem" runat="server" visible="false">
                    <asp:HyperLink ID="lnkAdmin" runat="server" CssClass="nav-link" NavigateUrl="~/UI/Admin/Dashboard.aspx">
                        <i class="bi bi-shield-lock"></i> Admin
                    </asp:HyperLink>
                </li>
            </ul>
        </div>
    </div>
</nav>