using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    class TimeModel
    {
        DateTime thoiGianDen;
        int thoiGianBay;
        public TimeModel() { }
        public TimeModel (DateTime thoiGianDen, int thoiGianBay) {
            this.thoiGianDen = thoiGianDen;
            this.ThoiGianBay = thoiGianBay;
        }
        

        public DateTime ThoiGianDen { get => thoiGianDen; set => thoiGianDen = value; }
        public int ThoiGianBay { get => thoiGianBay; set => thoiGianBay = value; }
    }
}
