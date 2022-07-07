using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    public class FlightDAO
    {
        private static FlightDAO instance;
        public static FlightDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new FlightDAO();
                }
                return instance;
            }
            //set => instance = value;
        }

        public void Delete(string id, string connection)
        {
            string query = "DELETECHUYENBAY";
            SqlParameter[] sqlpara = new SqlParameter[1];
            sqlpara[0] = new SqlParameter("@MaCB", int.Parse(id));
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Insert(string[] para, string connection)
        {
            string query = "INSERTCHUYENBAY";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaCB", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@NoiDi", int.Parse(para[1]));
            sqlpara[2] = new SqlParameter("@NoiDen", int.Parse(para[2]));
            sqlpara[3] = new SqlParameter("@ThoiGianBay", int.Parse(para[3]));
            sqlpara[4] = new SqlParameter("@TrangThai", para[4]);

            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Update(string[] para, string connection)
        {
            string query = "UPDATECHUYENBAY";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaCB", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@NoiDi", int.Parse(para[1]));
            sqlpara[2] = new SqlParameter("@NoiDen", int.Parse(para[2]));
            sqlpara[3] = new SqlParameter("@ThoiGianBay", int.Parse(para[3]));
            sqlpara[4] = new SqlParameter("@TrangThai", para[4]);

            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public DataTable Find(string[] para, string connection)
        {
            para = Dataprovider.Instance.processdata(para);
            DataTable dt = new DataTable();
            string query = "exec FINDCHUYENBAY " + para[0] + "," + para[1] + "," + para[2] + "," + para[3] + ", '" + para[4] + "'" ;
            dt = Dataprovider.Instance.ExcuteQuery(query, connection);
            return dt;
        }
    }
}
