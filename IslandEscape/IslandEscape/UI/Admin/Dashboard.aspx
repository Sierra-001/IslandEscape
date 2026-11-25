<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="IslandEscape.UI.Admin.Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    Dashboard
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="stat-grid">
        <div class="stat-item">
            <div class="icon"><i class="bi bi-box"></i></div>
            <div class="number"><asp:Label ID="lblTotalPackages" runat="server"></asp:Label></div>
            <div class="label">Total Packages</div>
        </div>
        <div class="stat-item">
            <div class="icon"><i class="bi bi-people"></i></div>
            <div class="number"><asp:Label ID="lblTotalUsers" runat="server"></asp:Label></div>
            <div class="label">Total Users</div>
        </div>
        <div class="stat-item">
            <div class="icon"><i class="bi bi-calendar-check"></i></div>
            <div class="number"><asp:Label ID="lblTotalBookings" runat="server"></asp:Label></div>
            <div class="label">Total Bookings</div>
        </div>
        <div class="stat-item">
            <div class="icon"><i class="bi bi-currency-dollar"></i></div>
            <div class="number"><asp:Label ID="lblTotalRevenue" runat="server"></asp:Label></div>
            <div class="label">Total Revenue</div>
        </div>
    </div>
    
    <div class="admin-card">
        <h5 class="card-title"><i class="bi bi-clock-history"></i> Recent Bookings</h5>
        <div class="table-responsive">
            <asp:GridView ID="gvRecentBookings" runat="server" CssClass="admin-table" 
                AutoGenerateColumns="false" EmptyDataText="No bookings found.">
                <Columns>
                    <asp:BoundField DataField="BookingNumber" HeaderText="Booking #" />
                    <asp:BoundField DataField="FullName" HeaderText="Customer" />
                    <asp:BoundField DataField="PackageName" HeaderText="Package" />
                    <asp:BoundField DataField="TotalAmount" HeaderText="Total" DataFormatString="{0:N0} MUR" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:BoundField DataField="BookingDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                </Columns>
            </asp:GridView>
        </div>
    </div>
    
</asp:Content>