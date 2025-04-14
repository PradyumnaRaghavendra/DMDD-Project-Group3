using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace P4CApp
{
    public partial class Products : System.Web.UI.Page
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
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM Products", con))
            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvProducts.DataSource = dt;
                gvProducts.DataBind();
            }
        }

        protected void gvProducts_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvProducts.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvProducts_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int productID = Convert.ToInt32(gvProducts.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvProducts.Rows[e.RowIndex];

            // Using FindControl to reliably access controls from the EditItemTemplate
            TextBox txtEditName = (TextBox)row.FindControl("txtEditName");
            TextBox txtEditCategory = (TextBox)row.FindControl("txtEditCategory");
            TextBox txtEditPrice = (TextBox)row.FindControl("txtEditPrice");
            TextBox txtEditStockLevel = (TextBox)row.FindControl("txtEditStockLevel");
            TextBox txtEditSupplierID = (TextBox)row.FindControl("txtEditSupplierID");

            string name = txtEditName.Text.Trim();
            string category = txtEditCategory.Text.Trim();
            decimal price = Convert.ToDecimal(txtEditPrice.Text.Trim());
            int stockLevel = Convert.ToInt32(txtEditStockLevel.Text.Trim());
            int supplierID = Convert.ToInt32(txtEditSupplierID.Text.Trim());

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = @"UPDATE Products 
                               SET Name=@Name, Category=@Category, Price=@Price, StockLevel=@StockLevel, SupplierID=@SupplierID 
                               WHERE ProductID=@ProductID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Category", category);
                    cmd.Parameters.AddWithValue("@Price", price);
                    cmd.Parameters.AddWithValue("@StockLevel", stockLevel);
                    cmd.Parameters.AddWithValue("@SupplierID", supplierID);
                    cmd.Parameters.AddWithValue("@ProductID", productID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            gvProducts.EditIndex = -1;
            BindGrid();
        }

        protected void gvProducts_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvProducts.EditIndex = -1;
            BindGrid();
        }

        protected void gvProducts_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int productID = Convert.ToInt32(gvProducts.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "DELETE FROM Products WHERE ProductID=@ProductID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
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
                string sql = @"INSERT INTO Products (Name, Category, Price, StockLevel, SupplierID) 
                               VALUES (@Name, @Category, @Price, @StockLevel, @SupplierID)";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Category", txtCategory.Text.Trim());
                    cmd.Parameters.AddWithValue("@Price", Convert.ToDecimal(txtPrice.Text.Trim()));
                    cmd.Parameters.AddWithValue("@StockLevel", Convert.ToInt32(txtStockLevel.Text.Trim()));
                    cmd.Parameters.AddWithValue("@SupplierID", Convert.ToInt32(txtSupplierID.Text.Trim()));
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
            txtProductID.Text = "";
            txtName.Text = "";
            txtCategory.Text = "";
            txtPrice.Text = "";
            txtStockLevel.Text = "";
            txtSupplierID.Text = "";
        }
    }
}
