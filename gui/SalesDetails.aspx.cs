using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace P4CApp
{
    public partial class SalesDetails : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["P4CConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
                BindSaleIDs();
                BindProductIDs();
                ClearPanelFields();
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM SalesDetails", con))
            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvSalesDetails.DataSource = dt;
                gvSalesDetails.DataBind();
            }
        }

        // Populate the SaleID dropdown from the Sales table
        private void BindSaleIDs()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("SELECT SaleID FROM Sales", con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlSaleID.DataSource = dt;
                ddlSaleID.DataTextField = "SaleID";
                ddlSaleID.DataValueField = "SaleID";
                ddlSaleID.DataBind();
            }
        }

        // Populate the ProductID dropdown from the Products table
        private void BindProductIDs()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("SELECT ProductID FROM Products", con))
            using (SqlDataAdapter da = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlProductID.DataSource = dt;
                ddlProductID.DataTextField = "ProductID";
                ddlProductID.DataValueField = "ProductID";
                ddlProductID.DataBind();
            }
        }

        protected void gvSalesDetails_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSalesDetails.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvSalesDetails_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int saleID = Convert.ToInt32(gvSalesDetails.DataKeys[e.RowIndex].Values["SaleID"]);
            int productID = Convert.ToInt32(gvSalesDetails.DataKeys[e.RowIndex].Values["ProductID"]);
            GridViewRow row = gvSalesDetails.Rows[e.RowIndex];

            TextBox txtQty = (TextBox)row.FindControl("txtEditQuantity");
            TextBox txtSubtotal = (TextBox)row.FindControl("txtEditSubtotal");

            if (!int.TryParse(txtQty.Text.Trim(), out int quantity))
            {
                return;
            }
            if (!decimal.TryParse(txtSubtotal.Text.Trim(), out decimal subtotal))
            {
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(
                "UPDATE SalesDetails SET Quantity=@Quantity, Subtotal=@Subtotal WHERE SaleID=@SaleID AND ProductID=@ProductID", con))
            {
                cmd.Parameters.AddWithValue("@Quantity", quantity);
                cmd.Parameters.AddWithValue("@Subtotal", subtotal);
                cmd.Parameters.AddWithValue("@SaleID", saleID);
                cmd.Parameters.AddWithValue("@ProductID", productID);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvSalesDetails.EditIndex = -1;
            BindGrid();
        }

        protected void gvSalesDetails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSalesDetails.EditIndex = -1;
            BindGrid();
        }

        protected void gvSalesDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int saleID = Convert.ToInt32(gvSalesDetails.DataKeys[e.RowIndex].Values["SaleID"]);
            int productID = Convert.ToInt32(gvSalesDetails.DataKeys[e.RowIndex].Values["ProductID"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(
                "DELETE FROM SalesDetails WHERE SaleID=@SaleID AND ProductID=@ProductID", con))
            {
                cmd.Parameters.AddWithValue("@SaleID", saleID);
                cmd.Parameters.AddWithValue("@ProductID", productID);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindGrid();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Parse the selected SaleID and ProductID from the dropdown lists
            if (!int.TryParse(ddlSaleID.SelectedValue, out int saleID))
            {
                return;
            }
            if (!int.TryParse(ddlProductID.SelectedValue, out int productID))
            {
                return;
            }
            if (!int.TryParse(txtQuantity.Text.Trim(), out int quantity))
            {
                return;
            }
            if (!decimal.TryParse(txtSubtotal.Text.Trim(), out decimal subtotal))
            {
                return;
            }

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(
                "INSERT INTO SalesDetails (SaleID, ProductID, Quantity, Subtotal) VALUES (@SaleID, @ProductID, @Quantity, @Subtotal)", con))
            {
                cmd.Parameters.AddWithValue("@SaleID", saleID);
                cmd.Parameters.AddWithValue("@ProductID", productID);
                cmd.Parameters.AddWithValue("@Quantity", quantity);
                cmd.Parameters.AddWithValue("@Subtotal", subtotal);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindGrid();
            ClearPanelFields();
        }
        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearPanelFields();
        }

        private void ClearPanelFields()
        {
            // Optionally, reset the dropdowns to the first item.
            if (ddlSaleID.Items.Count > 0)
                ddlSaleID.SelectedIndex = 0;
            if (ddlProductID.Items.Count > 0)
                ddlProductID.SelectedIndex = 0;

            txtQuantity.Text = "";
            txtSubtotal.Text = "";
        }
    }
}
