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
    public partial class DangNhap : Form
    {
        public DangNhap()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(@"Data Source = BIGBOY\OK; Initial Catalog = TIEMGIATLA  ; Integrated Security = True");
            string sqlselect = "select *from username where _User = '" + tk.Text + "'and _Pass = '" + mk.Text + "'";
            con.Open();
            SqlCommand cmd = new SqlCommand(sqlselect,con);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read() == false)
            {
                MessageBox.Show("Bạn đăng nhập không thành công");
                tk.Text = "";
                mk.Text = "";
                tk.Focus();
            }
            else
            {
                MessageBox.Show("Bạn đăng nhập thành công");
                frm_main f = new frm_main();
    
                f.Show();
            }
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }

        private void tk_TextChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void DangNhap_FormClosing(object sender, FormClosingEventArgs e)
        {
            
        }
    }
}
