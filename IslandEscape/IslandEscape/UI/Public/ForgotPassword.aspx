<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="IslandEscape.UI.Public.ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .reset-container { max-width: 450px; margin: 50px auto; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container">
        <div class="reset-container">
            <div class="card shadow">
                <div class="card-header bg-warning text-dark text-center">
                    <h4 class="mb-0"><i class="bi bi-key"></i> Forgot Password</h4>
                </div>
                <div class="card-body">
                    
                    <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-dismissible fade show" Visible="false">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                    </asp:Label>
                    
                    <p class="text-muted">Enter your email address and we'll send you a password reset link.</p>
                    
                    <div class="mb-3">
                        <label class="form-label">Email Address</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-envelope"></i></span>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter your registered email" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvEmail" runat="server" 
                            ControlToValidate="txtEmail" ErrorMessage="Email is required" 
                            CssClass="validation-error" Display="Dynamic" />
                    </div>
                    
                    <asp:Button ID="btnReset" runat="server" Text="Send Reset Link" CssClass="btn btn-primary w-100" OnClick="btnReset_Click" />
                    
                    <div class="mt-3 text-center">
                        <a href="Login.aspx"><i class="bi bi-arrow-left"></i> Back to Login</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>