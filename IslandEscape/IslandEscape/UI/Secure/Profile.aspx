<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="IslandEscape.UI.Secure.Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-8 mx-auto">
                <h2 class="mb-4"><i class="bi bi-person-gear"></i> My Profile</h2>
                
                <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-dismissible fade show" Visible="false">
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                </asp:Label>
                
                <div class="card shadow">
                    <div class="card-body">
                        
                        <div class="text-center mb-4">
                            <div class="avatar-placeholder" style="width:100px; height:100px; background:var(--primary); color:white; border-radius:50%; display:inline-flex; align-items:center; justify-content:center; font-size:2.5rem; font-weight:bold;">
                                <asp:Label ID="lblInitials" runat="server"></asp:Label>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Full Name</label>
                            <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvFullName" runat="server" 
                                ControlToValidate="txtFullName" ErrorMessage="Full name is required" 
                                CssClass="validation-error" Display="Dynamic" />
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Username</label>
                            <asp:Label ID="lblUsername" runat="server" CssClass="form-control-plaintext fw-bold"></asp:Label>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Email Address</label>
                            <asp:Label ID="lblEmail" runat="server" CssClass="form-control-plaintext"></asp:Label>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Phone Number</label>
                            <asp:TextBox ID="txtPhone" runat="server" CssClass="form-control" placeholder="Enter your phone number" />
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Member Since</label>
                            <asp:Label ID="lblMemberSince" runat="server" CssClass="form-control-plaintext"></asp:Label>
                        </div>
                        
                        <hr />
                        
                        <asp:Button ID="btnUpdate" runat="server" Text="Update Profile" CssClass="btn btn-primary" OnClick="btnUpdate_Click" />
                        
                        <a href="ChangePassword.aspx" class="btn btn-outline-secondary ms-2">Change Password</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>