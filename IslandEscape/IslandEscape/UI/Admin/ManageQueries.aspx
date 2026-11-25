<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageQueries.aspx.cs" Inherits="IslandEscape.UI.Admin.ManageQueries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    Manage Queries
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="admin-card">
        <h5 class="card-title"><i class="bi bi-envelope"></i> Customer Queries</h5>
        <div class="table-responsive">
            <asp:GridView ID="gvQueries" runat="server" CssClass="admin-table" 
                AutoGenerateColumns="false" DataKeyNames="QueryID"
                OnRowCommand="gvQueries_RowCommand">
                <Columns>
                    <asp:BoundField DataField="QueryID" HeaderText="ID" />
                    <asp:BoundField DataField="Name" HeaderText="Name" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Subject" HeaderText="Subject" />
                    <asp:BoundField DataField="SubmittedDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <span class='badge <%# Eval("Status").ToString() == "New" ? "badge-danger" : Eval("Status").ToString() == "In Progress" ? "badge-warning" : "badge-success" %>'>
                                <%# Eval("Status") %>
                            </span>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnView" runat="server" 
                                CommandName="View" 
                                CommandArgument='<%# Eval("QueryID") %>'
                                CssClass="btn btn-sm btn-info"
                                Text="View" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
    
    <asp:Panel ID="pnlQueryDetails" runat="server" Visible="false" CssClass="admin-card mt-3">
        <h5 class="card-title"><i class="bi bi-envelope-paper"></i> Query Details</h5>
        <div class="row">
            <div class="col-md-6">
                <p><strong>Name:</strong> <asp:Label ID="lblName" runat="server"></asp:Label></p>
                <p><strong>Email:</strong> <asp:Label ID="lblEmail" runat="server"></asp:Label></p>
                <p><strong>Subject:</strong> <asp:Label ID="lblSubject" runat="server"></asp:Label></p>
                <p><strong>Date:</strong> <asp:Label ID="lblDate" runat="server"></asp:Label></p>
            </div>
            <div class="col-md-6">
                <p><strong>Status:</strong> <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select form-select-sm">
                    <asp:ListItem Text="New" Value="New" />
                    <asp:ListItem Text="In Progress" Value="In Progress" />
                    <asp:ListItem Text="Resolved" Value="Resolved" />
                </asp:DropDownList></p>
                <asp:Button ID="btnUpdateStatus" runat="server" Text="Update Status" CssClass="btn btn-primary btn-sm" OnClick="btnUpdateStatus_Click" />
            </div>
        </div>
        <hr />
        <h6>Message</h6>
        <p><asp:Label ID="lblMessage" runat="server"></asp:Label></p>
        <hr />
        <h6>Reply</h6>
        <asp:TextBox ID="txtReply" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control" placeholder="Enter your reply..." />
        <asp:Button ID="btnSendReply" runat="server" Text="Send Reply" CssClass="btn btn-success mt-2" OnClick="btnSendReply_Click" />
        <asp:Button ID="btnCloseDetails" runat="server" Text="Close" CssClass="btn btn-secondary mt-2 ms-2" OnClick="btnCloseDetails_Click" />
    </asp:Panel>

<div class="modal fade" id="replyModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-success text-white">
                <h5 class="modal-title"><i class="bi bi-check-circle"></i> Reply Sent</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <p><asp:Label ID="lblModalMessage" runat="server"></asp:Label></p>
                <hr />
                <p><strong>Reply:</strong></p>
                <p><asp:Label ID="lblModalReply" runat="server"></asp:Label></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
    
</asp:Content>