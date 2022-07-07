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
    public partial class FormBooking : Form
    {
        string username;
        int time_flight = 0;
        int quantity_ex = 1;
        int priceService = 0;
        int priceFlight = 0;
        int priceTotal = 0;
        Boolean flag = false;

        string connection = "";
        public FormBooking()
        {
            InitializeComponent();
        }
        public void getConnection(string connect)
        {
            connection = connect;
        }

        public void data(string hhk_name, string city_from, string city_to, string price, string date_start, string time_start, string date_end, string time_end, string time_flight, string plane)
        {
            lb_company.Text = hhk_name;
            lb_plane.Text = plane;
            lb_from.Text = city_from;
            lb_to.Text = city_to;
            lb_price.Text = price;
            lb_date_start.Text = date_start;
            lb_time_start.Text = time_start;
            lb_date_end.Text = date_end;
            lb_time_end.Text = time_end;
            this.time_flight = int.Parse(time_flight);
            priceFlight = int.Parse(price);

            flag = true;
        }
        public void logUsername(string e)
        {
            this.username = e;
            lbName.Text = this.username;
        }
        private void FormBooking_Load(object sender, EventArgs e)
        {
            lb_username.Text = username;
            comboBox_from.Items.Clear();
            string sql = "select distinct TP_DI from dbo.LAYTHONGTIN()";
            // comboBox_from.DataSource = Dataprovider.Instance.GetDataToDataTable(sql, CommandType.TableDirect);
            // comboBox_from.DisplayMember = "TP_DI";
            priceTotal = priceService + priceFlight;
            DataTable data = Dataprovider.Instance.ExcuteQuery(sql, connection);
            for (int i = 0; i < data.Rows.Count; i++)
            {
                comboBox_from.Items.Add(data.Rows[i][0].ToString());
            }

            if (flag) 
            {
                comboBox_quantity.Items.Add("1");
                comboBox_quantity.Items.Add("2");
                comboBox_quantity.Items.Add("3");
                comboBox_quantity.Items.Add("4");
                comboBox_quantity.Items.Add("5");
                comboBox_quantity.SelectedIndex = 0;
            }
            timer.Start();

        }

        private void timer_Tick(object sender, EventArgs e)
        {
            lbTime.Text = DateTime.Now.ToString("hh:mm:ss tt");
            lbDay.Text = DateTime.Now.ToString("dd - MM - yyyy");
            lbDay.Font = new Font("Roboto", 14, FontStyle.Bold);
            lbDay.ForeColor = System.Drawing.Color.White;
            lbTime.Font = new Font("Roboto", 14, FontStyle.Bold);
            lbTime.ForeColor = System.Drawing.Color.White;
        }

        private void pictureBox3_Click(object sender, EventArgs e)
        {
            FormSearchcs f1 = new FormSearchcs();

            this.Hide();
            f1.logUsername(username);
            f1.getConnection(connection);
            f1.ShowDialog();
        }

        private void pictureBox5_Click(object sender, EventArgs e)
        {
            FormCart f1 = new FormCart();

            this.Hide();
            f1.logUsername(username);
            f1.getConnection(connection);
            f1.ShowDialog();
        }

        private void pictureBox7_Click(object sender, EventArgs e)
        {
            Form2 f1 = new Form2();

            this.Hide();
            f1.logUsername(username);
            f1.getConnection(connection);
            f1.ShowDialog();
        }

        private void panel6_Paint(object sender, PaintEventArgs e)
        {
        
        }

        private void getTime()
        {
            string time1 = lb_time_start.Text;
            string sql = " select distinct GioDen from dbo.LAYTHONGTIN() where TP_DI =N'"
                             + lb_from.Text + "' and TP_DEN= N'" + lb_to.Text + "' and TenHHK = '" + lb_company.Text
                                                           + "' and NgayBay = '" + lb_date_start.Text + "' and GioBay = '" + time1 + "'";
            DataTable dt = Dataprovider.Instance.ExcuteQuery(sql, connection);
            DateTime time = dt.Rows[0].Field<DateTime>(0);
            lb_date_end.Text = (time.Month + "/" + time.Day + "/" + time.Year).ToString();
            lb_time_end.Text = (time.Hour + ":" + time.Minute + ":00").ToString();
        }
        private void panel4_Paint(object sender, PaintEventArgs e)
        {
        }

        private void checkedListBox1_ItemCheck(object sender, ItemCheckEventArgs e)
        {
            if (e.NewValue == CheckState.Checked && checked_device.CheckedItems.Count > 0)
            {
                checked_device.ItemCheck -= checkedListBox1_ItemCheck;
                checked_device.SetItemChecked(checked_device.CheckedIndices[0], false);
                checked_device.ItemCheck += checkedListBox1_ItemCheck;
                lb_service.Text = checked_device.Text;
                string sql = "select dbo.PRICEDV('" + checked_device.Text + "')";
                int? priceTicket = Dataprovider.Instance.ExecuteScalar(sql, CommandType.Text, connection);
                priceService = int.Parse(priceTicket.ToString());
                if (comboBox_quantity.Items.Count > 0)
                {
                    int quantity = int.Parse(lb_quantity.Text);
                    priceTotal = (priceFlight + priceService) * quantity;

                }
                else
                {
                    priceTotal = (priceFlight + priceService);
                }
                
                lb_price.Text = priceTotal.ToString() ;
            }
        }
        private void comboBox_from_SelectedIndexChanged(object sender, EventArgs e)
        {
            
            lb_from.Text = comboBox_from.Text;
            lb_to.Text = "";
            lb_company.Text = "";
            lb_date_end.Text = "";
            lb_date_start.Text = "";
            lb_time_start.Text = "";
            lb_time_end.Text = "";
            lb_quantity.Text = "";
            lb_plane.Text = "";
            lb_price.Text = priceService.ToString() ;
            comboBox_to.Items.Clear();
            combox_company.Items.Clear();
            comboBox_date.Items.Clear();
            comboBox_time.Items.Clear();
            comboBox_quantity.Items.Clear();

            quantity_ex = 1;
            priceFlight = 0;
            string sql = " select distinct TP_DEN from dbo.LAYTHONGTIN() where TP_DI =N'" + lb_from.Text + "'";
            // comboBox_to.DataSource = Dataprovider.Instance.GetDataToDataTable(sql, CommandType.TableDirect);
            //  comboBox_to.DisplayMember = "TP_DEN";
            
            DataTable data = Dataprovider.Instance.ExcuteQuery(sql, connection);
            for (int i = 0; i < data.Rows.Count; i++)
            {
                comboBox_to.Items.Add(data.Rows[i][0].ToString());
            }
        }
        private void comboBox_to_SelectedIndexChanged(object sender, EventArgs e)
        {
            lb_company.Text = "";
            lb_date_end.Text = "";
            lb_date_start.Text = "";
            lb_time_start.Text = "";
            lb_time_end.Text = "";
            lb_quantity.Text = "";
            lb_plane.Text = "";
            lb_price.Text = priceService.ToString();
            combox_company.Items.Clear();
            comboBox_date.Items.Clear();
            comboBox_time.Items.Clear();
            comboBox_quantity.Items.Clear();
            lb_to.Text = comboBox_to.Text;

            quantity_ex = 1;
            priceFlight = 0;
            string sql = " select distinct TenHHK from dbo.LAYTHONGTIN() where TP_DI =N'"
                            + lb_from.Text + "' and TP_DEN= N'" + lb_to.Text + "'";
            // combox_company.DataSource = Dataprovider.Instance.GetDataToDataTable(sql, CommandType.TableDirect);
            //combox_company.DisplayMember = "TenHHK";
            DataTable data = Dataprovider.Instance.ExcuteQuery(sql, connection);
            for (int i = 0; i < data.Rows.Count; i++)
            {
                combox_company.Items.Add(data.Rows[i][0].ToString());
            }
        }

        private void combox_company_SelectedIndexChanged(object sender, EventArgs e)
        {
            lb_date_end.Text = "";
            lb_date_start.Text = "";
            lb_time_start.Text = "";
            lb_time_end.Text = "";
            lb_quantity.Text = "";
            lb_price.Text = priceService.ToString();
            comboBox_date.Items.Clear();
            comboBox_time.Items.Clear();
            comboBox_quantity.Items.Clear();
            lb_company.Text = combox_company.Text;

            quantity_ex = 1;
            priceFlight = 0;
            string sql = " select distinct NgayBay from dbo.LAYTHONGTIN() where TP_DI =N'"
                             + lb_from.Text + "' and TP_DEN= N'" + lb_to.Text + "' and TenHHK = '" + lb_company.Text + "'";
            DataTable data = Dataprovider.Instance.ExcuteQuery(sql, connection);
            for (int i = 0; i < data.Rows.Count; i++)
            {
                string[] date = data.Rows[i][0].ToString().Split(' ');
                comboBox_date.Items.Add(date[0]);
            }
          //  comboBox_date.DataSource = Dataprovider.Instance.GetDataToDataTable(sql, CommandType.TableDirect);
        //    comboBox_date.DisplayMember = "NgayBay";

            string sql_maybay = " select top 1 TenMB from dbo.LAYTHONGTIN() where TP_DI =N'"
                             + lb_from.Text + "' and TP_DEN= N'" + lb_to.Text + "' and TenHHK = '" + lb_company.Text + "'";
            DataTable maMB = Dataprovider.Instance.ExcuteQuery(sql_maybay, connection);
            string tenMB = maMB.Rows[0].Field<string>(0);
            lb_plane.Text = tenMB;
        }

        private void comboBox_date_SelectedIndexChanged(object sender, EventArgs e)
        {
            lb_date_end.Text = "";
            lb_time_start.Text = "";
            lb_time_end.Text = "";
            lb_quantity.Text = "";
            lb_price.Text = priceService.ToString();
            comboBox_time.Items.Clear();
            comboBox_quantity.Items.Clear();

            quantity_ex = 1;


            lb_date_start.Text = comboBox_date.Text;

            string sql = " select distinct GioBay from dbo.LAYTHONGTIN() where TP_DI =N'"
                             + lb_from.Text + "' and TP_DEN= N'" + lb_to.Text + "' and TenHHK = '" + lb_company.Text + "' and NgayBay='" + lb_date_start.Text + "'";
            comboBox_time.Items.Clear();
            DataTable data = Dataprovider.Instance.ExcuteQuery(sql, connection);
            for (int i = 0; i < data.Rows.Count; i++) 
            {
                comboBox_time.Items.Add(data.Rows[i][0].ToString());
            }
           // comboBox_time.DataSource = Dataprovider.Instance.GetDataToDataTable(sql, CommandType.TableDirect);
            //comboBox_time.DisplayMember = "GioBay";
            string priceDb = " select top 1 DonGia from dbo.LAYTHONGTIN() where TP_DI =N'" + lb_from.Text + "' and TP_DEN= N'" + lb_to.Text + "' and TenHHK = '" + lb_company.Text + "'";
            DataTable dt = Dataprovider.Instance.ExcuteQuery(priceDb, connection);
            priceFlight = dt.Rows[0].Field<int>(0);
            priceTotal = priceFlight + priceService;
            lb_price.Text = priceTotal.ToString() ;
        }
        
        private void comboBox_time_SelectedIndexChanged(object sender, EventArgs e)
        {
            quantity_ex = 1;
            lb_quantity.Text = "";
            lb_price.Text = priceService.ToString();
            comboBox_quantity.Items.Clear();
            lb_time_start.Text = comboBox_time.Text;
            comboBox_quantity.Items.Clear();
            getTime();
            comboBox_quantity.Items.Add("1");
            comboBox_quantity.Items.Add("2");
            comboBox_quantity.Items.Add("3");
            comboBox_quantity.Items.Add("4");
            comboBox_quantity.Items.Add("5");
            comboBox_quantity.SelectedIndex = 0;
            //MessageBox.Show(lb_time_start.Text);

        }
        private void comboBox_quantity_SelectedIndexChanged(object sender, EventArgs e)
        {
            lb_quantity.Text = comboBox_quantity.Text;
            priceTotal = (priceTotal/ quantity_ex) * (int.Parse(comboBox_quantity.Text));
            lb_price.Text = priceTotal.ToString() ;
            quantity_ex = int.Parse(comboBox_quantity.Text);
        }

        

        private void pictureBox21_Click(object sender, EventArgs e)
        {

            string sql = "select dbo.LAYMAKHACH('" + username + "')";

            int? maKH = Dataprovider.Instance.ExecuteScalar(sql, CommandType.Text, connection);
            string query = "DATVE";
            SqlParameter[] sqlpara = new SqlParameter[8];
            sqlpara[0] = new SqlParameter("@n", int.Parse(lb_quantity.Text));
            sqlpara[1] = new SqlParameter("@maKH", maKH);
            sqlpara[2] = new SqlParameter("@tenNoiDi", lb_from.Text);
            sqlpara[3] = new SqlParameter("@tenNoiDen", lb_to.Text);
            sqlpara[4] = new SqlParameter("@tenDV", lb_service.Text);
            sqlpara[5] = new SqlParameter("@tenHHK", lb_company.Text);
            sqlpara[6] = new SqlParameter("@ngayBay", lb_date_start.Text);
            sqlpara[7] = new SqlParameter("@gioBay", lb_time_start.Text);

            Dataprovider.Instance.ExecProc(query,connection, sqlpara);
            MessageBox.Show("Đặt vé thành công");

            string sql_timeflight = " select top 1 ThoiGianBay from dbo.LAYTHONGTIN() where TP_DI =N'"
                           + lb_from.Text + "' and TP_DEN= N'" + lb_to.Text + "'";

            DataTable dt = Dataprovider.Instance.ExcuteQuery(sql_timeflight, connection);

            time_flight = dt.Rows[0].Field<int>(0);

            this.getTime();
            FormVe f1 = new FormVe();
            f1.data(lb_from.Text, lb_to.Text, lb_service.Text,lb_date_start.Text, lb_time_start.Text,lb_date_end.Text, lb_time_end.Text, time_flight.ToString());
            
            f1.Show();
        }

        
    }
}
