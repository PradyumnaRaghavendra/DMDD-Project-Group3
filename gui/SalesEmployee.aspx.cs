using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace P4CApp
{
    public partial class SalesEmployee : System.Web.UI.Page
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
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM SalesEmployee", con))
            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvSalesEmployee.DataSource = dt;
                gvSalesEmployee.DataBind();
            }
        }

        protected void gvSalesEmployee_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSalesEmployee.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvSalesEmployee_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Get original keys from DataKeys
            int originalSaleID = Convert.ToInt32(gvSalesEmployee.DataKeys[e.RowIndex].Values["SaleID"]);
            int originalEmployeeID = Convert.ToInt32(gvSalesEmployee.DataKeys[e.RowIndex].Values["EmployeeID"]);
            GridViewRow row = gvSalesEmployee.Rows[e.RowIndex];

            // Retrieve new values from TemplateFields using FindControl
            TextBox txtEditSaleID = (TextBox)row.FindControl("txtEditSaleID");
            TextBox txtEditEmployeeID = (TextBox)row.FindControl("txtEditEmployeeID");

            int newSaleID = Convert.ToInt32(txtEditSaleID.Text.Trim());
            int newEmployeeID = Convert.ToInt32(txtEditEmployeeID.Text.Trim());

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = @"UPDATE SalesEmployee 
                               SET SaleID=@NewSaleID, EmployeeID=@NewEmployeeID
                               WHERE SaleID=@OriginalSaleID AND EmployeeID=@OriginalEmployeeID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@NewSaleID", newSaleID);
                    cmd.Parameters.AddWithValue("@NewEmployeeID", newEmployeeID);
                    cmd.Parameters.AddWithValue("@OriginalSaleID", originalSaleID);
                    cmd.Parameters.AddWithValue("@OriginalEmployeeID", originalEmployeeID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            gvSalesEmployee.EditIndex = -1;
            BindGrid();
        }

        protected void gvSalesEmployee_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSalesEmployee.EditIndex = -1;
            BindGrid();
        }

        protected void gvSalesEmployee_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int saleID = Convert.ToInt32(gvSalesEmployee.DataKeys[e.RowIndex].Values["SaleID"]);
            int employeeID = Convert.ToInt32(gvSalesEmployee.DataKeys[e.RowIndex].Values["EmployeeID"]);

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "DELETE FROM SalesEmployee WHERE SaleID=@SaleID AND EmployeeID=@EmployeeID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@SaleID", saleID);
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeID);
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
                string sql = "INSERT INTO SalesEmployee (SaleID, EmployeeID) VALUES (@SaleID, @EmployeeID)";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@SaleID", Convert.ToInt32(txtSaleID.Text.Trim()));
                    cmd.Parameters.AddWithValue("@EmployeeID", Convert.ToInt32(txtEmployeeID.Text.Trim()));
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
            txtEmployeeID.Text = "";
        }
    }
}
