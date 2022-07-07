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
   
    public partial class Form_BillDetail : Form
    {
        string bill_date;
        string city_from;
        string city_to;
        string grade;
        string price;
        string date_start;
        string time_start;
        string date_end;
        string time_end;
        string quantity;
        string maso;
        string trangthai;

        string connection = "";

        public void data(string bill_date, string city_from, string city_to, string grade, string price, string date_start, string time_start, string date_end, string time_end, string quantity, string maso, string trangthai)
        {
            this.bill_date = bill_date;
            this.city_from = city_from;
            this.city_to = city_to;
            this.grade = grade;
            this.price = price;
            this.date_start = date_start;
            this.time_start = time_start;
            this.date_end = date_end;
            this.time_end = time_end;
            this.quantity = quantity;
            this.maso = maso;
            this.trangthai = trangthai;
        }
        public Form_BillDetail()
        {
            InitializeComponent();
        }
        public void getConnection(string connect)
        {
            connection = connect;
        }


        private void Form_BillDetail_Load(object sender, EventArgs e)
        {
            lbDate.Text = bill_date;
            lb_from.Text = city_from;
            lb_to.Text = city_to;
            lb_price.Text = price;
            lb_date_start.Text = date_start;
            lb_time_start.Text = time_start;
            lb_date_end.Text = date_end;
            lb_time_end.Text = time_end;
            lb_service.Text = grade;
            lb_quantity.Text = quantity;
        }

        private void pictureBox1_Click(object sender, EventArgs e)
        {

            if (int.Parse(trangthai) == 0)
            {
                try
                {
                    string query = "HUYHOADON";
                    SqlParameter[] para = new SqlParameter[1];
                    para[0] = new SqlParameter("@maHD", int.Parse(maso));
                    Dataprovider.Instance.ExecProc("HUYHOADON", connection, para);
                    MessageBox.Show("Hủy Thành Công !");
                    this.Hide();
                }
                catch (Exception)
                {
                    MessageBox.Show("Không Hủy Được !");
                }
            }
            else
            {
                MessageBox.Show("Đã quá hạn hủy vé !");
            }


        }

    }
}
