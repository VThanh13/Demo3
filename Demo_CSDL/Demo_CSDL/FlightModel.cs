using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    class FlightModel
    {
        string city_to;
        string city_from;
        string time_start;
        string date_start;

        public FlightModel()
        {
        }
        public FlightModel(string city_to,
        string city_from,
        string time_start,
        string date_start)
        {
            this.city_to = city_to;
            this.city_from = city_from;
            this.date_start = date_start;
            this.time_start = time_start;
        }
        public string City_to { get => city_to; set => city_to = value; }
        public string City_from { get => city_from; set => city_from = value; }
        public string Time_start { get => time_start; set => time_start = value; }
        public string Date_start { get => date_start; set => date_start = value; }
    }


}
