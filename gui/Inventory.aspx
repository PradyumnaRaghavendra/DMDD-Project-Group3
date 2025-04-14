<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Inventory.aspx.cs" Inherits="P4CApp.Inventory" %>
<!DOCTYPE html>
<html>
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Inventory CRUD</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Bootstrap Icons (if needed) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg-light">
  <form id="form1" runat="server" class="container py-4">
    <h2 class="mb-4">Inventory CRUD Operations</h2>
    <div class="mb-3 d-flex justify-content-end">
  <asp:Button ID="btnHome" runat="server" Text="HOME"
              CssClass="btn btn-primary"
              OnClick="btnHome_Click" />
</div>

    <!-- Inventory Grid -->
    <div class="table-responsive shadow-sm rounded mb-5">
      <asp:GridView ID="gvInventory" runat="server" AutoGenerateColumns="False" DataKeyNames="InventoryID"
          OnRowEditing="gvInventory_RowEditing"
          OnRowUpdating="gvInventory_RowUpdating"
          OnRowCancelingEdit="gvInventory_RowCancelingEdit"
          OnRowDeleting="gvInventory_RowDeleting"
          CssClass="table table-striped table-hover align-middle mb-0"
          HeaderStyle-CssClass="table-dark text-white">
        <Columns>
          <%-- Inventory ID --%>
          <asp:TemplateField HeaderText="Inventory ID">
            <ItemTemplate>
              <span class="d-block text-center"><%# Eval("InventoryID") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditInventoryID" runat="server" Text='<%# Bind("InventoryID") %>'
                           CssClass="form-control" ReadOnly="True" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Product ID --%>
          <asp:TemplateField HeaderText="Product ID">
            <ItemTemplate>
              <span class="d-block text-center"><%# Eval("ProductID") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditProductID" runat="server" Text='<%# Bind("ProductID") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Stock Level --%>
          <asp:TemplateField HeaderText="Stock Level">
            <ItemTemplate>
              <span class="d-block text-center"><%# Eval("StockLevel") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditStockLevel" runat="server" Text='<%# Bind("StockLevel") %>' CssClass="form-control" />
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
    
    <!-- Add New Inventory Record Panel -->
    <h3 class="mb-3">Add New Inventory Record</h3>
    <div class="card p-3">
      <div class="mb-3">
         <asp:Label ID="lblInventoryID" runat="server" Text="Inventory ID:" CssClass="form-label" />
         <asp:TextBox ID="txtInventoryID" runat="server" ReadOnly="True" CssClass="form-control" />
      </div>
      <div class="mb-3">
         <asp:Label ID="lblProductID" runat="server" Text="Product ID:" CssClass="form-label" />
         <asp:TextBox ID="txtProductID" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
         <asp:Label ID="lblStockLevel" runat="server" Text="Stock Level:" CssClass="form-label" />
         <asp:TextBox ID="txtStockLevel" runat="server" CssClass="form-control" />
      </div>
      <div>
         <asp:Button ID="btnAdd" runat="server" Text="Add Inventory" OnClick="btnAdd_Click" CssClass="btn btn-primary me-2" />
         <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" CssClass="btn btn-secondary" />
      </div>
    </div>
    
  </form>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
