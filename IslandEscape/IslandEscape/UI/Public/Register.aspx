<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="IslandEscape.UI.Public.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-5">
        <div class="form-container">
            <h2><i class="bi bi-person-plus"></i> Create Account</h2>
            
            <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-dismissible fade show" Visible="false">
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                <asp:Literal ID="litMessage" runat="server"></asp:Literal>
            </asp:Label>
            
            <div class="mb-3">
                <label class="form-label">Full Name <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" placeholder="Enter your full name" />
                <asp:RequiredFieldValidator ID="rfvFullName" runat="server" 
                    ControlToValidate="txtFullName" ErrorMessage="Full name is required" 
                    CssClass="validation-error" Display="Dynamic" />
            </div>
            
            <div class="mb-3">
                <label class="form-label">Username <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Choose a username" />
                <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                    ControlToValidate="txtUsername" ErrorMessage="Username is required" 
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
                <label class="form-label">Password <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Create a password (min 6 chars)" />
                <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                    ControlToValidate="txtPassword" ErrorMessage="Password is required" 
                    CssClass="validation-error" Display="Dynamic" />
                <small class="text-muted">Password must be at least 6 characters with uppercase, lowercase, and a digit.</small>
            </div>
            
            <div class="mb-3">
                <label class="form-label">Confirm Password <span class="text-danger">*</span></label>
                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Confirm your password" />
                <asp:CompareValidator ID="cvPassword" runat="server" 
                    ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" 
                    ErrorMessage="Passwords do not match" CssClass="validation-error" Display="Dynamic" />
            </div>
            
            <div class="mb-3">
                <label class="form-label">Phone Number</label>
                <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter your phone number (optional)" />
            </div>
            
            <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-primary w-100" OnClick="btnRegister_Click" />
            
            <div class="mt-3 text-center">
                Already have an account? <a href="Login.aspx">Login</a>
            </div>
        </div>
    </div>
    
</asp:Content>