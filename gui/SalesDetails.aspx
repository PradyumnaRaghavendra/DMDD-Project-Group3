<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesDetails.aspx.cs" Inherits="P4CApp.SalesDetails" %>
<!DOCTYPE html>
<html>
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Sales Details CRUD</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg-light">
  <form id="form1" runat="server" class="container py-4">
    <h2 class="mb-4">Sales Details CRUD Operations</h2>

    <!-- Removed Error Label -->
      <div class="mb-3 d-flex justify-content-end">
  <asp:Button ID="btnHome" runat="server" Text="HOME"
              CssClass="btn btn-primary"
              OnClick="btnHome_Click" />
</div>

    <!-- Sales Details Grid -->
    <div class="table-responsive shadow-sm rounded mb-5">
      <asp:GridView ID="gvSalesDetails" runat="server" AutoGenerateColumns="False"
          DataKeyNames="SaleID,ProductID" 
          OnRowEditing="gvSalesDetails_RowEditing"
          OnRowUpdating="gvSalesDetails_RowUpdating"
          OnRowCancelingEdit="gvSalesDetails_RowCancelingEdit"
          OnRowDeleting="gvSalesDetails_RowDeleting"
          CssClass="table table-striped table-hover align-middle mb-0"
          HeaderStyle-CssClass="table-dark text-white">
        <Columns>
          <asp:BoundField DataField="SaleID" HeaderText="Sale ID" ReadOnly="True" 
                          ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
          <asp:BoundField DataField="ProductID" HeaderText="Product ID" ReadOnly="True" 
                          ItemStyle-CssClass="text-center" HeaderStyle-CssClass="text-center" />
          <asp:TemplateField HeaderText="Quantity">
            <ItemTemplate>
              <%# Eval("Quantity") %>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditQuantity" runat="server" 
                           Text='<%# Bind("Quantity") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Subtotal">
            <ItemTemplate>
              <%# String.Format("{0:C}", Eval("Subtotal")) %>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditSubtotal" runat="server" 
                           Text='<%# Bind("Subtotal") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>
          <asp:TemplateField HeaderText="Actions">
            <ItemTemplate>
              <asp:LinkButton ID="lnkEdit" runat="server" CommandName="Edit"
                  CssClass="btn btn-sm btn-outline-light me-1" ToolTip="Edit">
                <i class="bi bi-pencil text-secondary"></i>
              </asp:LinkButton>
              <asp:LinkButton ID="lnkDelete" runat="server" CommandName="Delete"
                  CssClass="btn btn-sm btn-outline-light"
                  OnClientClick="return confirm('Delete this sales detail?');"
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

    <!-- Add New Sales Detail Panel -->
    <h3 class="mb-3">Add New Sales Detail</h3>
    <div class="card p-3">
      <div class="mb-3">
        <asp:Label ID="lblSaleID" runat="server" Text="Sale ID:" CssClass="form-label" />
        <asp:DropDownList ID="ddlSaleID" runat="server" CssClass="form-control"></asp:DropDownList>
      </div>
      <div class="mb-3">
        <asp:Label ID="lblProductID" runat="server" Text="Product ID:" CssClass="form-label" />
        <asp:DropDownList ID="ddlProductID" runat="server" CssClass="form-control"></asp:DropDownList>
      </div>
      <div class="mb-3">
        <asp:Label ID="lblQuantity" runat="server" Text="Quantity:" CssClass="form-label" />
        <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label ID="lblSubtotal" runat="server" Text="Subtotal:" CssClass="form-label" />
        <asp:TextBox ID="txtSubtotal" runat="server" CssClass="form-control" />
      </div>
      <div>
        <asp:Button ID="btnAdd" runat="server" Text="Add Sales Detail" 
                    OnClick="btnAdd_Click" CssClass="btn btn-primary me-2" />
        <asp:Button ID="btnClear" runat="server" Text="Clear" 
                    OnClick="btnClear_Click" CssClass="btn btn-secondary" />
      </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
  </form>
</body>
</html>
