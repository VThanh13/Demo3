using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Demo_CSDL
{
    public partial class FormSearchcs : Form
    {
        string username;
        int priceMin = -1;
        int priceMax = -1;
        string origin = "-1";
        string destination = "-1";
        string flightTime = "-1";
        string flightDate = "-1";
        string company = "-1";

        List<Label> listView = new List<Label>();

        List<Label> listBooking = new List<Label>();
       
        DataTable searchResult = new DataTable();

        string connection = "";
        public FormSearchcs()
        {
            InitializeComponent();
        }

        public void getConnection(string connect)
        {
            connection = connect;
        }

        public void logUsername(string e)
        {
            this.username = e;
            lbName.Text = this.username;
        }
        private void FormSearchcs_Load(object sender, EventArgs e)
        {
            // Lấy thông tin nơi đi
            comboBox_from.Items.Clear();
            string originQuery = "select distinct TP_DI from dbo.LAYTHONGTIN()";
            DataTable originResult = Dataprovider.Instance.ExcuteQuery(originQuery, connection);

            // Đổ data vào cb nơi đi
            for (int i = 0; i < originResult.Rows.Count; i++)
            {
                comboBox_from.Items.Add(originResult.Rows[i][0].ToString());
            }

            // Thêm items vào cb phân loại
            comboBox_cat.Items.Add("Hãng Hàng Không");
            comboBox_cat.Items.Add("Ngày Bay");
            comboBox_cat.Items.Add("Giờ Bay");


            string searchQuery = "SELECT * FROM CHUYENBAYHOATDONG";

            searchResult = Dataprovider.Instance.ExcuteQuery(searchQuery, connection);
            //Result: 0MaCB,1TenMB,2TenHHK,3TP_DI,4TP_DEN,5NgayBay,6GioBay,7ThoiGianBay,8DonGia,9SoVe,10SoVeTrong
            loadChuyenBay();

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

        private void label7_Click(object sender, EventArgs e)
        {

        }

        private void pictureBox12_Click(object sender, EventArgs e)
        {   
          

            CheckCB_cat();
            CheckAllPrice();
            //para: 0priceMin,1priceMax,2origin,3destination,4flightTime,5flightDate,6company
            string searchQuery = "exec SearchInfoChuyenBay " 
                + priceMin + 
                ", '" + priceMax + 
                "', N'" + origin + 
                "', N'" + destination + 
                "', N'"+ flightTime + 
                "', N'"  + flightDate + 
                "', N'" + company + "'";

            searchResult = Dataprovider.Instance.ExcuteQuery(searchQuery, connection);
            //Result: 0MaCB,1TenMB,2TenHHK,3TP_DI,4TP_DEN,5NgayBay,6GioBay,7ThoiGianBay,8DonGia,9SoVe,10SoVeTrong
            loadChuyenBay();


        }

        //open booking
        private void pictureBox4_Click(object sender, EventArgs e)
        {
            FormBooking f1 = new FormBooking();

            this.Hide();
            f1.logUsername(username);
            f1.getConnection(connection);
            f1.ShowDialog();
        }

        //open cart
        private void pictureBox5_Click(object sender, EventArgs e)
        {
            FormCart f1 = new FormCart();

            this.Hide();
            f1.logUsername(username);
            f1.getConnection(connection);
            f1.ShowDialog();
        }

        //open profile
        private void pictureBox7_Click(object sender, EventArgs e)
        {
            Form2 f1 = new Form2();

            this.Hide();
            f1.logUsername(username);
            f1.getConnection(connection);
            f1.ShowDialog();
        }

        private void ComboBox_from_SelectedIndexChanged(object sender, EventArgs e)
        {
            comboBox_to.Items.Clear();

            string sql = " select distinct TP_DEN from dbo.LAYTHONGTIN() where TP_DI =N'" + comboBox_from.Text + "'";
            DataTable data = Dataprovider.Instance.ExcuteQuery(sql, connection);
            for (int i = 0; i < data.Rows.Count; i++)
            {
                comboBox_to.Items.Add(data.Rows[i][0].ToString());
            }

            origin = comboBox_from.Text;
            destination = "-1";
        }

        private void ComboBox_to_SelectedIndexChanged(object sender, EventArgs e)
        {
            destination = comboBox_to.Text;
        }


        // check price: 1:>2tr,2:500k-1tr,3:<500k (VND)
        private void setPriceMinMax(int min, int max)
        {
            this.priceMin = min;
            this.priceMax = max;
        }
        private void checkBox1_CheckedChanged(object sender, EventArgs e)
        {
            
            checkBox2.Checked = false;
            checkBox3.Checked = false;
            if (checkBox1.Checked)
                setPriceMinMax(2000000, -1);
            else
                setPriceMinMax(-1, -1);
        }
        private void checkBox2_CheckedChanged(object sender, EventArgs e)
        {
            checkBox1.Checked = false;
            checkBox3.Checked = false;
            if (checkBox2.Checked)
                setPriceMinMax(500000, 1000000);
            else
                setPriceMinMax(-1, -1);
        }
        private void checkBox3_CheckedChanged(object sender, EventArgs e)
        {
            checkBox2.Checked = false;
            checkBox1.Checked = false;
            if (checkBox3.Checked)
                setPriceMinMax(-1, 500000);
            else
                setPriceMinMax(-1, -1);
        }
        private void CheckAllPrice()
        {
            if (checkBox1.Checked == checkBox2.Checked == checkBox3.Checked == false)
                setPriceMinMax(-1,-1);
        }
        //check price end

        private void CheckCB_cat ()
        {
            if (textBox1.Text != string.Empty)
            {
                switch (comboBox_cat.SelectedIndex)
                {
                    //0: HHK, 1: Ngay Bay, 2: Gio Bay
                    case 0:
                        company = textBox1.Text.ToString();
                        flightDate = "-1";
                        flightTime = "-1";
                        break;
                    case 1:
                        flightDate = textBox1.Text.ToString();
                        company = "-1";
                        flightTime = "-1";
                        break;
                    case 2:
                        flightTime = textBox1.Text.ToString();
                        company = "-1";
                        flightDate = "-1";
                        break;
                    default:
                        break;
                }
            }
            else 
            {
                company = "-1";
                flightDate = "-1";
                flightTime = "-1";
            }
        }

        void loadChuyenBay() {

            listBooking.Clear();

            List<Panel> listItem = new List<Panel>();
           
            panel4.Controls.Clear();
            int YIn = 14;
            int YOut = 9;

            for (int i = 0; i < searchResult.Rows.Count; i++)
            {
                Panel panelItem = new Panel();
                panelItem.BackgroundImage = Properties.Resources.Search_row;
                panelItem.BackgroundImageLayout = ImageLayout.Tile;
                panelItem.Size = new Size(666, 63);
                panelItem.Location = new Point(3, YOut);

                listItem.Add(panelItem);


                Label lbFrom = new Label();
                lbFrom.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                lbFrom.Text = "From:";
                lbFrom.TextAlign = ContentAlignment.MiddleCenter;
                lbFrom.Size = new Size(50, 35);
                lbFrom.Location = new Point(19, YIn);


                Label lbOrigin = new Label();
                lbOrigin.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                lbOrigin.Text = searchResult.Rows[i][3].ToString();
                lbOrigin.TextAlign = ContentAlignment.MiddleLeft;
                lbOrigin.Size = new Size(140, 35);
                lbOrigin.Location = new Point(65, YIn);


                Label lbTo = new Label();
                lbTo.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                lbTo.Text = "To:";
                lbTo.TextAlign = ContentAlignment.MiddleCenter;
                lbTo.Size = new Size(33, 35);
                lbTo.Location = new Point(189, YIn);


                Label lbDestination = new Label();
                lbDestination.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                lbDestination.Text = searchResult.Rows[i][4].ToString();
                lbDestination.TextAlign = ContentAlignment.MiddleLeft;
                lbDestination.Size = new Size(140, 35);
                lbDestination.Location = new Point(217, YIn);


                Label lbTime = new Label();
                lbTime.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                string[] time = searchResult.Rows[i][6].ToString().Split(':');
                lbTime.Text = time[0] + ":" + time[1];
                lbTime.TextAlign = ContentAlignment.MiddleCenter;
                lbTime.Size = new Size(93, 35);
                lbTime.Location = new Point(340, YIn);

                Label lbDay = new Label();
                lbDay.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                string[] datetime = searchResult.Rows[i][5].ToString().Split(' ');
                string[] date = datetime[0].Split('/');
                lbDay.Text = date[2]  +"-"+ (int.Parse(date[0]) <= 9 ? "0" + date[0] : date[0])  +"-"+ (int.Parse(date[1]) <= 9 ? "0" + date[1] : date[1]);
                lbDay.TextAlign = ContentAlignment.MiddleCenter;
                lbDay.Size = new Size(101, 35);
                lbDay.Location = new Point(439, YIn);

                Label lbView = new Label();
                lbView.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                lbView.Text = "View";
                lbView.TextAlign = ContentAlignment.MiddleCenter;
                lbView.Size = new Size(50, 35);
                lbView.Location = new Point(538, YIn);
                lbView.Tag = i;
                lbView.Click += lbView_Click;
                listView.Add(lbView);

                Label lbBooking = new Label();
                lbBooking.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                lbBooking.Text = "Booking";
                lbBooking.TextAlign = ContentAlignment.MiddleCenter;
                lbBooking.Size = new Size(65, 35);
                lbBooking.Location = new Point(590, YIn);
                lbBooking.Tag = i;
                lbBooking.Click += LbBooking_Click;
                listBooking.Add(lbBooking);


                listItem[i].Controls.Add(lbFrom);
                listItem[i].Controls.Add(lbTo);
                listItem[i].Controls.Add(lbOrigin);
                listItem[i].Controls.Add(lbDestination);
                listItem[i].Controls.Add(lbTime);
                listItem[i].Controls.Add(lbDay);
                listItem[i].Controls.Add(listView[i]);
                listItem[i].Controls.Add(listBooking[i]);

                YOut += 73;

                panel4.Controls.Add(listItem[i]);
            }
        }

        private void LbBooking_Click(object sender, EventArgs e)
        {
            int i = (int)(sender as Label).Tag;

            string plane = searchResult.Rows[i][1].ToString();
            string hhk_name = searchResult.Rows[i][2].ToString();
            string city_from = searchResult.Rows[i][3].ToString();
            string city_to = searchResult.Rows[i][4].ToString();
            string date_start = DateTime.Parse(searchResult.Rows[i][5].ToString()).ToString("MM/dd/yyyy");
            string time_start = DateTime.Parse(searchResult.Rows[i][6].ToString()).ToString("HH:mm");
            string time_flight = searchResult.Rows[i][7].ToString();
            string price = searchResult.Rows[i][8].ToString();
            string date_end = DateTime.Parse(searchResult.Rows[i][11].ToString()).ToString("MM/dd/yyyy");
            string time_end = DateTime.Parse(searchResult.Rows[i][11].ToString()).ToString("HH:mm");

            FormBooking f1 = new FormBooking();
            f1.logUsername(username);
            f1.data(hhk_name, city_from, city_to, price, date_start, time_start, date_end, time_end, time_flight, plane);
            this.Hide();
            f1.Show();
        }

        private void lbView_Click(object sender, EventArgs e)
        {
            
            int i = (int) (sender as Label).Tag;
           
            //string plane = searchResult.Rows[i][1].ToString();
            string hhk_name = searchResult.Rows[i][2].ToString();
            string city_from = searchResult.Rows[i][3].ToString();
            string city_to = searchResult.Rows[i][4].ToString();
            string date_start = DateTime.Parse(searchResult.Rows[i][5].ToString()).ToString("dd/MM/yyyy");
            string time_start = DateTime.Parse(searchResult.Rows[i][6].ToString()).ToString("HH:mm");
            string time_flight = searchResult.Rows[i][7].ToString();
            string price = searchResult.Rows[i][8].ToString();
            string date_end = DateTime.Parse(searchResult.Rows[i][11].ToString()).ToString("dd/MM/yyyy");
            string time_end = DateTime.Parse(searchResult.Rows[i][11].ToString()).ToString("HH:mm");

            Form_FlightDetail f1 = new Form_FlightDetail();
            f1.data(hhk_name, city_from, city_to, price, date_start, time_start, date_end, time_end, time_flight);
            f1.Show();
           
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {
            CheckCB_cat();
        }
    }
}
