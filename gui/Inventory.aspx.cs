using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace P4CApp
{
    public partial class Inventory : System.Web.UI.Page
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
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM Inventory", con))
            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvInventory.DataSource = dt;
                gvInventory.DataBind();
            }
        }

        protected void gvInventory_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvInventory.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvInventory_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int inventoryID = Convert.ToInt32(gvInventory.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvInventory.Rows[e.RowIndex];
            TextBox txtEditProductID = (TextBox)row.FindControl("txtEditProductID");
            TextBox txtEditStockLevel = (TextBox)row.FindControl("txtEditStockLevel");

            int productID = Convert.ToInt32(txtEditProductID.Text.Trim());
            int stockLevel = Convert.ToInt32(txtEditStockLevel.Text.Trim());

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = @"UPDATE Inventory SET ProductID=@ProductID, StockLevel=@StockLevel WHERE InventoryID=@InventoryID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@ProductID", productID);
                    cmd.Parameters.AddWithValue("@StockLevel", stockLevel);
                    cmd.Parameters.AddWithValue("@InventoryID", inventoryID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            gvInventory.EditIndex = -1;
            BindGrid();
        }

        protected void gvInventory_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvInventory.EditIndex = -1;
            BindGrid();
        }

        protected void gvInventory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int inventoryID = Convert.ToInt32(gvInventory.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "DELETE FROM Inventory WHERE InventoryID=@InventoryID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@InventoryID", inventoryID);
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
                string sql = @"INSERT INTO Inventory (ProductID, StockLevel) VALUES (@ProductID, @StockLevel)";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@ProductID", Convert.ToInt32(txtProductID.Text.Trim()));
                    cmd.Parameters.AddWithValue("@StockLevel", Convert.ToInt32(txtStockLevel.Text.Trim()));
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
        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }


        private void ClearPanelFields()
        {
            txtInventoryID.Text = "";
            txtProductID.Text = "";
            txtStockLevel.Text = "";
        }
    }
}
