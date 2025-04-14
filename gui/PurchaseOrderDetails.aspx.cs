using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace P4CApp
{
    public partial class PurchaseOrderDetails : System.Web.UI.Page
    {
        string connectionString = ConfigurationManager.ConnectionStrings["P4CConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
                ClearPanelFields();
            }
        }

        private void BindGrid()
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM PurchaseOrderDetails", con))
            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvPurchaseOrderDetails.DataSource = dt;
                gvPurchaseOrderDetails.DataBind();
            }
        }

        protected void gvPurchaseOrderDetails_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPurchaseOrderDetails.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvPurchaseOrderDetails_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int orderID = Convert.ToInt32(gvPurchaseOrderDetails.DataKeys[e.RowIndex].Values["OrderID"]);
            int productID = Convert.ToInt32(gvPurchaseOrderDetails.DataKeys[e.RowIndex].Values["ProductID"]);
            GridViewRow row = gvPurchaseOrderDetails.Rows[e.RowIndex];

            TextBox txtEditQuantityOrdered = (TextBox)row.FindControl("txtEditQuantityOrdered");
            TextBox txtEditPricePerUnit = (TextBox)row.FindControl("txtEditPricePerUnit");

            int quantityOrdered = Convert.ToInt32(txtEditQuantityOrdered.Text.Trim());
            decimal pricePerUnit = Convert.ToDecimal(txtEditPricePerUnit.Text.Trim());

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = @"UPDATE PurchaseOrderDetails 
                               SET QuantityOrdered=@QuantityOrdered, PricePerUnit=@PricePerUnit
                               WHERE OrderID=@OrderID AND ProductID=@ProductID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@QuantityOrdered", quantityOrdered);
                    cmd.Parameters.AddWithValue("@PricePerUnit", pricePerUnit);
                    cmd.Parameters.AddWithValue("@OrderID", orderID);
                    cmd.Parameters.AddWithValue("@ProductID", productID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            gvPurchaseOrderDetails.EditIndex = -1;
            BindGrid();
        }

        protected void gvPurchaseOrderDetails_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPurchaseOrderDetails.EditIndex = -1;
            BindGrid();
        }

        protected void gvPurchaseOrderDetails_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int orderID = Convert.ToInt32(gvPurchaseOrderDetails.DataKeys[e.RowIndex].Values["OrderID"]);
            int productID = Convert.ToInt32(gvPurchaseOrderDetails.DataKeys[e.RowIndex].Values["ProductID"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "DELETE FROM PurchaseOrderDetails WHERE OrderID=@OrderID AND ProductID=@ProductID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@OrderID", orderID);
                    cmd.Parameters.AddWithValue("@ProductID", productID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            BindGrid();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = @"INSERT INTO PurchaseOrderDetails (OrderID, ProductID, QuantityOrdered, PricePerUnit)
                               VALUES (@OrderID, @ProductID, @QuantityOrdered, @PricePerUnit)";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@OrderID", Convert.ToInt32(txtOrderID.Text.Trim()));
                    cmd.Parameters.AddWithValue("@ProductID", Convert.ToInt32(txtProductID.Text.Trim()));
                    cmd.Parameters.AddWithValue("@QuantityOrdered", Convert.ToInt32(txtQuantityOrdered.Text.Trim()));
                    cmd.Parameters.AddWithValue("@PricePerUnit", Convert.ToDecimal(txtPricePerUnit.Text.Trim()));
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            BindGrid();
            ClearPanelFields();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearPanelFields();
        }

        private void ClearPanelFields()
        {
            txtOrderID.Text = "";
            txtProductID.Text = "";
            txtQuantityOrdered.Text = "";
            txtPricePerUnit.Text = "";
        }

        // Home button event handler to redirect to default.aspx
        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }
    }
}
