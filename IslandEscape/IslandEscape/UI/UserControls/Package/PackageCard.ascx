<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="PackageCard.ascx.cs" Inherits="IslandEscape.UI.UserControls.Package.PackageCard" %>

<div class="package-card position-relative">
    <asp:Label ID="lblBadge" runat="server" CssClass="package-badge" Visible="false"></asp:Label>
    
    <asp:Image ID="imgPackage" runat="server" CssClass="card-img-top" />
    
    <div class="card-body">
        <h5 class="card-title"><asp:Label ID="lblName" runat="server"></asp:Label></h5>
        
        <p class="card-text"><asp:Label ID="lblDescription" runat="server"></asp:Label></p>
        
        <div class="d-flex justify-content-between align-items-center">
            <span class="price"><asp:Label ID="lblPrice" runat="server"></asp:Label> <span>MUR</span></span>
            <asp:HyperLink ID="hlDetails" runat="server" CssClass="btn btn-primary">View Details</asp:HyperLink>
        </div>
    </div>
</div>