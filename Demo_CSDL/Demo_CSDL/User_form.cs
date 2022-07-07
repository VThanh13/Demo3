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
    public partial class User_form : Form
    {

        public User_form()
        {
            InitializeComponent();
            
        }

        private void tbUsername_TextChanged(object sender, EventArgs e)
        {
            tbUsername.Text = "";
       
        }

        private void tbPassword_TextChanged(object sender, EventArgs e)
        {
         
            tbPassword.Text = "";
       
            tbPassword.PasswordChar = '•';
        }
        
         
        private void pictureBox5_Click(object sender, EventArgs e)
        {
           try
            {
                string connect = @"Data Source=DESKTOP-5QAR7PK\SQLEXPRESS07;Initial Catalog = HEQTCSDL1; User ID = " + tbUsername.Text.Trim() + "; Password = " + tbPassword.Text.Trim();
                SqlConnection connection = new SqlConnection(connect);
                connection.Open();

                MessageBox.Show("Đăng nhập thành công !!");

                Form1 f1 = new Form1();

                this.Hide();
                f1.getConnection(connect);
                f1.logUsername(tbUsername.Text.Trim());
                f1.ShowDialog();

                connection.Close();
            }
            catch (Exception)
            {
                MessageBox.Show("Đăng nhập thất bại !!");
            }
        }

        private void pictureBox6_Click(object sender, EventArgs e)
        {
            SignUpform f1 = new SignUpform();

            this.Hide();
            f1.Show();
        }

        private void User_form_Load(object sender, EventArgs e)
        {
            btnHide.Focus();
        }

        
    }
}
