<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="ResetPassword.aspx.cs" Inherits="IslandEscape.UI.Public.ResetPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .reset-container { max-width: 450px; margin: 50px auto; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container">
        <div class="reset-container">
            <div class="card shadow">
                <div class="card-header bg-success text-white text-center">
                    <h4 class="mb-0"><i class="bi bi-shield-lock"></i> Reset Password</h4>
                </div>
                <div class="card-body">
                    
                    <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-dismissible fade show" Visible="false">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                    </asp:Label>
                    
                    <div class="mb-3">
                        <label class="form-label">New Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter new password" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                            ControlToValidate="txtPassword" ErrorMessage="Password is required" 
                            CssClass="validation-error" Display="Dynamic" />
                        <small class="text-muted">Password must be at least 6 characters with uppercase, lowercase, and a digit.</small>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Confirm Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Confirm your password" />
                        </div>
                        <asp:CompareValidator ID="cvPassword" runat="server" 
                            ControlToValidate="txtConfirmPassword" ControlToCompare="txtPassword" 
                            ErrorMessage="Passwords do not match" CssClass="validation-error" Display="Dynamic" />
                    </div>
                    
                    <asp:Button ID="btnReset" runat="server" Text="Reset Password" CssClass="btn btn-primary w-100" OnClick="btnReset_Click" />
                    
                    <div class="mt-3 text-center">
                        <a href="Login.aspx"><i class="bi bi-arrow-left"></i> Back to Login</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>