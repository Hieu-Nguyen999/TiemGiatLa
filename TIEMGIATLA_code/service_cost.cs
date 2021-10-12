using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace tiemgiatla
{
    public partial class service_cost : Form
    {
        SqlConnection conn;
        SqlCommand cmd;
        string str = @"Data Source = BIGBOY\OK; Initial Catalog = TIEMGIATLA  ; Integrated Security = True";
        SqlDataAdapter ad = new SqlDataAdapter();
        DataTable table = new DataTable();
        void loaddata()
        {
            cmd = conn.CreateCommand();
            cmd.CommandText = "select * from Banggia";
            cmd.ExecuteNonQuery();
            ad.SelectCommand = cmd;
            table.Clear();
            ad.Fill(table);
            dataGridView1.DataSource = table;
        }
        public service_cost()
        {
            InitializeComponent();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void service_cost_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(str);
            conn.Open();
            loaddata();
        }
    }
}
