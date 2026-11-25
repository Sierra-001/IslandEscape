<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="IslandEscape.UI.Admin.Reports" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
    <div class="row mb-4">
        <div class="col-md-12">
            <h4><i class="bi bi-bar-chart"></i> Reports & Analytics</h4>
            <p class="text-muted">Overview of bookings, revenue, and top performing packages</p>
        </div>
    </div>

    <div class="row mb-4">
        <div class="col-md-3">
            <div class="stat-card">
                <div class="icon"><i class="bi bi-calendar-check"></i></div>
                <div class="number"><asp:Label ID="lblTotalBookings" runat="server">0</asp:Label></div>
                <div class="label">Total Bookings</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="icon"><i class="bi bi-currency-dollar"></i></div>
                <div class="number"><asp:Label ID="lblTotalRevenue" runat="server">0 MUR</asp:Label></div>
                <div class="label">Total Revenue</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="icon"><i class="bi bi-people"></i></div>
                <div class="number"><asp:Label ID="lblTotalCustomers" runat="server">0</asp:Label></div>
                <div class="label">Total Customers</div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="stat-card">
                <div class="icon"><i class="bi bi-box"></i></div>
                <div class="number"><asp:Label ID="lblTotalPackages" runat="server">0</asp:Label></div>
                <div class="label">Total Packages</div>
            </div>
        </div>
    </div>

<div class="row mb-4">
    <div class="col-md-12">
        <div class="admin-card">
            <h5 class="card-title"><i class="bi bi-pie-chart"></i> Booking Status Breakdown</h5>
            <div class="row">
                <div class="col-md-3">
                    <div class="status-card status-pending">
                        <div class="status-number"><asp:Label ID="lblPending" runat="server">0</asp:Label></div>
                        <div class="status-label">Pending</div>
                        <div class="status-bar">
                            <div class="bar" style="width:0%;"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="status-card status-confirmed">
                        <div class="status-number"><asp:Label ID="lblConfirmed" runat="server">0</asp:Label></div>
                        <div class="status-label">Confirmed</div>
                        <div class="status-bar">
                            <div class="bar" style="width:0%;"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="status-card status-completed">
                        <div class="status-number"><asp:Label ID="lblCompleted" runat="server">0</asp:Label></div>
                        <div class="status-label">Completed</div>
                        <div class="status-bar">
                            <div class="bar" style="width:0%;"></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="status-card status-cancelled">
                        <div class="status-number"><asp:Label ID="lblCancelled" runat="server">0</asp:Label></div>
                        <div class="status-label">Cancelled</div>
                        <div class="status-bar">
                            <div class="bar" style="width:0%;"></div>
                        </div>
                    </div>
                </div>
            </div>
            <asp:Label ID="lblStatusEmpty" runat="server" CssClass="text-muted text-center d-block py-3" 
                Text="No bookings yet. Status breakdown will appear once bookings are made." Visible="false" />
        </div>
    </div>
</div>

    <div class="row">
        <div class="col-md-6">
            <div class="admin-card">
                <h5 class="card-title"><i class="bi bi-currency-dollar"></i> Revenue Summary (All Statuses)</h5>
                <div class="table-responsive">
                    <asp:PlaceHolder ID="phRevenueSummary" runat="server" Visible="false">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>Month</th>
                                    <th>Bookings</th>
                                    <th>Revenue</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptRevenueSummary" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("Month") %></td>
                                            <td><%# Eval("TotalBookings") %></td>
                                            <td><%# Eval("TotalRevenue", "{0:N0}") %> MUR</td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </asp:PlaceHolder>
                    <asp:Label ID="lblRevenueEmpty" runat="server" CssClass="text-muted text-center d-block py-3" 
                        Text="No booking data available yet. Revenue summary will appear once bookings are made." Visible="false" />
                </div>
            </div>
        </div>
        
        <div class="col-md-6">
            <div class="admin-card">
                <h5 class="card-title"><i class="bi bi-trophy"></i> Top Packages</h5>
                <div class="table-responsive">
                    <asp:PlaceHolder ID="phTopPackages" runat="server" Visible="false">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>Package</th>
                                    <th>Bookings</th>
                                    <th>Revenue</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptTopPackages" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("PackageName") %></td>
                                            <td><%# Eval("TotalBookings") %></td>
                                            <td><%# Eval("TotalRevenue", "{0:N0}") %> MUR</td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </asp:PlaceHolder>
                    <asp:Label ID="lblTopEmpty" runat="server" CssClass="text-muted text-center d-block py-3" 
                        Text="No package bookings yet. Top packages will appear once bookings are made." Visible="false" />
                </div>
            </div>
        </div>
    </div>
    
    <div class="row mt-3">
        <div class="col-md-12">
            <div class="admin-card">
                <h5 class="card-title"><i class="bi bi-clock"></i> Recent Bookings</h5>
                <div class="table-responsive">
                    <asp:PlaceHolder ID="phActivity" runat="server" Visible="false">
                        <table class="admin-table">
                            <thead>
                                <tr>
                                    <th>Date/Time</th>
                                    <th>Booking #</th>
                                    <th>Package</th>
                                    <th>Customer</th>
                                    <th>Amount</th>
                                    <th>Status</th>
                                </tr>
                            </thead>
                            <tbody>
                                <asp:Repeater ID="rptActivity" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("Timestamp", "{0:dd MMM yyyy HH:mm}") %></td>
                                            <td><%# Eval("BookingNumber") %></td>
                                            <td><%# Eval("PackageName") %></td>
                                            <td><%# Eval("CustomerName") %></td>
                                            <td><%# Eval("TotalAmount", "{0:N0}") %> MUR</td>
                                            <td>
                                                <span class='badge <%# GetStatusBadge(Eval("Status").ToString()) %>'>
                                                    <%# Eval("Status") %>
                                                </span>
                                            </td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </asp:PlaceHolder>
                    <asp:Label ID="lblActivityEmpty" runat="server" CssClass="text-muted text-center d-block py-3" 
                        Text="No recent booking activity." Visible="false" />
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
    $(document).ready(function() {
        var pending = parseInt($('#<%= lblPending.ClientID %>').text()) || 0;
        var confirmed = parseInt($('#<%= lblConfirmed.ClientID %>').text()) || 0;
        var completed = parseInt($('#<%= lblCompleted.ClientID %>').text()) || 0;
        var cancelled = parseInt($('#<%= lblCancelled.ClientID %>').text()) || 0;
        var total = pending + confirmed + completed + cancelled;
        if (total > 0) {
            $('#pendingBar').css('width', (pending / total * 100) + '%');
            $('#confirmedBar').css('width', (confirmed / total * 100) + '%');
            $('#completedBar').css('width', (completed / total * 100) + '%');
            $('#cancelledBar').css('width', (cancelled / total * 100) + '%');
        } else {
        }
    });
    </script>
</asp:Content>