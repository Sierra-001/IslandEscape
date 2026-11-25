<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="IslandEscape.UI.Admin.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    Manage Users
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="admin-card">
        <h5 class="card-title"><i class="bi bi-people"></i> All Users</h5>
        <div class="table-responsive">
            <asp:GridView ID="gvUsers" runat="server" CssClass="admin-table" 
                AutoGenerateColumns="false" DataKeyNames="UserID"
                OnRowDeleting="gvUsers_RowDeleting"
                OnRowCommand="gvUsers_RowCommand">
                <Columns>
                    <asp:BoundField DataField="UserID" HeaderText="ID" />
                    <asp:BoundField DataField="Username" HeaderText="Username" />
                    <asp:BoundField DataField="FullName" HeaderText="Full Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Role" HeaderText="Role" />
                    <asp:BoundField DataField="CreatedDate" HeaderText="Joined" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='badge <%# Convert.ToBoolean(Eval("IsActive")) ? "badge-success" : "badge-danger" %>'>
                                <%# Convert.ToBoolean(Eval("IsActive")) ? "Active" : "Inactive" %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnToggleStatus" runat="server" 
                                CommandName="ToggleStatus" 
                                CommandArgument='<%# Eval("UserID") + "|" + Eval("IsActive") %>'
                                CssClass='btn btn-sm <%# Convert.ToBoolean(Eval("IsActive")) ? "btn-warning" : "btn-success" %>'
                                Text='<%# Convert.ToBoolean(Eval("IsActive")) ? "Deactivate" : "Activate" %>' />
                            <asp:Button ID="btnDelete" runat="server" 
                                CommandName="Delete" 
                                CommandArgument='<%# Eval("UserID") %>'
                                CssClass="btn btn-sm btn-danger"
                                Text="Delete"
                                OnClientClick="return confirm('Are you sure you want to delete this user?');" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
    
</asp:Content>