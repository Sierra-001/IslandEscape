<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManagePackages.aspx.cs" Inherits="IslandEscape.UI.Admin.ManagePackages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    Manage Packages
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="mb-3">
        <asp:Button ID="btnAddNew" runat="server" Text=" Add New Package" CssClass="btn btn-primary" OnClick="btnAddNew_Click" />
    </div>
    
    <div class="admin-card">
        <h5 class="card-title"><i class="bi bi-box"></i> All Packages</h5>
        <div class="table-responsive">
            <asp:GridView ID="gvPackages" runat="server" CssClass="admin-table" 
                AutoGenerateColumns="false" DataKeyNames="PackageID"
                OnRowEditing="gvPackages_RowEditing" 
                OnRowCancelingEdit="gvPackages_RowCancelingEdit"
                OnRowUpdating="gvPackages_RowUpdating" 
                OnRowDeleting="gvPackages_RowDeleting">
                <Columns>
                    <asp:BoundField DataField="PackageID" HeaderText="ID" ReadOnly="true" />
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Location" HeaderText="Location" />
                    <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:N0}" />
                    <asp:CheckBoxField DataField="IsActive" HeaderText="Active" />
                    <asp:CommandField ShowEditButton="true" ShowDeleteButton="true" 
                        EditText="<i class='bi bi-pencil'></i>" 
                        DeleteText="<i class='bi bi-trash'></i>"
                        ButtonType="Link" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
    
</asp:Content>