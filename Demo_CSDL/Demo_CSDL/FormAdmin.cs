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
    public partial class FormAdmin : Form
    {
        public FormAdmin()
        {
            InitializeComponent();
        }

        string connection = "";
        
        List<Label> listLabel = new List<Label>();
        List<Panel> listPanel = new List<Panel>();
        List<TextBox> listTextBox = new List<TextBox>();

        string query = "";
         
        List<Item> listColumn = new List<Item>();

        int flag = 0;
        int flag_insert = 1;
        private void FormAdmin_Load(object sender, EventArgs e)
        {
            timer.Start();
        }

        public void getConnection( string connect) 
        {
            connection = connect;
        }

        void showPanel() {

            pnInfo.Controls.Clear();
            listLabel.Clear();
            listPanel.Clear();
            listTextBox.Clear();
            int X_point = 20;
            int Y_point = 19;
            for (int i = 0; i < listColumn.Count(); i++)
            {

                Label lbtemp = new Label();
                lbtemp.TextAlign = ContentAlignment.MiddleCenter;
                lbtemp.Font = new Font("Impact", 12, FontStyle.Regular);
                lbtemp.Location = new Point(X_point, Y_point);
                lbtemp.Size = new Size(90, 26);
                lbtemp.Text = listColumn[i].Value;

                listLabel.Add(lbtemp);

                Panel ptexttemp = new Panel();
                ptexttemp.BackgroundImage = Properties.Resources.Admin_texfield;
                ptexttemp.Location = new Point(X_point + 110, Y_point - 2);
                ptexttemp.Size = new Size(193, 29);
                ptexttemp.BackgroundImageLayout = ImageLayout.Tile;

                listPanel.Add(ptexttemp);

                TextBox tbtexttemp = new TextBox();
                tbtexttemp.Size = new Size(167, 13);
                tbtexttemp.BorderStyle = BorderStyle.None;
                tbtexttemp.Location = new Point(10, 7);
             

                listTextBox.Add(tbtexttemp);

                listPanel[i].Controls.Add(listTextBox[i]);

                if (i % 2 == 0)
                    X_point = 363;
                else
                {
                    X_point = 20;
                    Y_point += 43;
                }

                pnInfo.Controls.Add(listLabel[i]);
                pnInfo.Controls.Add(listPanel[i]);

            }

            if (listColumn.Count() % 2 != 0) 
            {
                Y_point += 43;
            }

            PictureBox ptbFind = new PictureBox()
            {
                Size = new Size(150, 56),
                Location = new Point(272, Y_point + 10),
                Image = Properties.Resources.Admin_file,
                SizeMode = PictureBoxSizeMode.CenterImage,
                BackgroundImageLayout = ImageLayout.Tile
            };

            PictureBox ptbtemp = new PictureBox()
            {
                Size = new Size(150, 30),
                Location = new Point(272, Y_point + 10 + 43),
                SizeMode = PictureBoxSizeMode.CenterImage,
                BackgroundImageLayout = ImageLayout.Tile
            };



            pnInfo.Controls.Add(ptbFind);
            pnInfo.Controls.Add(ptbtemp);

            ptbFind.Click += PtbFind_Click;

        }

        string[] getPara() 
        {
            string[] para = new string[listTextBox.Count()];
            for (int i = 0; i < listTextBox.Count(); i++)
                para[i] = listTextBox[i].Text;
            return para;
        }

        private void PtbFind_Click(object sender, EventArgs e)
        {
            switch (flag) 
            {
                case 1:
                    {
                        dtgv.DataSource = CustomerDAO.Instance.Find(getPara(), connection);
                        break;
                    }
                case 2:
                    {
                        dtgv.DataSource = PlaneDAO.Instance.Find(getPara(), connection);
                        break;
                    }
                case 3:
                    {
                        dtgv.DataSource = CompanyDAO.Instance.Find(getPara(), connection);
                        break;
                    }
                case 4:
                    {
                        dtgv.DataSource = CityDAO.Instance.Find(getPara(), connection);
                        break;
                    }
                case 5:
                    {
                        dtgv.DataSource = AirporDAO.Instance.Find(getPara(), connection);
                        break;
                    }
                case 6:
                    {
                        dtgv.DataSource = FlightDAO.Instance.Find(getPara(), connection);
                        break;
                    }
               case 7:
                    {
                        dtgv.DataSource = ServiceDAO.Instance.Find(getPara(), connection);
                        break;
                    }
                case 8:
                    {
                        dtgv.DataSource = TicketDAO.Instance.Find(getPara(), connection);
                        break;
                    }
                case 9:
                    {
                        dtgv.DataSource = AirlineDAO.Instance.Find(getPara(), connection);
                        break;
                    }
                case 10:
                    {

                        dtgv.DataSource = BillDAO.Instance.Find(getPara(), connection);
                        break;
                    }
                case 11:
                    {
                        dtgv.DataSource = DetailDAO.Instance.Find(getPara(), connection);
                        break;
                    }
            }
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
        void LoadData()
        {
           
            DataTable table = Dataprovider.Instance.ExcuteQuery(query, connection);

            dtgv.DataSource = table;

            dtgv.CellClick += DataGridView1_CellClick;

            showPanel();

        }

        void showData()
        {
            try
            {
                if (dtgv.Rows.Count < 1)
                    throw new Exception();
                int id = dtgv.CurrentCell.RowIndex;
                for (int i = 0; i < listTextBox.Count; i++)
                {
                    if (dtgv.Rows[id].Cells[0].Value.ToString().Length > 0)
                    {
                        if (listColumn[i].Key == 10 && dtgv.Rows[id].Cells[i].Value.ToString().Length > 0)
                        {
                            DateTime d = DateTime.Parse(dtgv.Rows[id].Cells[i].Value.ToString());
                            string day = d.Day > 10 ? d.Day.ToString() : "0" + d.Day.ToString();
                            string month = d.Month > 10 ? d.Month.ToString() : "0" + d.Month.ToString();
                            listTextBox[i].Text = d.Year.ToString() + "-" + month + "-" + day;
                        }
                        else
                        {
                            listTextBox[i].Text = dtgv.Rows[id].Cells[i].Value.ToString();
                        }
                    }
                }
            }
            catch
            {
                MessageBox.Show("Chưa có dữ liệu!!!");
            }
           
        }

        private void ptbLoad_Click(object sender, EventArgs e)
        {
            try
            {
                LoadData();
            }
            catch (Exception)
            {
                MessageBox.Show("Vui lòng chọn bảng trước");
            }
            
        }


        private void DataGridView1_CellClick(object sender, DataGridViewCellEventArgs e)
        {
            showData();
        }

        private void ptbCustomer_Click(object sender, EventArgs e)
        {
            flag = 1;
            listColumn.Clear();

            listColumn.Add(new Item(1, "ID"));
            listColumn.Add(new Item(2, "Name"));
            listColumn.Add(new Item(10, "Birthday"));
            listColumn.Add(new Item(4, "Address"));
            listColumn.Add(new Item(5, "Sex"));
            listColumn.Add(new Item(6, "Phone"));
            listColumn.Add(new Item(7, "Email"));
            listColumn.Add(new Item(8, "User Name"));
            listColumn.Add(new Item(9, "Password"));

            query = "Select * from INFOKHACHHANG";
          
            LoadData();
           
        }

        private void ptbPlane_Click(object sender, EventArgs e)
        {
            flag = 2;
            listColumn.Clear();

            listColumn.Add(new Item(1, "ID"));
            listColumn.Add(new Item(2, "Name"));
            listColumn.Add(new Item(3, "Airlines"));
            listColumn.Add(new Item(4, "Manufacturer"));

            query = "Select * from INFOMAYBAY";
           
            LoadData();
        }

        private void ptbCompany_Click(object sender, EventArgs e)
        {
            flag = 3;
            listColumn.Clear();

            listColumn.Add(new Item(1,"ID"));
            listColumn.Add(new Item(2,"Name"));
            listColumn.Add(new Item(3, "Quantity"));

            query = "Select * from INFOHANGSANXUAT";
     
            LoadData();
        }

        private void ptbCity_Click(object sender, EventArgs e)
        {
            flag = 4;
            listColumn.Clear();

            listColumn.Add(new Item(1, "ID"));
            listColumn.Add(new Item(2, "Name"));
            listColumn.Add(new Item(3, "Is Locked"));

            query = "Select * from INFOTHANHPHO";

            LoadData();
        }

        private void ptbAirport_Click(object sender, EventArgs e)
        {
            flag = 5;
            listColumn.Clear();

            listColumn.Add(new Item(1, "ID"));
            listColumn.Add(new Item(2, "Name"));
            listColumn.Add(new Item(3, "City"));
            listColumn.Add(new Item(4, "Is Locked"));

            query = "Select * from INFOSANBAY";

            LoadData();
        }

        private void ptbFlight_Click(object sender, EventArgs e)
        {
            flag = 6;
            listColumn.Clear();

            listColumn.Add(new Item(1, "ID"));
            listColumn.Add(new Item(2, "Origin"));
            listColumn.Add(new Item(3, "Destination"));
            listColumn.Add(new Item(4, "Time"));
            listColumn.Add(new Item(5, "Status"));

            query = "Select * from INFOCHUYENBAY";

            LoadData();
        }

        private void ptbService_Click(object sender, EventArgs e)
        {
            flag = 7;
            listColumn.Clear();

            listColumn.Add(new Item(1, "ID"));
            listColumn.Add(new Item(2, "Name"));
            listColumn.Add(new Item(3, "Price"));

            query = "Select * from INFODICHVU";
  
            LoadData();
        }

        private void ptbTicket_Click(object sender, EventArgs e)
        {
            flag = 8;
            listColumn.Clear();

            listColumn.Add(new Item(1, "ID"));
            listColumn.Add(new Item(2, "Flight"));
            listColumn.Add(new Item(3, "Plane"));
            listColumn.Add(new Item(4, "Customer"));
            listColumn.Add(new Item(5, "Service"));
            listColumn.Add(new Item(6, "Bill"));
            listColumn.Add(new Item(7, "Seat"));
            listColumn.Add(new Item(8, "Price"));
            listColumn.Add(new Item(9, "Is Cancel"));

            query = "Select * from INFOVE";

            LoadData();
        }

        private void ptbAirlines_Click(object sender, EventArgs e)
        {
            flag = 9;
            listColumn.Clear();

            listColumn.Add(new Item(1, "ID"));
            listColumn.Add(new Item(2, "Name"));
            listColumn.Add(new Item(3, "Price"));

            query = "Select * from INFOHANGHANGKHONG";

            LoadData();
        }

        private void ptbBill_Click(object sender, EventArgs e)
        {
            flag = 10;
            listColumn.Clear();

            listColumn.Add(new Item(1, "ID"));
            listColumn.Add(new Item(10, "Date"));
            listColumn.Add(new Item(3, "Price"));
            listColumn.Add(new Item(4, "Is Cancel"));

            query = "Select * from INFOHOADON";
    
            LoadData();
        }

        private void ptbDetail_Click(object sender, EventArgs e)
        {
            flag = 11;
            listColumn.Clear();

            listColumn.Add(new Item(1, "Flight"));
            listColumn.Add(new Item(2, "Plane"));
            listColumn.Add(new Item(10, "Date"));
            listColumn.Add(new Item(4, "Time"));
            listColumn.Add(new Item(5, "Price"));
            listColumn.Add(new Item(6,"Quantity"));
            listColumn.Add(new Item(7, "Seat on"));
            listColumn.Add(new Item(8, "Status"));

            query = "Select * from INFOCHITIETCHUYENBAY";
  
            LoadData();
        }

        private void ptbAdd_Click(object sender, EventArgs e)
        {
            flag_insert = 1;
            for (int i = 0; i < listTextBox.Count; i++)
            {
                listTextBox[i].Text = "";
            }
        }
        private void ptbEdit_Click(object sender, EventArgs e)
        {
             showData();
             flag_insert = 0;
        }
        private void ptbSave_Click(object sender, EventArgs e)
        {
            switch (flag)
            {
                case 1:
                    {
                        if (flag_insert == 1)
                        {
                            try
                            {
                                CustomerDAO.Instance.Insert(getPara(), connection);
                                MessageBox.Show("Thêm thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }

                        }
                        else
                        {
                            try
                            {
                                CustomerDAO.Instance.Update(getPara(), connection);
                                MessageBox.Show("Sửa thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }
                        }
                        break;
                    }
                case 2:
                    {
                        if (flag_insert == 1)
                        {
                            try
                            {
                                PlaneDAO.Instance.Insert(getPara(), connection);
                                MessageBox.Show("Thêm thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }

                        }
                        else
                        {
                            try
                            {
                                PlaneDAO.Instance.Update(getPara(), connection);
                                MessageBox.Show("Sửa thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }
                        }
                        break;
                    }
                case 3:
                    {
                        if (flag_insert == 1)
                        {
                            try
                            {
                                CompanyDAO.Instance.Insert(getPara(), connection);
                                MessageBox.Show("Thêm thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }

                        }
                        else
                        {
                            try
                            {
                                CompanyDAO.Instance.Update(getPara(), connection);
                                MessageBox.Show("Sửa thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }
                        }
                        break;
                    }
                case 4:
                    {
                        if (flag_insert == 1)
                        {
                            try
                            {
                                CityDAO.Instance.Insert(getPara(), connection);
                                MessageBox.Show("Thêm thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }

                        }
                        else
                        {
                            try
                            {
                                CityDAO.Instance.Update(getPara(), connection);
                                MessageBox.Show("Sửa thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }
                        }
                        break;
                    }
                case 5:
                    {
                        if (flag_insert == 1)
                        {
                            try
                            {
                                AirporDAO.Instance.Insert(getPara(), connection);
                                MessageBox.Show("Thêm thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }

                        }
                        else
                        {
                            try
                            {
                                AirporDAO.Instance.Update(getPara(), connection);
                                MessageBox.Show("Sửa thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }
                        }
                        break;
                    }
                case 6:
                    {
                        if (flag_insert == 1)
                        {
                            try
                            {
                                FlightDAO.Instance.Insert(getPara(), connection);
                                MessageBox.Show("Thêm thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }

                        }
                        else
                        {
                            try
                            {
                                FlightDAO.Instance.Update(getPara(), connection);
                                MessageBox.Show("Sửa thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }
                        }
                        break;
                    }
                case 7:
                    {
                        if (flag_insert == 1)
                        {
                            try
                            {
                                ServiceDAO.Instance.Insert(getPara(), connection);
                                MessageBox.Show("Thêm thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }

                        }
                        else
                        {
                            try
                            {
                                ServiceDAO.Instance.Update(getPara(), connection);
                                MessageBox.Show("Sửa thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }
                        }
                        break;
                    }
                case 8:
                    {
                        if (flag_insert == 1)
                        {
                            try
                            {
                                TicketDAO.Instance.Insert(getPara(), connection);
                                MessageBox.Show("Thêm thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }

                        }
                        else
                        {
                            try
                            {
                                TicketDAO.Instance.Update(getPara(), connection);
                                MessageBox.Show("Sửa thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }
                        }
                        break;
                    }
                case 9:
                    {
                        if (flag_insert == 1)
                        {
                            try
                            {
                                AirlineDAO.Instance.Insert(getPara(), connection);
                                MessageBox.Show("Thêm thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }

                        }
                        else
                        {
                            try
                            {
                                AirlineDAO.Instance.Update(getPara(), connection);
                                MessageBox.Show("Sửa thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }
                        }
                        break;
                    }
                case 10:
                    {

                        if (flag_insert == 1)
                        {
                            try
                            {
                                BillDAO.Instance.Insert(getPara(), connection);
                                MessageBox.Show("Thêm thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }

                        }
                        else
                        {
                            try
                            {
                                BillDAO.Instance.Update(getPara(), connection);
                                MessageBox.Show("Sửa thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }
                        }
                        break;
                    }
                case 11:
                    {
                        if (flag_insert == 1)
                        {
                            try
                            {
                                DetailDAO.Instance.Insert(getPara(), connection);
                                MessageBox.Show("Thêm thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }

                        }
                        else
                        {
                            try
                            {
                                DetailDAO.Instance.Update(getPara(), connection);
                                MessageBox.Show("Sửa thành công");
                                LoadData();
                            }
                            catch (Exception ex)
                            {
                                MessageBox.Show("Lỗi" + ex.Message);
                            }
                        }
                        break;
                    }
            }
        }
        private void ptbDel_Click(object sender, EventArgs e)
        {
            switch (flag)
            {
                case 1:
                    {
                        try
                        {
                            CustomerDAO.Instance.Delete(getPara()[0], connection);
                            MessageBox.Show("Xóa thành công");
                            LoadData();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Lỗi" + ex.Message);
                        }
                        break;
         
                    }
                case 2:
                    {
                        try
                        {
                            PlaneDAO.Instance.Delete(getPara()[0], connection);
                            MessageBox.Show("Xóa thành công");
                            LoadData();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Lỗi" + ex.Message);
                        }
                        break;

                    }
                case 3:
                    {
                        try
                        {
                            CompanyDAO.Instance.Delete(getPara()[0], connection);
                            MessageBox.Show("Xóa thành công");
                            LoadData();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Lỗi" + ex.Message);
                        }
                        break;

                    }
                case 4:
                    {
                        try
                        {
                            CityDAO.Instance.Delete(getPara()[0], connection);
                            MessageBox.Show("Xóa thành công");
                            LoadData();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Lỗi" + ex.Message);
                        }
                        break;

                    }
                case 5:
                    {
                        try
                        {
                            AirporDAO.Instance.Delete(getPara()[0], connection);
                            MessageBox.Show("Xóa thành công");
                            LoadData();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Lỗi" + ex.Message);
                        }
                        break;

                    }
                case 6:
                    {
                        try
                        {
                            FlightDAO.Instance.Delete(getPara()[0], connection);
                            MessageBox.Show("Xóa thành công");
                            LoadData();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Lỗi" + ex.Message);
                        }
                        break;

                    }
                case 7:
                    {
                        try
                        {
                            ServiceDAO.Instance.Delete(getPara()[0], connection);
                            MessageBox.Show("Xóa thành công");
                            LoadData();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Lỗi" + ex.Message);
                        }
                        break;

                    }
                case 8:
                    {
                        try
                        {
                            TicketDAO.Instance.Delete(getPara()[0], connection);
                            MessageBox.Show("Xóa thành công");
                            LoadData();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Lỗi" + ex.Message);
                        }
                        break;

                    }
                case 9:
                    {
                        try
                        {
                            AirlineDAO.Instance.Delete(getPara()[0], connection);
                            MessageBox.Show("Xóa thành công");
                            LoadData();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Lỗi" + ex.Message);
                        }
                        break;

                    }
                case 10:
                    {

                        try
                        {
                            BillDAO.Instance.Delete(getPara()[0], connection);
                            MessageBox.Show("Xóa thành công");
                            LoadData();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Lỗi" + ex.Message);
                        }
                        break;

                    }
                case 11:
                    {
                        try
                        {
                            string[] para = getPara();
                            DetailDAO.Instance.Delete(para[0], para[1], connection);
                            MessageBox.Show("Xóa thành công");
                            LoadData();
                        }
                        catch (Exception ex)
                        {
                            MessageBox.Show("Lỗi" + ex.Message);
                        }
                        break;

                    }
            }
        }
        private void ptbStop_Click(object sender, EventArgs e)
        {
            showData();
        }
    }
}
