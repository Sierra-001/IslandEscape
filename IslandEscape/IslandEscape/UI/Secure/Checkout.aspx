<%@ Page Title="" Language="C#" MasterPageFile="~/UI/MasterPages/Site.Master" AutoEventWireup="true" CodeBehind="Checkout.aspx.cs" Inherits="IslandEscape.UI.Secure.Checkout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <div class="container mt-4">
        <h2 class="mb-4"><i class="bi bi-credit-card"></i> Checkout</h2>
        
        <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger w-100" Visible="false"></asp:Label>
        
        <div class="row">
            <div class="col-md-5 order-md-2">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Order Summary</h5>
                    </div>
                    <div class="card-body">
                        <asp:Repeater ID="rptCartItems" runat="server">
                            <ItemTemplate>
                                <div class="d-flex justify-content-between mb-2">
                                    <span><%# Eval("PackageName") %> x <%# Eval("Quantity") %></span>
                                    <span><%# Convert.ToDecimal(Eval("Price")) * Convert.ToInt32(Eval("Quantity")) %></span>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
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
                    </div>
                </div>
            </div>
            
            <div class="col-md-7 order-md-1">
                <div class="card shadow">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0"><i class="bi bi-lock"></i> Payment Details</h5>
                    </div>
                    <div class="card-body">
                        
                        <div class="mb-3">
                            <label class="form-label">Payment Method</label>
                            <asp:DropDownList ID="ddlPaymentMethod" runat="server" CssClass="form-select" OnChange="togglePaymentPanels();">
                                <asp:ListItem Text="Credit Card" Value="CreditCard" Selected="True" />
                                <asp:ListItem Text="Debit Card" Value="DebitCard" />
                                <asp:ListItem Text="Bank Transfer" Value="BankTransfer" />
                            </asp:DropDownList>
                        </div>
                        
                        <div id="divCreditCard" style="display:block;">
                            <div class="mb-3">
                                <label class="form-label">Card Number</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-credit-card"></i></span>
                                    <asp:TextBox ID="txtCardNumber" runat="server" CssClass="form-control" 
                                        placeholder="1234 5678 9012 3456" MaxLength="19" />
                                </div>
                                <asp:RequiredFieldValidator ID="rfvCardNumber" runat="server" 
                                    ControlToValidate="txtCardNumber" ErrorMessage="Card number is required" 
                                    CssClass="validation-error" Display="Dynamic" />
                                <asp:RegularExpressionValidator ID="revCardNumber" runat="server"
                                    ControlToValidate="txtCardNumber"
                                    ValidationExpression="^\d{4}\s?\d{4}\s?\d{4}\s?\d{4}$"
                                    ErrorMessage="Please enter a valid 16-digit card number"
                                    CssClass="validation-error" Display="Dynamic" />
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Expiry Date</label>
                                    <asp:TextBox ID="txtExpiry" runat="server" CssClass="form-control" 
                                        placeholder="MM/YY" MaxLength="5" />
                                    <asp:RequiredFieldValidator ID="rfvExpiry" runat="server" 
                                        ControlToValidate="txtExpiry" ErrorMessage="Expiry date is required" 
                                        CssClass="validation-error" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revExpiry" runat="server"
                                        ControlToValidate="txtExpiry"
                                        ValidationExpression="^(0[1-9]|1[0-2])\/([0-9]{2})$"
                                        ErrorMessage="Please enter a valid expiry date (MM/YY)"
                                        CssClass="validation-error" Display="Dynamic" />
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">CVV</label>
                                    <asp:TextBox ID="txtCVV" runat="server" CssClass="form-control" 
                                        placeholder="123" MaxLength="4" TextMode="Password" />
                                    <asp:RequiredFieldValidator ID="rfvCVV" runat="server" 
                                        ControlToValidate="txtCVV" ErrorMessage="CVV is required" 
                                        CssClass="validation-error" Display="Dynamic" />
                                    <asp:RegularExpressionValidator ID="revCVV" runat="server"
                                        ControlToValidate="txtCVV"
                                        ValidationExpression="^\d{3,4}$"
                                        ErrorMessage="Please enter a valid 3 or 4 digit CVV"
                                        CssClass="validation-error" Display="Dynamic" />
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Cardholder Name</label>
                                <asp:TextBox ID="txtCardholderName" runat="server" CssClass="form-control" 
                                    placeholder="Name on card" />
                                <asp:RequiredFieldValidator ID="rfvCardholderName" runat="server" 
                                    ControlToValidate="txtCardholderName" ErrorMessage="Cardholder name is required" 
                                    CssClass="validation-error" Display="Dynamic" />
                            </div>
                        </div>
                        
                        <div id="divBankTransfer" style="display:none;">
                            <div class="alert alert-info">
                                <i class="bi bi-info-circle"></i> After placing your order, you will receive bank transfer details via email.
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Bank Name</label>
                                <asp:TextBox ID="txtBankName" runat="server" CssClass="form-control" placeholder="e.g., State Bank of Mauritius" />
                                <asp:RequiredFieldValidator ID="rfvBankName" runat="server" 
                                    ControlToValidate="txtBankName" ErrorMessage="Bank name is required" 
                                    CssClass="validation-error" Display="Dynamic" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Account Number</label>
                                <asp:TextBox ID="txtAccountNumber" runat="server" CssClass="form-control" placeholder="Enter account number" />
                                <asp:RequiredFieldValidator ID="rfvAccountNumber" runat="server" 
                                    ControlToValidate="txtAccountNumber" ErrorMessage="Account number is required" 
                                    CssClass="validation-error" Display="Dynamic" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Branch</label>
                                <asp:TextBox ID="txtBranch" runat="server" CssClass="form-control" placeholder="e.g., Port Louis" />
                                <asp:RequiredFieldValidator ID="rfvBranch" runat="server" 
                                    ControlToValidate="txtBranch" ErrorMessage="Branch is required" 
                                    CssClass="validation-error" Display="Dynamic" />
                            </div>
                            <div class="mb-3">
                                <label class="form-label">Reference / Notes</label>
                                <asp:TextBox ID="txtBankRef" runat="server" CssClass="form-control" placeholder="Optional reference" />
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label">Special Requests</label>
                            <asp:TextBox ID="txtSpecialRequests" runat="server" TextMode="MultiLine" 
                                Rows="3" CssClass="form-control" 
                                placeholder="Any special requests or notes for your booking" />
                        </div>
                        
                        <asp:Button ID="btnPlaceOrder" runat="server" Text="Place Order" 
                            CssClass="btn btn-success w-100 btn-lg" OnClick="btnPlaceOrder_Click" />
                        
                        <div class="mt-3 text-center">
                            <i class="bi bi-shield-lock text-muted"></i>
                            <small class="text-muted">Your payment is secure. We do not store card details.</small>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript">
        function togglePaymentPanels() {
            var sel = document.getElementById('<%= ddlPaymentMethod.ClientID %>');
            var creditDiv = document.getElementById('divCreditCard');
            var bankDiv = document.getElementById('divBankTransfer');

            if (sel.value === 'BankTransfer') {
                creditDiv.style.display = 'none';
                bankDiv.style.display = 'block';
            } else {
                creditDiv.style.display = 'block';
                bankDiv.style.display = 'none';
            }
        }

        window.onload = function () {
            togglePaymentPanels();
        };
    </script>
    
</asp:Content>