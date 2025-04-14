using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace P4CApp
{
    public partial class Sales : System.Web.UI.Page
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
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM Sales", con))
            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvSales.DataSource = dt;
                gvSales.DataBind();
            }
        }

        protected void gvSales_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSales.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvSales_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int saleID = Convert.ToInt32(gvSales.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvSales.Rows[e.RowIndex];

            // Retrieve controls using FindControl
            TextBox txtEditCustomerID = (TextBox)row.FindControl("txtEditCustomerID");
            TextBox txtEditTotalAmount = (TextBox)row.FindControl("txtEditTotalAmount");
            TextBox txtEditInvoiceNumber = (TextBox)row.FindControl("txtEditInvoiceNumber");

            int customerID = Convert.ToInt32(txtEditCustomerID.Text.Trim());
            decimal totalAmount = Convert.ToDecimal(txtEditTotalAmount.Text.Trim());
            string invoiceNumber = txtEditInvoiceNumber.Text.Trim();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = @"UPDATE Sales 
                               SET CustomerID=@CustomerID, TotalAmount=@TotalAmount, InvoiceNumber=@InvoiceNumber 
                               WHERE SaleID=@SaleID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@CustomerID", customerID);
                    cmd.Parameters.AddWithValue("@TotalAmount", totalAmount);
                    cmd.Parameters.AddWithValue("@InvoiceNumber", invoiceNumber);
                    cmd.Parameters.AddWithValue("@SaleID", saleID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
            gvSales.EditIndex = -1;
            BindGrid();
        }

        protected void gvSales_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSales.EditIndex = -1;
            BindGrid();
        }

        protected void gvSales_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int saleID = Convert.ToInt32(gvSales.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "DELETE FROM Sales WHERE SaleID=@SaleID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@SaleID", saleID);
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
                string sql = @"INSERT INTO Sales (CustomerID, TotalAmount, InvoiceNumber) 
                               VALUES (@CustomerID, @TotalAmount, @InvoiceNumber)";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@CustomerID", Convert.ToInt32(txtCustomerID.Text.Trim()));
                    cmd.Parameters.AddWithValue("@TotalAmount", Convert.ToDecimal(txtTotalAmount.Text.Trim()));
                    cmd.Parameters.AddWithValue("@InvoiceNumber", txtInvoiceNumber.Text.Trim());
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
            txtSaleID.Text = "";
            txtCustomerID.Text = "";
            txtTotalAmount.Text = "";
            txtInvoiceNumber.Text = "";
        }
    }
}
