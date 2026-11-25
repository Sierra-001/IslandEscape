<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="IslandEscape.UI.Public.Cart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <h2><i class="bi bi-cart"></i> Shopping Cart</h2>
        
        <div id="divEmpty" runat="server" visible="false" class="text-center py-5">
            <i class="bi bi-cart-x" style="font-size: 4rem; color: #ccc;"></i>
            <h3 class="mt-3">Your cart is empty</h3>
            <p class="text-muted">Browse our packages and add your favorites</p>
            <a href="Packages.aspx" class="btn btn-primary">Browse Packages</a>
        </div>
        
        <div id="divCart" runat="server" visible="false">
            <div class="table-responsive">
                <asp:GridView ID="gvCart" runat="server" CssClass="table table-striped" 
                    AutoGenerateColumns="false" DataKeyNames="CartID"
                    OnRowDeleting="gvCart_RowDeleting" OnRowDataBound="gvCart_RowDataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="Package">
                            <ItemTemplate>
                                <div class="d-flex align-items-center">
                                    <img src='<%# "~/Assets/Images/Packages/" + Eval("ImageURL") %>' alt="Package" style="width:60px; height:60px; object-fit:cover; border-radius:4px;" />
                                    <div class="ms-3">
                                        <strong><%# Eval("PackageName") %></strong>
                                        <br />
                                        <small class="text-muted"><%# Eval("Price", "{0:N0}") %> MUR</small>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <asp:TextBox ID="txtQuantity" runat="server" Text='<%# Eval("Quantity") %>' 
                                    Width="60px" CssClass="form-control form-control-sm" 
                                    OnTextChanged="txtQuantity_TextChanged" AutoPostBack="true" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="Price" HeaderText="Price" DataFormatString="{0:N0} MUR" />
                        <asp:TemplateField HeaderText="Total">
                            <ItemTemplate>
                                <%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:CommandField ShowDeleteButton="true" DeleteText="Remove" ButtonType="Button" 
                            ControlStyle-CssClass="btn btn-danger btn-sm" />
                    </Columns>
                </asp:GridView>
            </div>
            
            <div class="row mt-4">
                <div class="col-md-6 offset-md-6">
                    <div class="card">
                        <div class="card-body">
                            <h5>Order Summary</h5>
                            <hr />
                            <div class="d-flex justify-content-between">
                                <span>Subtotal:</span>
                                <span><asp:Label ID="lblSubtotal" runat="server"></asp:Label> MUR</span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span>Tax (15%):</span>
                                <span><asp:Label ID="lblTax" runat="server"></asp:Label> MUR</span>
                            </div>
                            <hr />
                            <div class="d-flex justify-content-between fw-bold">
                                <span>Total:</span>
                                <span><asp:Label ID="lblTotal" runat="server"></asp:Label> MUR</span>
                            </div>
                            <asp:Button ID="btnCheckout" runat="server" Text="Proceed to Checkout" 
                                CssClass="btn btn-success w-100 mt-3" OnClick="btnCheckout_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>