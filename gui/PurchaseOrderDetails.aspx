<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="PurchaseOrderDetails.aspx.cs" Inherits="P4CApp.PurchaseOrderDetails" %>
<!DOCTYPE html>
<html>
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Purchase Order Details CRUD</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg-light">
  <form id="form1" runat="server" class="container py-4">
    <!-- Heading -->
    <h2 class="mb-4 text-center">Purchase Order Details CRUD Operations</h2>
    
    <!-- Home Button -->
    <div class="mb-3 d-flex justify-content-end">
      <asp:Button ID="btnHome" runat="server" Text="HOME" CssClass="btn btn-primary" OnClick="btnHome_Click" />
    </div>
    
    <!-- Purchase Order Details Grid -->
    <div class="table-responsive shadow-sm rounded mb-5">
      <asp:GridView ID="gvPurchaseOrderDetails" runat="server" AutoGenerateColumns="False"
          DataKeyNames="OrderID,ProductID"
          OnRowEditing="gvPurchaseOrderDetails_RowEditing"
          OnRowUpdating="gvPurchaseOrderDetails_RowUpdating"
          OnRowCancelingEdit="gvPurchaseOrderDetails_RowCancelingEdit"
          OnRowDeleting="gvPurchaseOrderDetails_RowDeleting"
          CssClass="table table-striped table-hover align-middle mb-0"
          HeaderStyle-CssClass="table-dark text-white">
        <Columns>
          <%-- Order ID (read-only) --%>
          <asp:TemplateField HeaderText="Order ID">
            <ItemTemplate>
              <span class="d-block text-center"><%# Eval("OrderID") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditOrderID" runat="server" Text='<%# Bind("OrderID") %>'
                           CssClass="form-control" ReadOnly="True" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Product ID (read-only) --%>
          <asp:TemplateField HeaderText="Product ID">
            <ItemTemplate>
              <span class="d-block text-center"><%# Eval("ProductID") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditProductID" runat="server" Text='<%# Bind("ProductID") %>'
                           CssClass="form-control" ReadOnly="True" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Quantity Ordered (editable) --%>
          <asp:TemplateField HeaderText="Quantity Ordered">
            <ItemTemplate>
              <span class="d-block text-center"><%# Eval("QuantityOrdered") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditQuantityOrdered" runat="server" Text='<%# Bind("QuantityOrdered") %>'
                           CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Price Per Unit (editable) --%>
          <asp:TemplateField HeaderText="Price Per Unit">
            <ItemTemplate>
              <span class="d-block text-center"><%# String.Format("{0:C}", Eval("PricePerUnit")) %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditPricePerUnit" runat="server" Text='<%# Bind("PricePerUnit") %>'
                           CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Actions --%>
          <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
              <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit"
                  CssClass="btn btn-sm btn-outline-light me-1" ToolTip="Edit">
                <i class="bi bi-pencil text-secondary"></i>
              </asp:LinkButton>
              <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete"
                  CssClass="btn btn-sm btn-outline-light"
                  OnClientClick="return confirm('Delete this record?');" ToolTip="Delete">
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
    
    <!-- Add New Purchase Order Detail Panel -->
    <h3 class="mb-3">Add New Purchase Order Detail</h3>
    <div class="card p-3">
      <div class="mb-3">
         <asp:Label ID="lblOrderID" runat="server" Text="Order ID:" CssClass="form-label" />
         <asp:TextBox ID="txtOrderID" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
         <asp:Label ID="lblProductID" runat="server" Text="Product ID:" CssClass="form-label" />
         <asp:TextBox ID="txtProductID" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
         <asp:Label ID="lblQuantityOrdered" runat="server" Text="Quantity Ordered:" CssClass="form-label" />
         <asp:TextBox ID="txtQuantityOrdered" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
         <asp:Label ID="lblPricePerUnit" runat="server" Text="Price Per Unit:" CssClass="form-label" />
         <asp:TextBox ID="txtPricePerUnit" runat="server" CssClass="form-control" />
      </div>
      <div>
         <asp:Button ID="btnAdd" runat="server" Text="Add Purchase Order Detail" OnClick="btnAdd_Click" CssClass="btn btn-primary me-2" />
         <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" CssClass="btn btn-secondary" />
      </div>
    </div>
    
  </form>
  
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
