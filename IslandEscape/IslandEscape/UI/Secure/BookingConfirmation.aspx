<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="BookingConfirmation.aspx.cs" Inherits="IslandEscape.UI.Secure.BookingConfirmation" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 mx-auto">
                
                <div class="text-center mb-4">
                    <i class="bi bi-check-circle-fill text-success" style="font-size: 5rem;"></i>
                </div>
                
                <div class="card shadow">
                    <div class="card-header bg-success text-white text-center">
                        <h3 class="mb-0"><i class="bi bi-check-circle"></i> Booking Confirmed!</h3>
                    </div>
                    <div class="card-body text-center">
                        
                        <h4 class="text-success">Thank you for your booking!</h4>
                        
                        <p class="mt-3">Your booking has been confirmed and payment has been processed successfully.</p>
                        
                        <div class="alert alert-info mt-3">
                            <strong>Transaction ID:</strong> <asp:Label ID="lblTransactionId" runat="server"></asp:Label>
                        </div>
                        
                        <div class="alert alert-secondary mt-3">
                            <p class="mb-1"><strong>Booking Number:</strong> <asp:Label ID="lblBookingNumber" runat="server"></asp:Label></p>
                            <p class="mb-0"><strong>Date:</strong> <asp:Label ID="lblBookingDate" runat="server"></asp:Label></p>
                        </div>
                        
                        <hr />
                        
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <a href="Profile.aspx" class="btn btn-outline-primary w-100" runat="server">
                                    <i class="bi bi-person-gear"></i> My Profile
                                </a>
                            </div>
                            <div class="col-md-6">
                                <a href="PurchaseHistory.aspx" class="btn btn-primary w-100" runat="server">
                                    <i class="bi bi-clock-history"></i> View History
                                </a>
                            </div>
                        </div>
                        
                        <div class="mt-3">
                            <a href="~/UI/Public/Default.aspx" class="btn btn-secondary w-100" runat="server">
                                <i class="bi bi-house"></i> Return to Home
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>