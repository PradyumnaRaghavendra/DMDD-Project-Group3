<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sales.aspx.cs" Inherits="P4CApp.Sales" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Sales CRUD</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg-light">
    <form id="form1" runat="server" class="container py-4">
        <h2 class="mb-4">Sales CRUD Operations</h2>
        <div class="mb-3 d-flex justify-content-end">
  <asp:Button ID="btnHome" runat="server" Text="HOME"
              CssClass="btn btn-primary"
              OnClick="btnHome_Click" />
</div>

        <!-- Sales Grid -->
        <div class="table-responsive shadow-sm rounded mb-5">
            <asp:GridView ID="gvSales" runat="server" AutoGenerateColumns="False" DataKeyNames="SaleID"
                OnRowEditing="gvSales_RowEditing"
                OnRowUpdating="gvSales_RowUpdating"
                OnRowCancelingEdit="gvSales_RowCancelingEdit"
                OnRowDeleting="gvSales_RowDeleting"
                CssClass="table table-striped table-hover align-middle mb-0"
                HeaderStyle-CssClass="table-dark text-white">
                <Columns>
                    <%-- Sale ID --%>
                    <asp:BoundField DataField="SaleID" HeaderText="Sale ID" ReadOnly="True" InsertVisible="False" 
                        ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
                    
                    <%-- Customer ID --%>
                    <asp:TemplateField HeaderText="Customer ID">
                        <ItemTemplate>
                            <%# Eval("CustomerID") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditCustomerID" runat="server" 
                                Text='<%# Bind("CustomerID") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    
                    <%-- Total Amount --%>
                    <asp:TemplateField HeaderText="Total Amount">
                        <ItemTemplate>
                            <%# String.Format("{0:C}", Eval("TotalAmount")) %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditTotalAmount" runat="server" 
                                Text='<%# Bind("TotalAmount") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    
                    <%-- Invoice Number --%>
                    <asp:TemplateField HeaderText="Invoice Number">
                        <ItemTemplate>
                            <%# Eval("InvoiceNumber") %>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditInvoiceNumber" runat="server" 
                                Text='<%# Bind("InvoiceNumber") %>' CssClass="form-control" />
                        </EditItemTemplate>
                    </asp:TemplateField>
                    
                    <%-- Sale Date --%>
                    <asp:BoundField DataField="SaleDate" HeaderText="Sale Date" DataFormatString="{0:MM/dd/yyyy}" ReadOnly="True" 
                        ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
                    
                    <%-- Actions --%>
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit"
                                CssClass="btn btn-sm btn-outline-light me-1" ToolTip="Edit">
                                <i class="bi bi-pencil text-secondary"></i>
                            </asp:LinkButton>
                            <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete"
                                CssClass="btn btn-sm btn-outline-light"
                                OnClientClick="return confirm('Delete this sale?');"
                                ToolTip="Delete">
                                <i class="bi bi-trash text-danger"></i>
                            </asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="Update"
                                CssClass="btn btn-sm btn-outline-light me-1" ToolTip="Save">
                                <i class="bi bi-check2 text-success"></i>
                            </asp:LinkButton>
                            <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel"
                                CssClass="btn btn-sm btn-outline-light" ToolTip="Cancel">
                                <i class="bi bi-x text-danger"></i>
                            </asp:LinkButton>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    
                </Columns>
            </asp:GridView>
        </div>
        
        <!-- Add New Sale Panel -->
        <h3 class="mb-3">Add New Sale</h3>
        <div class="card p-3">
            <div class="mb-3">
                <asp:Label ID="lblSaleID" runat="server" Text="Sale ID:" CssClass="form-label" />
                <asp:TextBox ID="txtSaleID" runat="server" ReadOnly="True" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <asp:Label ID="lblCustomerID" runat="server" Text="Customer ID:" CssClass="form-label" />
                <asp:TextBox ID="txtCustomerID" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <asp:Label ID="lblTotalAmount" runat="server" Text="Total Amount:" CssClass="form-label" />
                <asp:TextBox ID="txtTotalAmount" runat="server" CssClass="form-control" />
            </div>
            <div class="mb-3">
                <asp:Label ID="lblInvoiceNumber" runat="server" Text="Invoice Number:" CssClass="form-label" />
                <asp:TextBox ID="txtInvoiceNumber" runat="server" CssClass="form-control" />
            </div>
            <div>
                <asp:Button ID="btnAdd" runat="server" Text="Add Sale"
                    OnClick="btnAdd_Click" CssClass="btn btn-primary me-2" />
                <asp:Button ID="btnClear" runat="server" Text="Clear"
                    OnClick="btnClear_Click" CssClass="btn btn-secondary" />
            </div>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </form>
</body>
</html>
