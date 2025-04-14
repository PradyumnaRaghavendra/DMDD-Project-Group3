<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Suppliers.aspx.cs" Inherits="P4CApp.Suppliers" %>
<!DOCTYPE html>
<html>
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Manage Suppliers</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg-light">
  <form id="form1" runat="server" class="container py-4">
    <h2 class="mb-4">Manage Suppliers</h2>

    <!-- Home Button -->
    <div class="mb-3 d-flex justify-content-end">
      <asp:Button ID="btnHome" runat="server" Text="HOME"
                  CssClass="btn btn-primary"
                  OnClick="btnHome_Click" />
    </div>

    <!-- Suppliers Grid -->
    <div class="table-responsive shadow-sm rounded mb-5">
      <asp:GridView ID="gvSuppliers" runat="server" AutoGenerateColumns="False"
          DataKeyNames="SupplierID"
          OnRowEditing="gvSuppliers_RowEditing"
          OnRowUpdating="gvSuppliers_RowUpdating"
          OnRowCancelingEdit="gvSuppliers_RowCancelingEdit"
          OnRowDeleting="gvSuppliers_RowDeleting"
          CssClass="table table-striped table-hover align-middle mb-0"
          HeaderStyle-CssClass="table-dark text-white">
        <Columns>
          <%-- SupplierID --%>
          <asp:BoundField DataField="SupplierID"
                          HeaderText="Supplier ID"
                          ReadOnly="True"
                          ItemStyle-CssClass="text-center"
                          HeaderStyle-CssClass="text-center" />

          <%-- Name --%>
          <asp:TemplateField HeaderText="Name">
            <ItemTemplate>
              <span class="fw-semibold"><%# Eval("Name") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditName" runat="server"
                           Text='<%# Bind("Name") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>

          <%-- Contact --%>
          <asp:TemplateField HeaderText="Contact">
            <ItemTemplate>
              <span class="text-muted"><%# Eval("Contact") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditContact" runat="server"
                           Text='<%# Bind("Contact") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>

          <%-- Address --%>
          <asp:TemplateField HeaderText="Address">
            <ItemTemplate>
              <div class="text-truncate" style="max-width:250px;">
                <%# Eval("Address") %>
              </div>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditAddress" runat="server"
                           Text='<%# Bind("Address") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>

          <%-- Products Supplied --%>
          <asp:TemplateField HeaderText="Products Supplied">
            <ItemTemplate>
              <span class="badge bg-primary"><%# Eval("ProductSupplied") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditProductSupplied" runat="server"
                           Text='<%# Bind("ProductSupplied") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>

          <%-- Actions --%>
          <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
              <!-- Edit -->
              <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit"
                  CssClass="btn btn-sm btn-outline-light me-1" ToolTip="Edit">
                <i class="bi bi-pencil text-secondary"></i>
              </asp:LinkButton>
              <!-- Delete -->
              <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete"
                  CssClass="btn btn-sm btn-outline-light"
                  OnClientClick="return confirm('Delete this supplier?');"
                  ToolTip="Delete">
                <i class="bi bi-trash text-danger"></i>
              </asp:LinkButton>
            </ItemTemplate>
            <EditItemTemplate>
              <!-- Update -->
              <asp:LinkButton ID="lnkUpdate" runat="server" CommandName="Update"
                  CssClass="btn btn-sm btn-outline-light me-1" ToolTip="Save">
                <i class="bi bi-check2 text-success"></i>
              </asp:LinkButton>
              <!-- Cancel -->
              <asp:LinkButton ID="lnkCancel" runat="server" CommandName="Cancel"
                  CssClass="btn btn-sm btn-outline-light" ToolTip="Cancel">
                <i class="bi bi-x text-danger"></i>
              </asp:LinkButton>
            </EditItemTemplate>
          </asp:TemplateField>
        </Columns>
      </asp:GridView>
    </div>

    <!-- Add New Supplier Panel -->
    <h3 class="mb-3">Add New Supplier</h3>
    <div class="card p-3">
      <div class="mb-3">
        <asp:Label ID="lblSupplierID" runat="server" Text="Supplier ID:" CssClass="form-label" />
        <asp:TextBox ID="txtSupplierID" runat="server" ReadOnly="True" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label ID="lblName" runat="server" Text="Name:" CssClass="form-label" />
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label ID="lblContact" runat="server" Text="Contact:" CssClass="form-label" />
        <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label ID="lblAddress" runat="server" Text="Address:" CssClass="form-label" />
        <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label ID="lblProductSupplied" runat="server" Text="Product Supplied:" CssClass="form-label" />
        <asp:TextBox ID="txtProductSupplied" runat="server" CssClass="form-control" />
      </div>
      <div>
        <asp:Button ID="btnAdd" runat="server" Text="Add Supplier"
                    OnClick="btnAdd_Click" CssClass="btn btn-primary me-2" />
        <asp:Button ID="btnClear" runat="server" Text="Clear"
                    OnClick="btnClear_Click" CssClass="btn btn-secondary" />
      </div>
    </div>
  </form>

  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
