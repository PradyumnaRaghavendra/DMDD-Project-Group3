<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="InventoryTransactions.aspx" Inherits="P4CApp.InventoryTransactions" %>
<!DOCTYPE html>
<html>
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Inventory Transactions CRUD</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Bootstrap Icons (if needed) -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg-light">
  <form id="form1" runat="server" class="container py-4">
    <h2 class="mb-4">Inventory Transactions CRUD Operations</h2>
    <div class="mb-3 d-flex justify-content-end">
  <asp:Button ID="btnHome" runat="server" Text="HOME"
              CssClass="btn btn-primary"
              OnClick="btnHome_Click" />
</div>

    <!-- Inventory Transactions Grid -->
    <div class="table-responsive shadow-sm rounded mb-5">
      <asp:GridView ID="gvTransactions" runat="server" AutoGenerateColumns="False" DataKeyNames="TransactionID"
          OnRowEditing="gvTransactions_RowEditing"
          OnRowUpdating="gvTransactions_RowUpdating"
          OnRowCancelingEdit="gvTransactions_RowCancelingEdit"
          OnRowDeleting="gvTransactions_RowDeleting"
          CssClass="table table-striped table-hover align-middle mb-0"
          HeaderStyle-CssClass="table-dark text-white">
        <Columns>
          <%-- Transaction ID --%>
          <asp:TemplateField HeaderText="Transaction ID">
            <ItemTemplate>
              <span class="d-block text-center"><%# Eval("TransactionID") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditTransactionID" runat="server" Text='<%# Bind("TransactionID") %>'
                           CssClass="form-control" ReadOnly="True" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Inventory ID --%>
          <asp:TemplateField HeaderText="Inventory ID">
            <ItemTemplate>
              <span class="d-block text-center"><%# Eval("InventoryID") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditInventoryID" runat="server" Text='<%# Bind("InventoryID") %>'
                           CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Quantity Changed --%>
          <asp:TemplateField HeaderText="Quantity Changed">
            <ItemTemplate>
              <span class="d-block text-center"><%# Eval("QuantityChanged") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditQuantityChanged" runat="server" Text='<%# Bind("QuantityChanged") %>'
                           CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Transaction Date --%>
          <asp:TemplateField HeaderText="Transaction Date">
            <ItemTemplate>
              <span class="d-block text-center"><%# String.Format("{0:MM/dd/yyyy}", Eval("TransactionDate")) %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditTransactionDate" runat="server"
                           Text='<%# Bind("TransactionDate", "{0:MM/dd/yyyy}") %>'
                           CssClass="form-control" ReadOnly="True" />
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
                  CssClass="btn btn-sm btn-outline-light" OnClientClick="return confirm('Delete this transaction?');"
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
    
    <!-- Add New Transaction Panel -->
    <h3 class="mb-3">Add New Transaction</h3>
    <div class="card p-3">
      <div class="mb-3">
         <asp:Label ID="lblTransactionID" runat="server" Text="Transaction ID:" CssClass="form-label" />
         <asp:TextBox ID="txtTransactionID" runat="server" ReadOnly="True" CssClass="form-control" />
      </div>
      <div class="mb-3">
         <asp:Label ID="lblInventoryID" runat="server" Text="Inventory ID:" CssClass="form-label" />
         <asp:TextBox ID="txtInventoryID" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
         <asp:Label ID="lblQuantityChanged" runat="server" Text="Quantity Changed:" CssClass="form-label" />
         <asp:TextBox ID="txtQuantityChanged" runat="server" CssClass="form-control" />
      </div>
      <div>
         <asp:Button ID="btnAdd" runat="server" Text="Add Transaction" OnClick="btnAdd_Click" CssClass="btn btn-primary me-2" />
         <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" CssClass="btn btn-secondary" />
      </div>
    </div>
    
  </form>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
