<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="IslandEscape.UI.Public.Default" %>

<%@ Register Src="~/UI/UserControls/Package/PackageCard.ascx" TagPrefix="uc" TagName="PackageCard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="hero-carousel">
    <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="<%= ResolveUrl("~/Assets/Images/Backgrounds/hero1.png") %>" 
                     class="d-block w-100" 
                     alt="Discover Paradise" 
                     style="height:500px; object-fit:cover; object-position:center;" />
                <div class="carousel-caption">
                    <h1 style="color: #ffffff !important;">Discover Paradise</h1>
                    <p>Experience the beauty of Mauritius with our exclusive travel packages</p>
                    <a href="Packages.aspx" class="btn btn-primary btn-lg">Explore Now</a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="<%= ResolveUrl("~/Assets/Images/Backgrounds/hero2.png") %>" 
                     class="d-block w-100" 
                     alt="Luxury Getaways" 
                     style="height:500px; object-fit:cover; object-position:center;" />
                <div class="carousel-caption">
                    <h1 style="color: #ffffff !important;">Luxury Getaways</h1>
                    <p>Stay at the finest resorts and hotels across Mauritius</p>
                    <a href="Packages.aspx?category=1" class="btn btn-primary btn-lg">View Hotels</a>
                </div>
            </div>
            <div class="carousel-item">
                <img src="<%= ResolveUrl("~/Assets/Images/Backgrounds/hero3.png") %>" 
                     class="d-block w-100" 
                     alt="Adventure Awaits" 
                     style="height:500px; object-fit:cover; object-position:center;" />
                <div class="carousel-caption">
                    <h1 style="color: #ffffff !important;">Adventure Awaits</h1>
                    <p>From scuba diving to quad biking - find your perfect adventure</p>
                    <a href="Packages.aspx?category=3" class="btn btn-primary btn-lg">View Activities</a>
                </div>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
            <span class="carousel-control-prev-icon"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
            <span class="carousel-control-next-icon"></span>
        </button>
    </div>
</div>
    
    <div class="container">
        <div class="search-box">
            <div class="row g-3">
                <div class="col-md-4">
                    <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control" placeholder="Search packages..."></asp:TextBox>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                        <asp:ListItem Text="All Categories" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-3">
                    <asp:DropDownList ID="ddlLocation" runat="server" CssClass="form-select">
                        <asp:ListItem Text="All Locations" Value=""></asp:ListItem>
                    </asp:DropDownList>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnSearch" runat="server" Text=" Search" CssClass="btn btn-primary w-100" OnClick="btnSearch_Click" />
                </div>
            </div>
        </div>
    </div>
    
    <div class="container mt-5">
        <h2 class="text-center mb-4">Explore Our Categories</h2>
        <div class="row">
            <asp:Repeater ID="rptCategories" runat="server">
                <ItemTemplate>
                    <div class="col-md-2 col-6 mb-3">
                        <div class="category-card" onclick="window.location.href='Packages.aspx?category=<%# Eval("CategoryID") %>'">
                            <div class="icon"><i class="bi <%# Eval("Icon") %>"></i></div>
                            <h5><%# Eval("Name") %></h5>
                            <p><%# Eval("Description") %></p>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
    
    <div class="container mt-5">
        <h2 class="text-center mb-4">Featured Packages</h2>
        <div class="row">
            <asp:Repeater ID="rptFeaturedPackages" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 mb-4">
                        <uc:PackageCard ID="pkgCard" runat="server"
                            PackageID='<%# Eval("PackageID") %>'
                            Name='<%# Eval("Name") %>'
                            Description='<%# Eval("Description") %>'
                            Price='<%# Convert.ToDecimal(Eval("Price")) %>'
                            ImageURL='<%# Eval("ImageURL") %>'
                            BadgeText="Featured"
                            BadgeClass="featured" />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="text-center mt-3">
            <a href="Packages.aspx" class="btn btn-primary">View All Packages</a>
        </div>
    </div>
    
</asp:Content>