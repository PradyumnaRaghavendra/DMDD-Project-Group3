<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="P4CApp.Employees" %>
<!DOCTYPE html>
<html>
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Employees CRUD</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg-light">
  <form id="form1" runat="server" class="container py-4">
    <h2 class="mb-4">Employees CRUD Operations</h2>
    <div class="mb-3 d-flex justify-content-end">
  <asp:Button ID="btnHome" runat="server" Text="HOME"
              CssClass="btn btn-primary"
              OnClick="btnHome_Click" />
</div>

    <!-- Employees Grid -->
    <div class="table-responsive shadow-sm rounded mb-5">
      <asp:GridView ID="gvEmployees" runat="server" AutoGenerateColumns="False"
          DataKeyNames="EmployeeID"
          OnRowEditing="gvEmployees_RowEditing"
          OnRowUpdating="gvEmployees_RowUpdating"
          OnRowCancelingEdit="gvEmployees_RowCancelingEdit"
          OnRowDeleting="gvEmployees_RowDeleting"
          CssClass="table table-striped table-hover align-middle mb-0"
          HeaderStyle-CssClass="table-dark text-white">
        <Columns>
          <%-- Employee ID --%>
          <asp:TemplateField HeaderText="Employee ID">
            <ItemTemplate>
              <span class="d-block text-center"><%# Eval("EmployeeID") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditEmployeeID" runat="server" Text='<%# Bind("EmployeeID") %>'
                           CssClass="form-control" ReadOnly="True" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Name --%>
          <asp:TemplateField HeaderText="Name">
            <ItemTemplate>
              <span><%# Eval("Name") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditName" runat="server" Text='<%# Bind("Name") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Role --%>
          <asp:TemplateField HeaderText="Role">
            <ItemTemplate>
              <span><%# Eval("Role") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditRole" runat="server" Text='<%# Bind("Role") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Contact --%>
          <asp:TemplateField HeaderText="Contact">
            <ItemTemplate>
              <span><%# Eval("Contact") %></span>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditContact" runat="server" Text='<%# Bind("Contact") %>' CssClass="form-control" />
            </EditItemTemplate>
          </asp:TemplateField>
          
          <%-- Salary --%>
          <asp:TemplateField HeaderText="Salary">
            <ItemTemplate>
              <%# String.Format("{0:C}", Eval("Salary")) %>
            </ItemTemplate>
            <EditItemTemplate>
              <asp:TextBox ID="txtEditSalary" runat="server" Text='<%# Bind("Salary") %>' CssClass="form-control" />
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
                  OnClientClick="return confirm('Delete this employee?');"
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
    
    <!-- Add New Employee Panel -->
    <h3 class="mb-3">Add New Employee</h3>
    <div class="card p-3">
      <div class="mb-3">
        <asp:Label ID="lblEmployeeID" runat="server" Text="Employee ID:" CssClass="form-label" />
        <asp:TextBox ID="txtEmployeeID" runat="server" ReadOnly="True" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label ID="lblName" runat="server" Text="Name:" CssClass="form-label" />
        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label ID="lblRole" runat="server" Text="Role:" CssClass="form-label" />
        <asp:TextBox ID="txtRole" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label ID="lblContact" runat="server" Text="Contact:" CssClass="form-label" />
        <asp:TextBox ID="txtContact" runat="server" CssClass="form-control" />
      </div>
      <div class="mb-3">
        <asp:Label ID="lblSalary" runat="server" Text="Salary:" CssClass="form-label" />
        <asp:TextBox ID="txtSalary" runat="server" CssClass="form-control" />
      </div>
      <div>
        <asp:Button ID="btnAdd" runat="server" Text="Add Employee" 
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
