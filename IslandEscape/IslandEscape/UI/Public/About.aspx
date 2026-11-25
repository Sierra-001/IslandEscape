<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="IslandEscape.UI.Public.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <h2 class="text-center mb-4">About Island Escape Adventures</h2>
                
                <div class="card shadow">
                    <div class="card-body">
                        <h4>Welcome to Paradise</h4>
                        <p>
                            Island Escape Adventures is a premier travel company based in the beautiful island of Mauritius. 
                            We specialize in creating unforgettable holiday experiences for travelers from around the world.
                        </p>
                        
                        <h4 class="mt-4">Our Mission</h4>
                        <p>
                            To provide exceptional travel experiences that showcase the natural beauty, rich culture, 
                            and warm hospitality of Mauritius. We believe in creating memories that last a lifetime.
                        </p>
                        
                        <h4 class="mt-4">What We Offer</h4>
                        <div class="row mt-3">
                            <div class="col-md-6">
                                <ul class="list-unstyled">
                                    <li><i class="bi bi-check-circle-fill text-success"></i> Luxury Hotels & Resorts</li>
                                    <li><i class="bi bi-check-circle-fill text-success"></i> Beachfront Accommodations</li>
                                    <li><i class="bi bi-check-circle-fill text-success"></i> Adventure Activities</li>
                                </ul>
                            </div>
                            <div class="col-md-6">
                                <ul class="list-unstyled">
                                    <li><i class="bi bi-check-circle-fill text-success"></i> Island Excursions</li>
                                    <li><i class="bi bi-check-circle-fill text-success"></i> Airport Transfers</li>
                                    <li><i class="bi bi-check-circle-fill text-success"></i> Dining Experiences</li>
                                </ul>
                            </div>
                        </div>
                        
                        <h4 class="mt-4">Why Choose Us</h4>
                        <div class="row">
                            <div class="col-md-4 text-center">
                                <i class="bi bi-star-fill text-warning" style="font-size: 2.5rem;"></i>
                                <h5 class="mt-2">Quality</h5>
                                <p>Hand-picked packages with the best value</p>
                            </div>
                            <div class="col-md-4 text-center">
                                <i class="bi bi-shield-check text-primary" style="font-size: 2.5rem;"></i>
                                <h5 class="mt-2">Trust</h5>
                                <p>Secure booking and professional service</p>
                            </div>
                            <div class="col-md-4 text-center">
                                <i class="bi bi-heart-fill text-danger" style="font-size: 2.5rem;"></i>
                                <h5 class="mt-2">Passion</h5>
                                <p>We love what we do and it shows</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>