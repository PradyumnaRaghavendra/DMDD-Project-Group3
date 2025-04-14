<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="P4CApp.Default" %>
<!DOCTYPE html>
<html>
<head runat="server">
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Integrated Electronics Store Database Management System</title>
  <!-- Bootstrap CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
  <!-- Bootstrap Icons -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet" />
  <link href="Styles.css" rel="stylesheet" type="text/css" />
</head>
<body class="bg-light">
  <form id="form1" runat="server" class="container py-4">
    <!-- Heading -->
    <h1 class="text-center mb-4">Integrated Electronics Store Database Management System</h1>
    
    <!-- Table Selection Panel -->
    <div class="row mb-4">
      <div class="col-md-8 offset-md-2">
         <div class="d-flex">
            <asp:DropDownList ID="ddlTables" runat="server" CssClass="form-select"></asp:DropDownList>
            <asp:Button ID="btnSelect" runat="server" Text="Go" CssClass="btn btn-success ms-2" OnClick="btnSelect_Click" />
         </div>
      </div>
    </div>
    
    <!-- Optionally, if you wish to display data on the same page, you could include a GridView.
         However, as per your updated requirement, we now redirect to the corresponding page. -->
    <%-- 
    <div class="table-responsive shadow-sm rounded">
      <asp:GridView ID="gvTable" runat="server" AutoGenerateColumns="True" CssClass="table table-striped table-hover"></asp:GridView>
    </div>
    --%>
    
  </form>
  
  <!-- Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
