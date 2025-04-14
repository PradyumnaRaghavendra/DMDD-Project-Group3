<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Customers.aspx.cs" Inherits="P4CApp.Customers" %>
<!DOCTYPE html>
<html>
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Manage Customers</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg-light">
  <form id="form1" runat="server" class="container py-4">
    <h2 class="mb-4">Manage Customers</h2>

    <!-- Removed Error Label -->
      <div class="mb-3 d-flex justify-content-end">
  <asp:Button ID="btnHome" runat="server" Text="HOME"
              CssClass="btn btn-primary"
              OnClick="btnHome_Click" />
</div>

    <!-- Customers Grid -->
    <div class="table-responsive shadow-sm rounded mb-5">
      <asp:GridView ID="gvCustomers" runat="server" AutoGenerateColumns="False"
          DataKeyNames="CustomerID"
          OnRowEditing="gvCustomers_RowEditing"
          OnRowUpdating="gvCustomers_RowUpdating"
          OnRowCancelingEdit="gvCustomers_RowCancelingEdit"
          OnRowDeleting="gvCustomers_RowDeleting"
          CssClass="table table-striped table-hover align-middle mb-0"
          HeaderStyle-CssClass="table-dark text-white">
        <Columns>
          <%-- CustomerID --%>
          <asp:BoundField DataField="CustomerID"
                          HeaderText="ID"
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

          <%-- Email (decrypted) --%>
          <asp:TemplateField HeaderText="Email">
            <ItemTemplate>
              <span><%# Eval("Email") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditEmail" runat="server"
                           Text='<%# Bind("Email") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>

          <%-- Purchase History --%>
          <asp:TemplateField HeaderText="Purchase History">
            <ItemTemplate>
              <div class="text-truncate" style="max-width:200px;">
                <%# Eval("PurchaseHistory") %>
              </div>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditHistory" runat="server"
                           Text='<%# Bind("PurchaseHistory") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>

          <%-- Loyalty Points --%>
          <asp:TemplateField HeaderText="Loyalty Points">
            <ItemTemplate>
              <span><%# Eval("LoyaltyPoints") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditPoints" runat="server"
                           Text='<%# Bind("LoyaltyPoints") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>

          <%-- Actions (pencil & bin icons) --%>
          <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
              <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit"
                  CssClass="btn btn-sm btn-outline-light me-1" ToolTip="Edit">
                <i class="bi bi-pencil text-secondary"></i>
              </asp:LinkButton>
              <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete"
                  CssClass="btn btn-sm btn-outline-light"
                  OnClientClick="return confirm('Delete this customer?');"
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

    <!-- Add New Customer Panel -->
    <h3 class="mb-3">Add New Customer</h3>
    <div class="card p-3">
      <div class="mb-3">
        <asp:Label ID="lblCustomerID" runat="server" Text="Customer ID:" CssClass="form-label" />
        <asp:TextBox ID="txtCustomerID" runat="server" ReadOnly="True" CssClass="form-control" />
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
        <asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="form-label" />
        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label ID="lblPurchaseHistory" runat="server" Text="Purchase History:" CssClass="form-label" />
        <asp:TextBox ID="txtPurchaseHistory" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label ID="lblLoyaltyPoints" runat="server" Text="Loyalty Points:" CssClass="form-label" />
        <asp:TextBox ID="txtLoyaltyPoints" runat="server" CssClass="form-control" />
      </div>
      <div>
        <asp:Button ID="btnAdd" runat="server" Text="Add Customer"
                    OnClick="btnAdd_Click" CssClass="btn btn-primary me-2" />
        <asp:Button ID="btnClear" runat="server" Text="Clear"
                    OnClick="btnClear_Click" CssClass="btn btn-secondary" />
      </div>
    </div>
  </form>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
