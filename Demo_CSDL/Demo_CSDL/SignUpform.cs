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
    public partial class SignUpform : Form
    {
        public SignUpform()
        {
            InitializeComponent();
        }
        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            tbFullname.Text = "";
        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            tbUsername.Text = "";
        }


        private void textBox4_TextChanged(object sender, EventArgs e)
        {
            tbEmail.Text = "";
        }

        private void textBox5_TextChanged(object sender, EventArgs e)
        {
            tbPhone.Text = "";
        }

        private void pictureBox5_Click(object sender, EventArgs e)
        {
                string query = "SIGNINUSER";
                SqlParameter[] sqlpara = new SqlParameter[5];
                sqlpara[0] = new SqlParameter("@TenKH", tbFullname.Text.Trim());
                sqlpara[1] = new SqlParameter("@UserName", tbUsername.Text.Trim());
                sqlpara[2] = new SqlParameter("@MatKhau", tbPassword.Text.Trim());
                sqlpara[3] = new SqlParameter("@EMAIL", tbEmail.Text.Trim());
                sqlpara[4] = new SqlParameter("@SDT", tbPhone.Text.Trim());

            string connect = @"Data Source=DESKTOP-5QAR7PK\SQLEXPRESS07;Initial Catalog = HEQTCSDL1; User ID = Admin; Password = Admin123";
            try
            {
                Dataprovider.Instance.ExecProc(query,connect, sqlpara);
                MessageBox.Show("Đăng kí thành công");

                User_form f1 = new User_form();

                
                this.Hide();
                f1.Show();
            }
            catch (Exception)
            {
                MessageBox.Show("Đăng ký không thành công");
            }

        }

        private void pictureBox6_Click(object sender, EventArgs e)
        {
            User_form f1 = new User_form();

            this.Hide();
            f1.Show();
        }

        private void SignUpform_Load(object sender, EventArgs e)
        {

            btnHide.Focus();
        }

        private void tbPassword_TextChanged(object sender, EventArgs e)
        {
            tbPassword.Text = "";
            tbPassword.PasswordChar = '•';
        }
    }
}
