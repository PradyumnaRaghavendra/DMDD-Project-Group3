using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace P4CApp
{
    public partial class InventoryTransactions : System.Web.UI.Page
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
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM InventoryTransactions", con))
            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvTransactions.DataSource = dt;
                gvTransactions.DataBind();
            }
        }

        protected void gvTransactions_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvTransactions.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvTransactions_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int transactionID = Convert.ToInt32(gvTransactions.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvTransactions.Rows[e.RowIndex];

            // Retrieve the edited values using FindControl from the TemplateFields
            TextBox txtEditInventoryID = (TextBox)row.FindControl("txtEditInventoryID");
            TextBox txtEditQuantityChanged = (TextBox)row.FindControl("txtEditQuantityChanged");

            int inventoryID = Convert.ToInt32(txtEditInventoryID.Text.Trim());
            int quantityChanged = Convert.ToInt32(txtEditQuantityChanged.Text.Trim());

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = @"UPDATE InventoryTransactions
                               SET InventoryID=@InventoryID, QuantityChanged=@QuantityChanged
                               WHERE TransactionID=@TransactionID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@InventoryID", inventoryID);
                    cmd.Parameters.AddWithValue("@QuantityChanged", quantityChanged);
                    cmd.Parameters.AddWithValue("@TransactionID", transactionID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            gvTransactions.EditIndex = -1;
            BindGrid();
        }

        protected void gvTransactions_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvTransactions.EditIndex = -1;
            BindGrid();
        }

        protected void gvTransactions_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int transactionID = Convert.ToInt32(gvTransactions.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "DELETE FROM InventoryTransactions WHERE TransactionID=@TransactionID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@TransactionID", transactionID);
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
                string sql = @"INSERT INTO InventoryTransactions (InventoryID, QuantityChanged)
                               VALUES (@InventoryID, @QuantityChanged)";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@InventoryID", Convert.ToInt32(txtInventoryID.Text.Trim()));
                    cmd.Parameters.AddWithValue("@QuantityChanged", Convert.ToInt32(txtQuantityChanged.Text.Trim()));
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
            txtTransactionID.Text = "";
            txtInventoryID.Text = "";
            txtQuantityChanged.Text = "";
        }
    }
}
