<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="MyQueries.aspx.cs" Inherits="IslandEscape.UI.Secure.MyQueries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <h2><i class="bi bi-envelope"></i> My Queries</h2>
        
        <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-info" Visible="false"></asp:Label>
        
        <div class="card shadow">
            <div class="card-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvQueries" runat="server" CssClass="table table-striped" 
                        AutoGenerateColumns="false" EmptyDataText="You have not submitted any queries.">
                        <Columns>
                            <asp:BoundField DataField="QueryID" HeaderText="ID" />
                            <asp:BoundField DataField="Subject" HeaderText="Subject" />
                            <asp:BoundField DataField="Message" HeaderText="Message" />
                            <asp:BoundField DataField="SubmittedDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy HH:mm}" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:TemplateField HeaderText="Reply">
                                <ItemTemplate>
                                    <%# Eval("AdminReply") != DBNull.Value ? Eval("AdminReply").ToString() : "No reply yet" %>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        
        <div class="mt-3">
            <a href="Profile.aspx" class="btn btn-secondary"><i class="bi bi-arrow-left"></i> Back to Profile</a>
        </div>
    </div>
    
</asp:Content>