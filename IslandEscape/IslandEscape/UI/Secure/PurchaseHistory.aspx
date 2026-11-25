<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="PurchaseHistory.aspx.cs" Inherits="IslandEscape.UI.Secure.PurchaseHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <h2 class="mb-4"><i class="bi bi-clock-history"></i> Purchase History</h2>
        
        <asp:Label ID="lblMessage" runat="server" CssClass="alert alert-dismissible fade show alert-info w-100" Visible="false">
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            <asp:Literal ID="litMessage" runat="server"></asp:Literal>
        </asp:Label>
        
        <div class="card shadow">
            <div class="card-body">
                <div class="table-responsive">
                    <asp:GridView ID="gvBookings" runat="server" CssClass="table table-striped" 
                        AutoGenerateColumns="false" EmptyDataText="No purchases found in the last 3 months.">
                        <Columns>
                            <asp:BoundField DataField="BookingNumber" HeaderText="Booking #" />
                            <asp:BoundField DataField="PackageName" HeaderText="Package" />
                            <asp:BoundField DataField="BookingDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                            <asp:BoundField DataField="NumPersons" HeaderText="Persons" />
                            <asp:BoundField DataField="TotalAmount" HeaderText="Total" DataFormatString="{0:N0} MUR" />
                            <asp:BoundField DataField="Status" HeaderText="Status" />
                            <asp:TemplateField HeaderText="Actions">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lnkDownload" runat="server" 
                                        CommandArgument='<%# Eval("BookingID") %>'
                                        OnClick="lnkDownload_Click" 
                                        CssClass="btn btn-sm btn-primary">
                                        <i class="bi bi-download"></i> PDF
                                    </asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </div>
            </div>
        </div>
        
        <div class="mt-3">
            <a href="~/UI/Public/Default.aspx" class="btn btn-secondary" runat="server"><i class="bi bi-arrow-left"></i> Back to Home</a>
        </div>
    </div>
    
</asp:Content>