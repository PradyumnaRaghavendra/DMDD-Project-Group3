using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace P4CApp
{
    public partial class Suppliers : System.Web.UI.Page
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
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM Suppliers", con))
            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvSuppliers.DataSource = dt;
                gvSuppliers.DataBind();
            }
        }

        protected void gvSuppliers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSuppliers.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvSuppliers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int supplierID = Convert.ToInt32(gvSuppliers.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvSuppliers.Rows[e.RowIndex];

            TextBox txtNameEdit = (TextBox)row.FindControl("txtEditName");
            TextBox txtContactEdit = (TextBox)row.FindControl("txtEditContact");
            TextBox txtAddressEdit = (TextBox)row.FindControl("txtEditAddress");
            TextBox txtProdSuppliedEdit = (TextBox)row.FindControl("txtEditProductSupplied");

            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(@"
                UPDATE Suppliers
                   SET Name = @Name,
                       Contact = @Contact,
                       Address = @Address,
                       ProductSupplied = @ProductSupplied
                 WHERE SupplierID = @SupplierID", con))
            {
                cmd.Parameters.AddWithValue("@Name", txtNameEdit.Text.Trim());
                cmd.Parameters.AddWithValue("@Contact", txtContactEdit.Text.Trim());
                cmd.Parameters.AddWithValue("@Address", txtAddressEdit.Text.Trim());
                cmd.Parameters.AddWithValue("@ProductSupplied", txtProdSuppliedEdit.Text.Trim());
                cmd.Parameters.AddWithValue("@SupplierID", supplierID);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvSuppliers.EditIndex = -1;
            BindGrid();
        }

        protected void gvSuppliers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSuppliers.EditIndex = -1;
            BindGrid();
        }

        protected void gvSuppliers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get the SupplierID to delete
            int supplierID = Convert.ToInt32(gvSuppliers.DataKeys[e.RowIndex].Value);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();
                // First delete any dependent records in Products that reference this supplier.
                using (SqlCommand cmdDelProducts = new SqlCommand("DELETE FROM Products WHERE SupplierID=@SupplierID", con))
                {
                    cmdDelProducts.Parameters.AddWithValue("@SupplierID", supplierID);
                    cmdDelProducts.ExecuteNonQuery();
                }

                // Now delete the supplier record.
                using (SqlCommand cmdDelSupplier = new SqlCommand("DELETE FROM Suppliers WHERE SupplierID=@SupplierID", con))
                {
                    cmdDelSupplier.Parameters.AddWithValue("@SupplierID", supplierID);
                    cmdDelSupplier.ExecuteNonQuery();
                }
            }
            BindGrid();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(connectionString))
            using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Suppliers (Name, Contact, Address, ProductSupplied)
                VALUES (@Name, @Contact, @Address, @ProductSupplied)", con))
            {
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Contact", txtContact.Text.Trim());
                cmd.Parameters.AddWithValue("@Address", txtAddress.Text.Trim());
                cmd.Parameters.AddWithValue("@ProductSupplied", txtProductSupplied.Text.Trim());
                con.Open();
                cmd.ExecuteNonQuery();
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
            txtSupplierID.Text = "";
            txtName.Text = "";
            txtContact.Text = "";
            txtAddress.Text = "";
            txtProductSupplied.Text = "";
        }
    }
}
