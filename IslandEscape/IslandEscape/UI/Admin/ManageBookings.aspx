<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Admin.Master" AutoEventWireup="true" CodeBehind="ManageBookings.aspx.cs" Inherits="IslandEscape.UI.Admin.ManageBookings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    Manage Bookings
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="admin-card">
        <h5 class="card-title"><i class="bi bi-calendar-check"></i> All Bookings</h5>
        <div class="table-responsive">
            <asp:GridView ID="gvBookings" runat="server" CssClass="admin-table" 
                AutoGenerateColumns="false" DataKeyNames="BookingID"
                OnRowCommand="gvBookings_RowCommand">
                <Columns>
                    <asp:BoundField DataField="BookingNumber" HeaderText="Booking #" />
                    <asp:BoundField DataField="FullName" HeaderText="Customer" />
                    <asp:BoundField DataField="PackageName" HeaderText="Package" />
                    <asp:BoundField DataField="NumPersons" HeaderText="Persons" />
                    <asp:BoundField DataField="TotalAmount" HeaderText="Total" DataFormatString="{0:N0} MUR" />
                    <asp:BoundField DataField="BookingDate" HeaderText="Date" DataFormatString="{0:dd MMM yyyy}" />
                    <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-select form-select-sm" 
                                SelectedValue='<%# Eval("Status") %>'>
                                <asp:ListItem Text="Pending" Value="Pending" />
                                <asp:ListItem Text="Confirmed" Value="Confirmed" />
                                <asp:ListItem Text="Completed" Value="Completed" />
                                <asp:ListItem Text="Cancelled" Value="Cancelled" />
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:Button ID="btnUpdateStatus" runat="server" 
                                CommandName="UpdateStatus" 
                                CommandArgument='<%# Eval("BookingID") %>'
                                CssClass="btn btn-sm btn-primary"
                                Text="Update" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
    
</asp:Content>