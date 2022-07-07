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
    public partial class FormCart : Form
    {
        string username;
        int priceMin = -1;
        int priceMax = -1;
        string origin = "-1";
        string destination = "-1";
        int condition = -1;
        string connection = "";
        public FormCart()
        {
            InitializeComponent();
        }

        List<Panel> listItem = new List<Panel>();


        List<Label> listDetail = new List<Label>();

        DataTable searchResult = new DataTable();

        public void getConnection(string connect)
        {
            connection = connect;
        }
        public void logUsername(string e)
        {
            this.username = e;
            lbName.Text = this.username;
        }
        private void FormCart_Load(object sender, EventArgs e)
        {
            timer.Start();

            //Thêm data vào cb condition
            comboBox_cond.Items.Clear();
            comboBox_cond.Items.Add("Waiting");
            comboBox_cond.Items.Add("Done");
       

            // Lấy thông tin nơi đi
            comboBox_from.Items.Clear();
            string originQuery = "select distinct TP_DI from dbo.LAYTHONGTIN()";
            DataTable originResult = Dataprovider.Instance.ExcuteQuery(originQuery, connection);

            // Đổ data vào cb nơi đi
            for (int i = 0; i < originResult.Rows.Count; i++)
            {
                comboBox_from.Items.Add(originResult.Rows[i][0].ToString());
            }

            string sql = "select dbo.LAYMAKHACH('" + username + "')";
            int? maKH = Dataprovider.Instance.ExecuteScalar(sql, CommandType.Text, connection);

            //para:0priceMin,1priceMax,2origin,3destination,4condition,5maKH
            string searchQuery = "SELECT * FROM LICHSUGIAODICH";
            //result: 0TenKH,1MaHD,2NgayGD,3TP_DI,4TP_DEN,5NgayBay,6GioBay,7ThanhTien,8SLVE,9Ngayden,10TrangThai
            searchResult = Dataprovider.Instance.ExcuteQuery(searchQuery, connection);

            loadBill();

            LoadData();
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

        private void pictureBox12_Click(object sender, EventArgs e)
        {
            CheckAllPrice();
            LoadData();
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
            f1.Show();
        }

        private void LoadData()
        {
           
            //Lấy mã KH
            string sql = "select dbo.LAYMAKHACH('" + username + "')";
            int? maKH = Dataprovider.Instance.ExecuteScalar(sql, CommandType.Text, connection);

            //para:0priceMin,1priceMax,2origin,3destination,4condition,5maKH
            string searchQuery = "exec SearchInfoHoaDon "
                + priceMin +
                ", '" + priceMax +
                "', N'" + origin +
                "', N'" + destination +
                "', '" + condition +
                "', '" + maKH + "'";

            //result: 0TenKH,1MaHD,2NgayGD,3TP_DI,4TP_DEN,5NgayBay,6GioBay,7ThanhTien,8SLVE,9Ngayden,10TrangThai
            searchResult = Dataprovider.Instance.ExcuteQuery(searchQuery, connection);

            loadBill();
        }

        private void comboBox_cond_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.condition = comboBox_cond.SelectedIndex;
        }

        private void comboBox_from_SelectedIndexChanged(object sender, EventArgs e)
        {
            comboBox_to.Items.Clear();

            string sql = " select distinct TP_DEN from dbo.LAYTHONGTIN() where TP_DI =N'" + comboBox_from.Text + "'";
            DataTable data = Dataprovider.Instance.ExcuteQuery(sql, connection);
            for (int i = 0; i < data.Rows.Count; i++)
            {
                comboBox_to.Items.Add(data.Rows[i][0].ToString());
            }

            origin = comboBox_from.Text;
        }


        private void comboBox_to_SelectedIndexChanged(object sender, EventArgs e)
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
            setPriceMinMax(2000000, -1);
        }
        private void checkBox2_CheckedChanged(object sender, EventArgs e)
        {
            checkBox1.Checked = false;
            checkBox3.Checked = false;
            setPriceMinMax(500000, 1000000);
        }
        private void checkBox3_CheckedChanged(object sender, EventArgs e)
        {
            checkBox2.Checked = false;
            checkBox1.Checked = false;
            setPriceMinMax(-1, 500000);
        }
        private void CheckAllPrice()
        {
            if (checkBox1.Checked == checkBox2.Checked == checkBox3.Checked == false)
                setPriceMinMax(-1, -1);
        }
        //check price end


        void loadBill() 
        {
            panel4.Controls.Clear();
            listItem.Clear();
            listDetail.Clear();

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
                lbOrigin.Location = new Point(66, YIn);


                Label lbTo = new Label();
                lbTo.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                lbTo.Text = "To:";
                lbTo.TextAlign = ContentAlignment.MiddleCenter;
                lbTo.Size = new Size(30, 35);
                lbTo.Location = new Point(210, YIn);


                Label lbDestination = new Label();
                lbDestination.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                lbDestination.Text = searchResult.Rows[i][4].ToString();
                lbDestination.TextAlign = ContentAlignment.MiddleLeft;
                lbDestination.Size = new Size(140, 35);
                lbDestination.Location = new Point(240, YIn);


                Label lbTime = new Label();
                lbTime.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                lbTime.Text = DateTime.Parse(searchResult.Rows[i][6].ToString()).ToString("HH:mm");
                lbTime.TextAlign = ContentAlignment.MiddleCenter;
                lbTime.Size = new Size(55, 35);
                lbTime.Location = new Point(380, YIn);

                Label lbDay = new Label();
                lbDay.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                lbDay.Text = searchResult.Rows[i][5].ToString().Split(' ')[0];
                lbDay.TextAlign = ContentAlignment.MiddleCenter;
                lbDay.Size = new Size(101, 35);
                lbDay.Location = new Point(430, YIn);

                Label lbCondition = new Label();
                lbCondition.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                if (searchResult.Rows[i][11].ToString() == "1")
                    lbCondition.Text = "Done";
                else
                    lbCondition.Text = "Waiting";
                lbCondition.TextAlign = ContentAlignment.MiddleCenter;
                lbCondition.Size = new Size(65, 35);
                lbCondition.Location = new Point(530, YIn);


                Label lbDetail = new Label();
                lbDetail.Font = new Font("SVN-Franko", 10, FontStyle.Bold);
                lbDetail.Text = "Detail";
                lbDetail.TextAlign = ContentAlignment.MiddleCenter;
                lbDetail.Size = new Size(65, 35);
                lbDetail.Location = new Point(595, YIn);
                lbDetail.Tag = i;

                lbDetail.Click += LbDetail_Click;


                listDetail.Add(lbDetail);


                listItem[i].Controls.Add(lbFrom);
                listItem[i].Controls.Add(lbTo);
                listItem[i].Controls.Add(lbOrigin);
                listItem[i].Controls.Add(lbDestination);
                listItem[i].Controls.Add(lbTime);
                listItem[i].Controls.Add(lbDay);
                listItem[i].Controls.Add(lbCondition);
                listItem[i].Controls.Add(listDetail[i]);

                YOut += 73;

                panel4.Controls.Add(listItem[i]);
            }
        }

        private void LbDetail_Click(object sender, EventArgs e)
        {
            Label lb = sender as Label;
            int i = (int)lb.Tag;
            //result: 0MaKH,1MaHD,2NgayGD,3TP_DI,4TP_DEN,5NgayBay,6GioBay,7ThanhTien,8SLVE,9Ngayden,10DichVu, 11TrangThai
            string maso = searchResult.Rows[i][1].ToString();
            string bill_date = DateTime.Parse(searchResult.Rows[i][2].ToString()).ToString("dd/MM/yyyy");
            string city_from = searchResult.Rows[i][3].ToString();
            string city_to = searchResult.Rows[i][4].ToString();
            string date_start = DateTime.Parse(searchResult.Rows[i][5].ToString()).ToString("dd/MM/yyyy");
            string time_start = DateTime.Parse(searchResult.Rows[i][6].ToString()).ToString("HH:mm");
            string price = searchResult.Rows[i][7].ToString();
            string quantity = searchResult.Rows[i][8].ToString();
            string date_end = DateTime.Parse(searchResult.Rows[i][9].ToString()).ToString("dd/MM/yyyy");
            string time_end = DateTime.Parse(searchResult.Rows[i][9].ToString()).ToString("HH:mm");
            string grade = searchResult.Rows[i][10].ToString();
            string trangthai = searchResult.Rows[i][11].ToString();

            Form_BillDetail f1 = new Form_BillDetail();
            f1.data(bill_date, city_from, city_to, grade, price, date_start, time_start, date_end, time_end, quantity, maso, trangthai);
            f1.getConnection(connection);
            f1.Show();

        }
    }
}
