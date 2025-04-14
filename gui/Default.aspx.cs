using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace P4CApp
{
    public partial class Default : System.Web.UI.Page
    {
        // Ensure the Web.config connection string "P4CConnectionString" points to your database.
        string connectionString = ConfigurationManager.ConnectionStrings["P4CConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateTablesDropDown();
            }
        }

        // Populates the dropdown list with table names from the current database.
        private void PopulateTablesDropDown()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Retrieve only base tables from the INFORMATION_SCHEMA.
                string sql = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE'";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    con.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        ddlTables.DataSource = reader;
                        ddlTables.DataTextField = "TABLE_NAME";
                        ddlTables.DataValueField = "TABLE_NAME";
                        ddlTables.DataBind();
                    }
                }
            }
        }

        // When the user clicks the Go button, redirect to the page corresponding to the chosen table.
        protected void btnSelect_Click(object sender, EventArgs e)
        {
            string selectedTable = ddlTables.SelectedValue;
            string redirectUrl = "";

            // Map table names to your corresponding page names.
            // Ensure that these page names match your project files.
            switch (selectedTable.ToLower())
            {
                case "products":
                    redirectUrl = "Products.aspx";
                    break;

                case "employees":
                    redirectUrl = "Employees.aspx";
                    break;

                case "suppliers":
                    redirectUrl = "Suppliers.aspx";
                    break;
                case "sales":
                    redirectUrl = "Sales.aspx";
                    break;
                case "salesdetails":
                    redirectUrl = "SalesDetails.aspx";
                    break;
                case "customers":
                    redirectUrl = "Customers.aspx";
                    break;
                case "inventory":
                    redirectUrl = "Inventory.aspx";
                    break;
                case "inventorytransactions":
                    redirectUrl = "InventoryTransactions.aspx";
                    break;
                case "salesemployee":
                    redirectUrl = "SalesEmployee.aspx";
                    break;
                case "purchaseorders":
                    redirectUrl = "PurchaseOrders.aspx";
                    break;
                case "purchaseorderdetails":
                    redirectUrl = "PurchaseOrderDetails.aspx";
                    break;
                default:
                    // If the selected table does not have a dedicated page, you could redirect to a generic page or show a message.
                    redirectUrl = "Default.aspx";
                    break;
            }

            Response.Redirect(redirectUrl);
        }
    }
}
