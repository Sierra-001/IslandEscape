<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="AddPackage.aspx.cs" Inherits="IslandEscape.UI.Admin.AddPackage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    Add New Package
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="row">
        <div class="col-md-8 mx-auto">
            <div class="admin-card">
                <h5 class="card-title"><i class="bi bi-plus-circle"></i> Add New Package</h5>
                
                <asp:Label ID="lblMessage" runat="server" CssClass="alert" Visible="false">
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    <asp:Literal ID="litMessage" runat="server"></asp:Literal>
                </asp:Label>
                
                <div class="mb-3">
                    <label class="form-label">Category <span class="text-danger">*</span></label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select" />
                    <asp:RequiredFieldValidator ID="rfvCategory" runat="server" 
                        ControlToValidate="ddlCategory" InitialValue=""
                        ErrorMessage="Please select a category" CssClass="validation-error" Display="Dynamic" />
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Package Name <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter package name" />
                    <asp:RequiredFieldValidator ID="rfvName" runat="server" 
                        ControlToValidate="txtName" ErrorMessage="Name is required" 
                        CssClass="validation-error" Display="Dynamic" />
                </div>
                
                <div class="mb-3">
                    <label class="form-label">Description <span class="text-danger">*</span></label>
                    <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine" Rows="4" 
                        CssClass="form-control" placeholder="Enter package description" />
                    <asp:RequiredFieldValidator ID="rfvDescription" runat="server" 
                        ControlToValidate="txtDescription" ErrorMessage="Description is required" 
                        CssClass="validation-error" Display="Dynamic" />
                </div>
                
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Price (MUR) <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtPrice" runat="server" CssClass="form-control" placeholder="0.00" />
                        <asp:RequiredFieldValidator ID="rfvPrice" runat="server" 
                            ControlToValidate="txtPrice" ErrorMessage="Price is required" 
                            CssClass="validation-error" Display="Dynamic" />
                        <asp:RegularExpressionValidator ID="revPrice" runat="server"
                            ControlToValidate="txtPrice"
                            ValidationExpression="^\d+(\.\d{1,2})?$"
                            ErrorMessage="Please enter a valid price" CssClass="validation-error" Display="Dynamic" />
                    </div>
                    
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Discounted Price (MUR)</label>
                        <asp:TextBox ID="txtDiscountedPrice" runat="server" CssClass="form-control" placeholder="0.00" />
                    </div>
                    
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Duration</label>
                        <asp:TextBox ID="txtDuration" runat="server" CssClass="form-control" placeholder="e.g., 5 Nights" />
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Location <span class="text-danger">*</span></label>
                        <asp:TextBox ID="txtLocation" runat="server" CssClass="form-control" placeholder="e.g., Grand Baie" />
                        <asp:RequiredFieldValidator ID="rfvLocation" runat="server" 
                            ControlToValidate="txtLocation" ErrorMessage="Location is required" 
                            CssClass="validation-error" Display="Dynamic" />
                    </div>
                    
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Max Persons</label>
                        <asp:TextBox ID="txtMaxPersons" runat="server" CssClass="form-control" placeholder="2" />
                        <asp:RegularExpressionValidator ID="revMaxPersons" runat="server"
                            ControlToValidate="txtMaxPersons"
                            ValidationExpression="^\d+$"
                            ErrorMessage="Please enter a valid number" CssClass="validation-error" Display="Dynamic" />
                    </div>
                    
                    <div class="col-md-4 mb-3">
                        <label class="form-label">Image Filename</label>
                        <asp:TextBox ID="txtImageURL" runat="server" CssClass="form-control" placeholder="image.jpg" />
                        <small class="text-muted">Place image in Assets/Images/Packages/</small>
                    </div>
                </div>
                
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <div class="form-check">
                            <asp:CheckBox ID="chkIsFeatured" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label">Featured Package</label>
                        </div>
                    </div>
                    
                    <div class="col-md-6 mb-3">
                        <div class="form-check">
                            <asp:CheckBox ID="chkIsActive" runat="server" CssClass="form-check-input" Checked="true" />
                            <label class="form-check-label">Active</label>
                        </div>
                    </div>
                </div>
                
                <hr />
                
                <div class="d-flex gap-2">
                    <asp:Button ID="btnSave" runat="server" Text="Save Package" CssClass="btn btn-primary" OnClick="btnSave_Click" />
                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-secondary" OnClick="btnCancel_Click" />
                </div>
            </div>
        </div>
    </div>
    
</asp:Content>