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
    public partial class Form_FlightDetail : Form
    {
        string hhk_name;
        string city_from;
        string city_to;
        string price;
        string date_start;
        string time_start;
        string date_end;
        string time_end;
        string time_flight;


        public void data(string hhk_name, string city_from, string city_to, string price, string date_start, string time_start, string date_end, string time_end, string time_flight)
        {
            this.hhk_name = hhk_name;
            this.city_from = city_from;
            this.city_to = city_to;
            this.price = price;
            this.date_start = date_start;
            this.time_start = time_start;
            this.date_end = date_end;
            this.time_end = time_end;
            this.time_flight = time_flight;
        }
        public Form_FlightDetail()
        {
            InitializeComponent();
        }

        private void Form_FlightDetail_Load(object sender, EventArgs e)
        {
            lbHHK.Text = hhk_name;
            lb_from.Text = city_from;
            lb_to.Text = city_to;
            lb_price.Text = price;
            lb_date_start.Text = date_start;
            lb_time_start.Text = time_start;
            lb_date_end.Text = date_end;
            lb_time_end.Text = time_end;
            lb_time_flight.Text = time_flight + " m";
        }
    }
}
