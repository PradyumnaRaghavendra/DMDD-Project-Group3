<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SalesEmployee.aspx" Inherits="P4CApp.SalesEmployee" %>
<!DOCTYPE html>
<html>
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Sales Employee CRUD</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg-light">
  <form id="form1" runat="server" class="container py-4">
      <h2 class="mb-4">Sales Employee CRUD Operations</h2>
      <div class="mb-3 d-flex justify-content-end">
  <asp:Button ID="btnHome" runat="server" Text="HOME"
              CssClass="btn btn-primary"
              OnClick="btnHome_Click" />
</div>

      <!-- Sales Employee Grid -->
      <div class="table-responsive shadow-sm rounded mb-5">
          <asp:GridView ID="gvSalesEmployee" runat="server" AutoGenerateColumns="False"
              DataKeyNames="SaleID,EmployeeID"
              OnRowEditing="gvSalesEmployee_RowEditing"
              OnRowUpdating="gvSalesEmployee_RowUpdating"
              OnRowCancelingEdit="gvSalesEmployee_RowCancelingEdit"
              OnRowDeleting="gvSalesEmployee_RowDeleting"
              CssClass="table table-striped table-hover align-middle mb-0"
              HeaderStyle-CssClass="table-dark text-white">
              <Columns>
                  <%-- Sale ID --%>
                  <asp:TemplateField HeaderText="Sale ID">
                      <ItemTemplate>
                          <asp:Label ID="lblSaleID" runat="server" Text='<%# Eval("SaleID") %>' CssClass="d-block text-center" />
                      </ItemTemplate>
                      <EditItemTemplate>
                          <asp:TextBox ID="txtEditSaleID" runat="server" Text='<%# Bind("SaleID") %>' CssClass="form-control" />
                      </EditItemTemplate>
                  </asp:TemplateField>
                  
                  <%-- Employee ID --%>
                  <asp:TemplateField HeaderText="Employee ID">
                      <ItemTemplate>
                          <asp:Label ID="lblEmployeeID" runat="server" Text='<%# Eval("EmployeeID") %>' CssClass="d-block text-center" />
                      </ItemTemplate>
                      <EditItemTemplate>
                          <asp:TextBox ID="txtEditEmployeeID" runat="server" Text='<%# Bind("EmployeeID") %>' CssClass="form-control" />
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
                              OnClientClick="return confirm('Delete this sales employee record?');"
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
      
      <!-- Add New Sales Employee Panel -->
      <h3 class="mb-3">Add New Sales Employee</h3>
      <div class="card p-3">
          <div class="mb-3">
              <asp:Label ID="lblSaleID" runat="server" Text="Sale ID:" CssClass="form-label" />
              <asp:TextBox ID="txtSaleID" runat="server" CssClass="form-control" />
          </div>
          <div class="mb-3">
              <asp:Label ID="lblEmployeeID" runat="server" Text="Employee ID:" CssClass="form-label" />
              <asp:TextBox ID="txtEmployeeID" runat="server" CssClass="form-control" />
          </div>
          <div>
              <asp:Button ID="btnAdd" runat="server" Text="Add Sales Employee" OnClick="btnAdd_Click" CssClass="btn btn-primary me-2" />
              <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" CssClass="btn btn-secondary" />
          </div>
      </div>
      
  </form>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
