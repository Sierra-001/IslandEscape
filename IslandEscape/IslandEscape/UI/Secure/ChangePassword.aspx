<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="IslandEscape.UI.Secure.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h4 class="mb-0"><i class="bi bi-key"></i> Change Password</h4>
                    </div>
                    <div class="card-body">
                        
                        <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-dismissible fade show" Visible="false">
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                        </asp:Label>

                        <div class="mb-3">
                            <label class="form-label">Current Password</label>
                            <asp:TextBox ID="txtCurrentPassword" runat="server" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvCurrent" runat="server" 
                                ControlToValidate="txtCurrentPassword" ErrorMessage="Current password is required" 
                                CssClass="validation-error" Display="Dynamic" />
                        </div>

                        <div class="mb-3">
                            <label class="form-label">New Password</label>
                            <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator ID="rfvNew" runat="server" 
                                ControlToValidate="txtNewPassword" ErrorMessage="New password is required" 
                                CssClass="validation-error" Display="Dynamic" />
                            <small class="text-muted">Password must be at least 6 characters with uppercase, lowercase, and a digit.</small>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">Confirm New Password</label>
                            <asp:TextBox ID="txtConfirmNew" runat="server" TextMode="Password" CssClass="form-control" />
                            <asp:CompareValidator ID="cvConfirm" runat="server" 
                                ControlToValidate="txtConfirmNew" ControlToCompare="txtNewPassword" 
                                ErrorMessage="Passwords do not match" CssClass="validation-error" Display="Dynamic" />
                        </div>

                        <div class="d-flex gap-2">
                            <asp:Button ID="btnChange" runat="server" Text="Change Password" CssClass="btn btn-primary" OnClick="btnChange_Click" />
                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" CausesValidation="false" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>