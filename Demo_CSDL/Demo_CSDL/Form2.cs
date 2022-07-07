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
    public partial class Form2 : Form
    {
        string username;
        User userModel = new User();
        public Form2()
        {
            InitializeComponent();
         
        }
        string connection = "";

        string Admin_connect = @"Data Source=DESKTOP-5QAR7PK\SQLEXPRESS07;Initial Catalog = HEQTCSDL1; User ID = Admin; Password = Admin123";
        public void logUsername(string e)
        {
            this.username = e;
            lbName.Text = this.username;
        }
        private void Form2_Load(object sender, EventArgs e)
        {
            pictureBox11_Click(sender, e);
            timer.Start();

            tbSex.BackColor = Color.Red;
            
        }

        public void getConnection(string connect)
        {
            connection = connect;
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            lbTime.Text = DateTime.Now.ToString("HH:mm:ss:tt");
            lbDay.Text = DateTime.Now.ToString("dd - MM - yyyy");
            lbDay.Font = new Font("Roboto", 14, FontStyle.Bold);
            lbDay.ForeColor = System.Drawing.Color.White;
            lbTime.Font = new Font("Roboto", 14, FontStyle.Bold);
            lbTime.ForeColor = System.Drawing.Color.White;
        }

        private void pictureBox11_Click(object sender, EventArgs e)
        {

            tbName.ReadOnly = true;
            tbUserName.ReadOnly = true;
            tbBirthday.ReadOnly = true;
            tbEmail.ReadOnly = true;
            tbPhone.ReadOnly = true;
            tbAddress.ReadOnly = true;
            tb_Sex.ReadOnly = true;
            
            string sql = "exec SHOWKHACHHANG '" + username + "'";
            DataTable dt = Dataprovider.Instance.ExcuteQuery(sql, connection);

            for (int i = 0; i < dt.Rows.Count; i++)
            { 
                userModel.Fullname = dt.Rows[i].Field<string>(1);
                userModel.Username = dt.Rows[i].Field<string>(7);
                if (dt.Rows[i].IsNull(2))
                {
                    userModel.Birthday = "";
                   
                }
                else
                {
                    string[] date = dt.Rows[i].Field<DateTime>(2).ToString().Split(' ');
                    userModel.Birthday = date[0];
                }
            
                userModel.Email = dt.Rows[i].Field<string>(6);
                userModel.Phone = dt.Rows[i].Field<string>(5);

                if (dt.Rows[i].IsNull(3))
                {
                    userModel.Address = "";
                }
                else
                {
                    
                    userModel.Address = dt.Rows[i].Field<string>(3);
                }

                
                if (dt.Rows[i].IsNull(4))
                {
                    userModel.Sex = "";
                }
                else
                {
                    
                    userModel.Sex = dt.Rows[i].Field<string>(4);
                }


            }
            loadData();

            panel6.Visible = false;
            pnChangePass.Visible = false;
        }

        private void pictureBox12_Click(object sender, EventArgs e)
        {
           
            tbName.ReadOnly = false;
            tbUserName.ReadOnly = false;
            tbBirthday.ReadOnly = false;
            tbEmail.ReadOnly = false;
            tbPhone.ReadOnly = false;
            tbAddress.ReadOnly = false;
            tb_Sex.ReadOnly = false;
            panel6.Visible = true;
            pnChangePass.Visible = false;

        }


        private void pictureBox13_Click(object sender, EventArgs e)
        {
            pnChangePass.Visible = true;
            tbOldpass.Text = "";
            tbNewPass.Text = "";
            tbRepeatpass.Text = "";
            panel6.Visible = false;
        }

        private void pictureBox7_Click(object sender, EventArgs e)
        {
            Form1 f1 = new Form1();

            this.Hide();
            f1.getConnection(connection);
            f1.logUsername(username);
            f1.Show();
        }
        private void pictureBox3_Click(object sender, EventArgs e)
        {
            FormSearchcs f1 = new FormSearchcs();

            this.Hide();
            f1.getConnection(connection);
            f1.logUsername(username);
            f1.ShowDialog();
        }

        private void pictureBox4_Click(object sender, EventArgs e)
        {
            FormBooking f1 = new FormBooking();

            this.Hide();
            f1.getConnection(connection);
            f1.logUsername(username);
            f1.ShowDialog();
        }

        private void pictureBox5_Click(object sender, EventArgs e)
        {
            FormCart f1 = new FormCart();

            this.Hide();
            f1.getConnection(connection);
            f1.logUsername(username);
            f1.ShowDialog();
        }

        private void panel4_Paint(object sender, PaintEventArgs e)
        {
           
        }

        void loadData() 
        {
            tbName.Text = userModel.Fullname;
            tbUserName.Text = userModel.Username;
            tbBirthday.Text = userModel.Birthday;
            tbEmail.Text = userModel.Email;
            tbPhone.Text = userModel.Phone;
            tbAddress.Text = userModel.Address;
            tb_Sex.Text = userModel.Sex;
        }

        private void ptSave_Click(object sender, EventArgs e)
        {
            if (tbPhone.Text.Trim() == "")
            {
                tbPhone.Text = null;
            }

            if (tbEmail.Text.Trim() == "")
            {
                tbEmail.Text = null;
            }

            if(tb_Sex.Text.Trim() == "")
            {
                tb_Sex.Text = null;
            }
            string query = "UPDATEINFOUSER";
            SqlParameter[] sqlpara = new SqlParameter[8];
            sqlpara[0] = new SqlParameter("@TenKH", tbName.Text.Trim());
            //sqlpara[1] = new SqlParameter("@NgaySinh", DateTime.Parse(tbBirthday.Text.Trim()));

            if (tbBirthday.Text.Trim().Length > 0)
                sqlpara[1] = new SqlParameter("@NgaySinh", DateTime.Parse(tbBirthday.Text.Trim()));
            else
                sqlpara[1] = new SqlParameter("@NgaySinh", DBNull.Value);

            if (tbAddress.Text.Trim().Length > 0)
                sqlpara[2] = new SqlParameter("@DiaChi", tbAddress.Text.Trim());
            else
                sqlpara[2] = new SqlParameter("@DiaChi", DBNull.Value);

            if (tb_Sex.Text.Trim().Length > 0)
                sqlpara[3] = new SqlParameter("@GioiTinh", tb_Sex.Text.Trim());
            else
                sqlpara[3] = new SqlParameter("@GioiTinh", DBNull.Value);

            

          //  sqlpara[2] = new SqlParameter("@DiaChi", tbAddress.Text.Trim());
          //  sqlpara[3] = new SqlParameter("@GioiTinh", tb_Sex.Text.Trim());
            sqlpara[4] = new SqlParameter("@SDT", tbPhone.Text.Trim());
            sqlpara[5] = new SqlParameter("@EMAIL", tbEmail.Text.Trim());
            sqlpara[6] = new SqlParameter("@UserNameMoi", tbUserName.Text.Trim());
            sqlpara[7] = new SqlParameter("@UserNameCu", username);

            try
            {
                Dataprovider.Instance.ExecProc(query, Admin_connect, sqlpara);
                MessageBox.Show("Cập nhật thành công");
                username = tbUserName.Text.Trim();
                lbName.Text = username;
            }
            catch (Exception)
            {
                MessageBox.Show("Cập nhật không thành công");
            }
        }

        private void ptSaveChange_Click(object sender, EventArgs e)
        {
            string matkhaucu = tbOldpass.Text;
            string matkhaumoi = tbNewPass.Text;
            string repeatmatkhau = tbRepeatpass.Text;

            if (repeatmatkhau != matkhaumoi)
            {
                MessageBox.Show("Mật khẩu mới không trùng khớp");
            }
            else
            {
                string query = "CHANGEPASSWORD";
                SqlParameter[] sqlpara = new SqlParameter[3];
                sqlpara[0] = new SqlParameter("@UserName", username);
                sqlpara[1] = new SqlParameter("@OldPass", matkhaucu);
                sqlpara[2] = new SqlParameter("@MatKhau", matkhaumoi);

                try
                {
                    Dataprovider.Instance.ExecProc(query, Admin_connect, sqlpara);
                    MessageBox.Show("Cập nhật thành công");
                }
                catch (Exception)
                {
                    MessageBox.Show("Cập nhật không thành công");
                }

            }

        }
    }
}
