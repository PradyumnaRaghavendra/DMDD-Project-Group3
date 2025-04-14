using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace P4CApp
{
    public partial class PurchaseOrders : System.Web.UI.Page
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
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM PurchaseOrders", con))
            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvPurchaseOrders.DataSource = dt;
                gvPurchaseOrders.DataBind();
            }
        }

        protected void gvPurchaseOrders_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPurchaseOrders.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvPurchaseOrders_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int orderID = Convert.ToInt32(gvPurchaseOrders.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvPurchaseOrders.Rows[e.RowIndex];

            // Retrieve edited values using FindControl from the TemplateFields
            TextBox txtEditSupplierID = (TextBox)row.FindControl("txtEditSupplierID");
            TextBox txtEditExpectedDelivery = (TextBox)row.FindControl("txtEditExpectedDelivery");

            int supplierID = Convert.ToInt32(txtEditSupplierID.Text.Trim());
            DateTime expectedDelivery = DateTime.Parse(txtEditExpectedDelivery.Text.Trim());

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = @"UPDATE PurchaseOrders 
                               SET SupplierID=@SupplierID, ExpectedDelivery=@ExpectedDelivery 
                               WHERE OrderID=@OrderID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@SupplierID", supplierID);
                    cmd.Parameters.AddWithValue("@ExpectedDelivery", expectedDelivery);
                    cmd.Parameters.AddWithValue("@OrderID", orderID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            gvPurchaseOrders.EditIndex = -1;
            BindGrid();
        }

        protected void gvPurchaseOrders_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPurchaseOrders.EditIndex = -1;
            BindGrid();
        }

        protected void gvPurchaseOrders_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int orderID = Convert.ToInt32(gvPurchaseOrders.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "DELETE FROM PurchaseOrders WHERE OrderID=@OrderID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@OrderID", orderID);
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
                string sql = @"INSERT INTO PurchaseOrders (SupplierID, ExpectedDelivery) 
                               VALUES (@SupplierID, @ExpectedDelivery)";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@SupplierID", Convert.ToInt32(txtSupplierID.Text.Trim()));
                    cmd.Parameters.AddWithValue("@ExpectedDelivery", DateTime.Parse(txtExpectedDelivery.Text.Trim()));
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
            txtOrderID.Text = "";
            txtSupplierID.Text = "";
            txtExpectedDelivery.Text = "";
        }
    }
}
