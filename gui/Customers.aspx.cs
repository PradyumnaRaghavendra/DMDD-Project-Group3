using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace P4CApp
{
    public partial class Customers : System.Web.UI.Page
    {
        private readonly string cs = ConfigurationManager
            .ConnectionStrings["P4CConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
                ClearPanel();
            }
        }

        private void BindGrid()
        {
            // Select decrypted Email for display
            string sql = @"
SELECT
    CustomerID,
    Name,
    Contact,
    CONVERT(VARCHAR(256),
        DECRYPTBYPASSPHRASE('encryption_key', Email)
    ) AS Email,
    PurchaseHistory,
    LoyaltyPoints
FROM Customers";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlDataAdapter da = new SqlDataAdapter(sql, con))
            {
                DataTable dt = new DataTable();
                da.Fill(dt);
                gvCustomers.DataSource = dt;
                gvCustomers.DataBind();
            }
        }

        protected void gvCustomers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCustomers.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void gvCustomers_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int id = Convert.ToInt32(gvCustomers.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvCustomers.Rows[e.RowIndex];

            string name = ((TextBox)row.FindControl("txtEditName")).Text.Trim();
            string contact = ((TextBox)row.FindControl("txtEditContact")).Text.Trim();
            string email = ((TextBox)row.FindControl("txtEditEmail")).Text.Trim();
            string history = ((TextBox)row.FindControl("txtEditHistory")).Text.Trim();
            int points = Convert.ToInt32(((TextBox)row.FindControl("txtEditPoints")).Text.Trim());

            // Encrypt Email on update
            string updateSql = @"
UPDATE Customers
   SET Name            = @Name,
       Contact         = @Contact,
       Email           = ENCRYPTBYPASSPHRASE('encryption_key', @Email),
       PurchaseHistory = @History,
       LoyaltyPoints   = @Points
 WHERE CustomerID = @ID";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(updateSql, con))
            {
                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Contact", contact);
                cmd.Parameters.AddWithValue("@Email", email);
                cmd.Parameters.AddWithValue("@History", history);
                cmd.Parameters.AddWithValue("@Points", points);
                cmd.Parameters.AddWithValue("@ID", id);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            gvCustomers.EditIndex = -1;
            BindGrid();
        }

        protected void gvCustomers_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCustomers.EditIndex = -1;
            BindGrid();
        }

        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }


        protected void gvCustomers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int id = Convert.ToInt32(gvCustomers.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(
                "DELETE FROM Customers WHERE CustomerID = @ID", con))
            {
                cmd.Parameters.AddWithValue("@ID", id);
                con.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid();
        }

        protected void btnAdd_Click(object sender, EventArgs e)
        {
            // Removed error label reference.
            if (!int.TryParse(txtLoyaltyPoints.Text.Trim(), out int pts))
            {
                // Simply return if the parse fails.
                return;
            }

            // Encrypt Email on insert
            string insertSql = @"
INSERT INTO Customers
    (Name, Contact, Email, PurchaseHistory, LoyaltyPoints)
VALUES
    (@Name, @Contact,
     ENCRYPTBYPASSPHRASE('encryption_key', @Email),
     @History, @Points)";

            using (SqlConnection con = new SqlConnection(cs))
            using (SqlCommand cmd = new SqlCommand(insertSql, con))
            {
                cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                cmd.Parameters.AddWithValue("@Contact", txtContact.Text.Trim());
                cmd.Parameters.AddWithValue("@Email", txtEmail.Text.Trim());
                cmd.Parameters.AddWithValue("@History", txtPurchaseHistory.Text.Trim());
                cmd.Parameters.AddWithValue("@Points", pts);

                con.Open();
                cmd.ExecuteNonQuery();
            }

            BindGrid();
            ClearPanel();
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            ClearPanel();
        }

        private void ClearPanel()
        {
            txtCustomerID.Text =
            txtName.Text =
            txtContact.Text =
            txtEmail.Text =
            txtPurchaseHistory.Text =
            txtLoyaltyPoints.Text = "";
        }
    }
}
