<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="IslandEscape.UI.Public.Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <h2 class="text-center mb-4">Contact Us</h2>
                
                <div class="card shadow">
                    <div class="card-body">
                        
                        <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-dismissible fade show" Visible="false">
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                        </asp:Label>
                        
                        <div class="mb-3">
                            <label class="form-label">Your Name <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter your full name" />
                            <asp:RequiredFieldValidator ID="rfvName" runat="server" 
                                ControlToValidate="txtName" ErrorMessage="Name is required" 
                                CssClass="validation-error" Display="Dynamic" />
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Email Address <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your email address" />
                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                                ControlToValidate="txtEmail" ErrorMessage="Email is required" 
                                CssClass="validation-error" Display="Dynamic" />
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Subject <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control" placeholder="Enter subject" />
                            <asp:RequiredFieldValidator ID="rfvSubject" runat="server" 
                                ControlToValidate="txtSubject" ErrorMessage="Subject is required" 
                                CssClass="validation-error" Display="Dynamic" />
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Message <span class="text-danger">*</span></label>
                            <asp:TextBox ID="txtMessage" runat="server" TextMode="MultiLine" Rows="5" CssClass="form-control" placeholder="Write your message here" />
                            <asp:RequiredFieldValidator ID="rfvMessage" runat="server" 
                                ControlToValidate="txtMessage" ErrorMessage="Message is required" 
                                CssClass="validation-error" Display="Dynamic" />
                        </div>
                        
                        <asp:Button ID="btnSubmit" runat="server" Text="Send Message" CssClass="btn btn-primary w-100" OnClick="btnSubmit_Click" />
                    </div>
                </div>
                
                <div class="row mt-4 text-center">
                    <div class="col-md-4">
                        <i class="bi bi-geo-alt" style="font-size: 2rem; color: var(--primary);"></i>
                        <p class="mt-2"><strong>Address</strong><br />Port Louis, Mauritius</p>
                    </div>
                    <div class="col-md-4">
                        <i class="bi bi-telephone" style="font-size: 2rem; color: var(--primary);"></i>
                        <p class="mt-2"><strong>Phone</strong><br />+230 5901 2408</p>
                    </div>
                    <div class="col-md-4">
                        <i class="bi bi-envelope" style="font-size: 2rem; color: var(--primary);"></i>
                        <p class="mt-2"><strong>Email</strong><br />info@islandescape.mu</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>