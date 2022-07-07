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
    
    public partial class Form1 : Form
    {

        string username;
        List<FlightModel> Flight = new List<FlightModel>();
        public Form1()
        {
            
            InitializeComponent();
        }

        string connection = "";

        public void getConnection(string connect)
        {
            connection = connect;
        }
        public void logUsername(string e)
        {
            this.username = e;
            lbName.Text = this.username ;
        }
        private void Form1_Load(object sender, EventArgs e)
        {
            timer.Start();

            string sql = "SELECT * FROM CHUYENBAYHOATDONG";
            DataTable dt = Dataprovider.Instance.ExcuteQuery(sql, connection);
            
            for(int i = 0; i< dt.Rows.Count; i++)
            {
                FlightModel flightModel = new FlightModel();
                flightModel.City_from = dt.Rows[i].Field<string>(3);
                flightModel.City_to = dt.Rows[i].Field<string>(4);
                flightModel.Date_start = dt.Rows[i].Field<DateTime>(5).ToString().Split(' ')[0];
                string[] time = dt.Rows[i][6].ToString().Split(':');
                flightModel.Time_start = time[0] + ":" + time[1];

                Flight.Add(flightModel);
            }
            ptbTic1_Click(sender, e);
        }

        private void timer_Tick(object sender, EventArgs e)
        {
            lbTime.Text = DateTime.Now.ToString("HH:mm:ss:tt");
            lbDay.Text = DateTime.Now.ToString("dd - MM - yyyy");
            lbDay.Font = new Font("SVN-Franko", 14, FontStyle.Bold);
            lbDay.ForeColor = System.Drawing.Color.White;
            lbTime.Font = new Font("SVN-Franko", 14, FontStyle.Bold);
            lbTime.ForeColor = System.Drawing.Color.White;
        }

        private void ptbTic1_Click(object sender, EventArgs e)
        {
            ptbTic1.BackgroundImage = Properties.Resources.Form_tic;
            ptbTic2.BackgroundImage = Properties.Resources.Form_nottic;
            ptbTic3.BackgroundImage = Properties.Resources.Form_nottic;
            ptbLogo1.Visible = true;
            ptbLogo2.Visible = false;
            ptbLogo3.Visible = false;

            FlightModel flightModel = Flight[0];
            lbOrigin.Text = flightModel.City_from;
            lbDes.Text = flightModel.City_to;
            lbFTime.Text = flightModel.Time_start;
            lbFDay.Text = flightModel.Date_start;
        }

        private void ptbTic2_Click(object sender, EventArgs e)
        {
            ptbTic2.BackgroundImage = Properties.Resources.Form_tic;
            ptbTic1.BackgroundImage = Properties.Resources.Form_nottic; 
            ptbTic3.BackgroundImage = Properties.Resources.Form_nottic; 
            ptbLogo1.Visible = false;
            ptbLogo2.Visible = true;
            ptbLogo3.Visible = false;


            FlightModel flightModel = Flight[1];
            lbOrigin.Text = flightModel.City_from;
            lbDes.Text = flightModel.City_to;
            lbFTime.Text = flightModel.Time_start;
            lbFDay.Text = flightModel.Date_start;
        }

        private void ptbTic3_Click(object sender, EventArgs e)
        {
            ptbTic3.BackgroundImage = Properties.Resources.Form_tic;
            ptbTic1.BackgroundImage = Properties.Resources.Form_nottic;
            ptbTic2.BackgroundImage = Properties.Resources.Form_nottic;
            ptbLogo1.Visible = false;
            ptbLogo2.Visible = false;
            ptbLogo3.Visible = true;

            FlightModel flightModel = Flight[2];
            lbOrigin.Text = flightModel.City_from;
            lbDes.Text = flightModel.City_to;
            lbFTime.Text = flightModel.Time_start;
            lbFDay.Text = flightModel.Date_start;
        }

        private void pictureBox7_Click(object sender, EventArgs e)
        {
            Form2 f1 = new Form2();

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

        private void lbOrigin_Click(object sender, EventArgs e)
        {

        }

        private void lbDes_Click(object sender, EventArgs e)
        {

        }

        private void lbFTime_Click(object sender, EventArgs e)
        {

        }

        private void lbFDay_Click(object sender, EventArgs e)
        {

        }
    }
}
