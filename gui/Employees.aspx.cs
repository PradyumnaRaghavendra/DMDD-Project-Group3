using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace P4CApp
{
    public partial class Employees : System.Web.UI.Page
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
            using (SqlCommand cmd = new SqlCommand("SELECT * FROM Employees", con))
            using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
            {
                DataTable dt = new DataTable();
                sda.Fill(dt);
                gvEmployees.DataSource = dt;
                gvEmployees.DataBind();
            }
        }

        protected void gvEmployees_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvEmployees.EditIndex = e.NewEditIndex;
            BindGrid();
        }
        protected void btnHome_Click(object sender, EventArgs e)
        {
            Response.Redirect("Default.aspx");
        }

        protected void gvEmployees_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int employeeID = Convert.ToInt32(gvEmployees.DataKeys[e.RowIndex].Value);
            GridViewRow row = gvEmployees.Rows[e.RowIndex];

            // Using FindControl to retrieve values from the template fields
            TextBox txtEditName = (TextBox)row.FindControl("txtEditName");
            TextBox txtEditRole = (TextBox)row.FindControl("txtEditRole");
            TextBox txtEditContact = (TextBox)row.FindControl("txtEditContact");
            TextBox txtEditSalary = (TextBox)row.FindControl("txtEditSalary");

            string name = txtEditName.Text.Trim();
            string role = txtEditRole.Text.Trim();
            string contact = txtEditContact.Text.Trim();
            decimal salary = Convert.ToDecimal(txtEditSalary.Text.Trim());

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "UPDATE Employees SET Name=@Name, Role=@Role, Contact=@Contact, Salary=@Salary WHERE EmployeeID=@EmployeeID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Role", role);
                    cmd.Parameters.AddWithValue("@Contact", contact);
                    cmd.Parameters.AddWithValue("@Salary", salary);
                    cmd.Parameters.AddWithValue("@EmployeeID", employeeID);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            gvEmployees.EditIndex = -1;
            BindGrid();
        }

        protected void gvEmployees_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvEmployees.EditIndex = -1;
            BindGrid();
        }

        protected void gvEmployees_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int employeeID = Convert.ToInt32(gvEmployees.DataKeys[e.RowIndex].Value);
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string sql = "DELETE FROM Employees WHERE EmployeeID=@EmployeeID";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
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
                string sql = "INSERT INTO Employees (Name, Role, Contact, Salary) VALUES (@Name, @Role, @Contact, @Salary)";
                using (SqlCommand cmd = new SqlCommand(sql, con))
                {
                    cmd.Parameters.AddWithValue("@Name", txtName.Text.Trim());
                    cmd.Parameters.AddWithValue("@Role", txtRole.Text.Trim());
                    cmd.Parameters.AddWithValue("@Contact", txtContact.Text.Trim());
                    cmd.Parameters.AddWithValue("@Salary", Convert.ToDecimal(txtSalary.Text.Trim()));
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
            txtEmployeeID.Text = "";
            txtName.Text = "";
            txtRole.Text = "";
            txtContact.Text = "";
            txtSalary.Text = "";
        }
    }
}
