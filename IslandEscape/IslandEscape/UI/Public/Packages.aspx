<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Packages.aspx.cs" Inherits="IslandEscape.UI.Public.Packages" %>

<%@ Register Src="~/UI/UserControls/Package/PackageCard.ascx" TagPrefix="uc" TagName="PackageCard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <div class="row mb-4">
            <div class="col-md-8">
                <h2>Our Packages</h2>
                <p class="text-muted">Discover the best experiences Mauritius has to offer</p>
            </div>
            <div class="col-md-4 text-end">
                <asp:Label ID="lblResultCount" runat="server" CssClass="text-muted"></asp:Label>
            </div>
        </div>
        
        <div class="row mb-4">
            <div class="col-md-12">
                <div class="d-flex flex-wrap gap-2">
                    <asp:HyperLink ID="hlAll" runat="server" NavigateUrl="Packages.aspx" CssClass="btn btn-outline-primary">All</asp:HyperLink>
                    <asp:Repeater ID="rptFilterCategories" runat="server">
                        <ItemTemplate>
                            <asp:HyperLink ID="hlCategory" runat="server" 
                                NavigateUrl='<%# "Packages.aspx?category=" + Eval("CategoryID") %>' 
                                CssClass="btn btn-outline-secondary">
                                <%# Eval("Name") %>
                            </asp:HyperLink>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </div>
        
        <div class="row">
            <asp:Repeater ID="rptPackages" runat="server">
                <ItemTemplate>
                    <div class="col-md-4 mb-4">
                        <uc:PackageCard ID="pkgCard" runat="server"
                            PackageID='<%# Eval("PackageID") %>'
                            Name='<%# Eval("Name") %>'
                            Description='<%# Eval("Description") %>'
                            Price='<%# Convert.ToDecimal(Eval("Price")) %>'
                            ImageURL='<%# Eval("ImageURL") %>' />
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        
        <div class="text-center py-5" id="divNoResults" runat="server" visible="false">
            <i class="bi bi-search" style="font-size: 3rem; color: #ccc;"></i>
            <h4 class="mt-3">No packages found</h4>
            <p class="text-muted">Try adjusting your search or filter criteria</p>
            <a href="Packages.aspx" class="btn btn-primary">View All Packages</a>
        </div>
    </div>
    
</asp:Content>