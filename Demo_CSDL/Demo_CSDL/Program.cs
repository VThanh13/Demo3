using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Demo_CSDL
{
    static class Program
    {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main()
        {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            Application.Run(new FormIntro());
            //Application.Run(new Form2());
            //Application.Run(new Form1());
            //Application.Run(new User_form());
            //Application.Run(new SignUpform());
            //Application.Run(new FormAdmin());
            //Application.Run(new FormSearchcs());
            //Application.Run(new FormBooking());
            //Application.Run(new FormCart());
            //Application.Run(new FormVe());
        }
    }
}
