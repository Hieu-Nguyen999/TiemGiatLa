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
    public partial class qlkh : Form
    {
        SqlConnection conn;
        SqlCommand cmd;
        string strcon = @"Data Source = BIGBOY\OK; Initial Catalog = TIEMGIATLA  ; Integrated Security = True";
        SqlDataAdapter ad = new SqlDataAdapter();
        DataTable table = new DataTable();
        void loaddata()
        {
            cmd = conn.CreateCommand();
            cmd.CommandText = "select * from Khachhang";
            cmd.ExecuteNonQuery();
            ad.SelectCommand = cmd;
            table.Clear();
            ad.Fill(table);
            dgve.DataSource = table;
        }
        public qlkh()
        {
            InitializeComponent();
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }

        private void qlkh_Load(object sender, EventArgs e)
        {
            conn = new SqlConnection(strcon);
            conn.Open();
            loaddata();
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }
    }
}
