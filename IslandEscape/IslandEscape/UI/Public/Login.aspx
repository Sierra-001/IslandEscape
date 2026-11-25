<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="IslandEscape.UI.Public.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="server">
    <style>
        .login-container { max-width: 400px; margin: 50px auto; }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container">
        <div class="login-container">
            <div class="card shadow">
                <div class="card-header bg-primary text-white text-center">
                    <h4 class="mb-0"><i class="bi bi-box-arrow-in-right"></i> Login</h4>
                </div>
                <div class="card-body">
                    
                    <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-dismissible fade show alert-danger w-100" Visible="false">
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                    </asp:Label>
                    
                    <div class="mb-3">
                        <label class="form-label">Username or Email</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-person"></i></span>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter username or email" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                            ControlToValidate="txtUsername" ErrorMessage="Username is required" 
                            CssClass="validation-error" Display="Dynamic" />
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter password" />
                        </div>
                        <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                            ControlToValidate="txtPassword" ErrorMessage="Password is required" 
                            CssClass="validation-error" Display="Dynamic" />
                    </div>
                    
                    <div class="mb-3 form-check">
                        <asp:CheckBox ID="chkRemember" runat="server" CssClass="form-check-input" />
                        <label class="form-check-label">Remember me</label>
                    </div>
                    
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-primary w-100" OnClick="btnLogin_Click" />
                    
                    <div class="mt-3 text-center">
                        <a href="ForgotPassword.aspx">Forgot Password?</a> | 
                        <a href="Register.aspx">Create Account</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>