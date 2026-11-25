<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="PackageDetails.aspx.cs" Inherits="IslandEscape.UI.Public.PackageDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-dismissible fade show" Visible="false">
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            <asp:Literal ID="litMessage" runat="server"></asp:Literal>
        </asp:Label>
        
        <asp:Panel ID="pnlPackage" runat="server" Visible="false">
            <div class="row">
                <div class="col-md-6">
                    <asp:Image ID="imgPackage" runat="server" CssClass="img-fluid rounded shadow" style="width:100%; height:auto;" />
                </div>
                
                <div class="col-md-6">
                    <h1><asp:Label ID="lblName" runat="server"></asp:Label></h1>
                    
                    <div class="mb-2">
                        <span class="badge bg-primary"><asp:Label ID="lblCategory" runat="server"></asp:Label></span>
                        <span class="badge bg-secondary"><i class="bi bi-geo-alt"></i> <asp:Label ID="lblLocation" runat="server"></asp:Label></span>
                    </div>
                    
                    <p class="mt-3"><asp:Label ID="lblDescription" runat="server"></asp:Label></p>
                    
                    <hr />
                    
                    <div class="row">
                        <div class="col-6">
                            <h3 class="text-primary"><asp:Label ID="lblPrice" runat="server"></asp:Label> <small class="text-muted" style="font-size:1rem;">MUR</small></h3>
                        </div>
                        <div class="col-6 text-end">
                            <span class="badge bg-success"><i class="bi bi-clock"></i> <asp:Label ID="lblDuration" runat="server"></asp:Label></span>
                        </div>
                    </div>
                    
                    <div class="row mt-2">
                        <div class="col-6">
                            <p><i class="bi bi-people"></i> Max Persons: <strong><asp:Label ID="lblMaxPersons" runat="server"></asp:Label></strong></p>
                        </div>
                        <div class="col-6 text-end">
                            <p><i class="bi bi-tag"></i> <asp:Label ID="lblStatus" runat="server" CssClass="badge bg-success"></asp:Label></p>
                        </div>
                    </div>
                    
                    <hr />
                    
                    <div class="d-flex gap-3">
                        <asp:Button ID="btnAddToCart" runat="server" Text=" Add to Cart" CssClass="btn btn-primary btn-lg" OnClick="btnAddToCart_Click" />
                        <asp:Button ID="btnBookNow" runat="server" Text=" Book Now" CssClass="btn btn-success btn-lg" OnClick="btnBookNow_Click" />
                    </div>
                </div>
            </div>
        </asp:Panel>
    </div>
    
</asp:Content>