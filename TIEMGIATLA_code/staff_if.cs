using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Data.SqlClient;

namespace tiemgiatla
{
    public partial class staff_if : Form
    {
        string constring = @"Data Source = BIGBOY\OK; Initial Catalog = TIEMGIATLA  ; Integrated Security = True";

        public staff_if()
        {
            InitializeComponent();
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }
        public void load()
        {
            SqlConnection con = new SqlConnection(constring);
            try
            {
                string select = "select * from Nhanvien";
                SqlDataAdapter dt = new SqlDataAdapter(select, con);
                DataTable tb = new DataTable();
                dt.Fill(tb);
                dgv1.DataSource = tb;
                con.Close();
            }

            catch (Exception)
            {
                MessageBox.Show("Lỗi kết nối");
            }
        }
        private void staff_if_Load(object sender, EventArgs e)
        {
            load();
        }

        public bool ktmanv(string manv)
        {
            SqlConnection con = new SqlConnection(constring);
            con.Open();
            string sql = "select Manv from Nhanvien";
            SqlCommand cmd = new SqlCommand(sql, con);
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read() == true)
            {
                con.Close();
                return true;
            }
            con.Close();
            return false;
        }

        private void dataGridView1_CellContentClick(object sender, DataGridViewCellEventArgs e)
        {

        }
        private void button1_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(constring);
            try
            {
                if (manv.Text != ""&& name.Text!="" && ngaysinh.Text != "" && tln.Text != "" &&  adress.Text!= "")
                {

                    if (ktmanv(manv.Text) == true)
                        MessageBox.Show("nhân viên đã tồn tại");
                    con.Open();
                    string sql = "insert into Nhanvien(MaNV,Hoten,Ngaysinh,SDT,Diachi) values('" + manv.Text + "','" + name.Text + "','" + ngaysinh.Text + "','" + tln.Text + "','" + adress.Text + "')";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    int kq = (int)cmd.ExecuteNonQuery();
                    if (kq > 0)
                    {
                        MessageBox.Show("Thêm thành công");
                    }
                    else
                        MessageBox.Show("Thêm thất bại");
                    con.Close();
                }
                else
                    MessageBox.Show("Chưa nhập đủ thông tin !");
            }
            catch (Exception)
            {
                MessageBox.Show("Lỗi kết nối !");
            }
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }
        private void tln_textchanged(object sender, EventArgs e)
        {

        }
        private void staff_if_FormClosing(object sender, FormClosingEventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            {
                SqlConnection con = new SqlConnection(constring);
                try
                {
                    con.Open();
                    string sql = "Update Nhanvien set( Hoten = '"+name.Text+"' and Ngaysinh = '"+ngaysinh.Text+"'and SDT ='"+tln.Text+"'and Diachi= '"+adress.Text+"') where MaNV ='"+manv.Text+"'";
                    SqlCommand cmd = new SqlCommand(sql, con);
                    load();
                    int kq = (int)cmd.ExecuteNonQuery();
                    if (kq > 0)
                    {
                        MessageBox.Show("sửa thành công");
                    }
                    else
                        MessageBox.Show("sửa thất bại");
                    con.Close();
                    
                }
                catch (Exception)
                {
                    MessageBox.Show("Lỗi kết nối !");
                }
            }
        }

        private void xoa_Click(object sender, EventArgs e)
        {
            DialogResult thongbao;
            thongbao = MessageBox.Show("Bạn có muốn xóa hay không ?","Thông báo ",MessageBoxButtons.OKCancel);
            if (thongbao==DialogResult.OK)
            {
                SqlConnection con = new SqlConnection(constring);
                con.Open();
                string sql = "delete from Nhanvien where MaNV ='" + manv.Text+"'";
                SqlCommand cmd = new SqlCommand(sql,con);
                cmd.ExecuteNonQuery();
                MessageBox.Show("Xóa thành Công !");
                load();
                con.Close();
            }

        }
    }
}
