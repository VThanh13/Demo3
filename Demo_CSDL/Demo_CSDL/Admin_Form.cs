using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Demo_CSDL
{
    public partial class Admin_Form : Form
    {
        public Admin_Form()
        {
            InitializeComponent();
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            tbUsername.Text = "";
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            tbPassword.Text = "";
            tbPassword.PasswordChar = '•';
        }

        private void Admin_Form_Load(object sender, EventArgs e)
        {
            btnHide.Focus();
        }

        private void pictureBox5_Click(object sender, EventArgs e)
        {
            try
            {
                string connect = @"Data Source=DESKTOP-5QAR7PK\SQLEXPRESS07;Initial Catalog = HEQTCSDL1; User ID = " + tbUsername.Text.Trim() + "; Password = " + tbPassword.Text.Trim();
                SqlConnection connection = new SqlConnection(connect);
                connection.Open();

                MessageBox.Show("Đăng nhập thành công !!");

                FormAdmin f1 = new FormAdmin();

                this.Hide();
                f1.getConnection(connect);
                f1.ShowDialog();

                connection.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("Đăng nhập thất bại !!");
            }
        }
    }
}
