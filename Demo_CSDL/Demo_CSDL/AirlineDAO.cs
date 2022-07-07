using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    public class AirlineDAO
    {
        private static AirlineDAO instance;
        public static AirlineDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new AirlineDAO();
                }
                return instance;
            }
            //set => instance = value;
        }
        public void Delete(string id, string connection)
        {
            string query = "DELETEHANGHANGKHONG";
            SqlParameter[] sqlpara = new SqlParameter[1];
            sqlpara[0] = new SqlParameter("@MaHHK", int.Parse(id));
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Insert(string[] para, string connection)
        {
            string query = "INSERTHANGHANGKHONG";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaHHK", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@TenHHK", para[1]);
            sqlpara[2] = new SqlParameter("@DonGiaHHK", int.Parse(para[2]));
            
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Update(string[] para, string connection)
        {
            string query = "UPDATEHANGHANGKHONG";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaHHK", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@TenHHK", para[1]);
            sqlpara[2] = new SqlParameter("@DonGiaHHK", int.Parse(para[2]));

            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public DataTable Find(string[] para, string connection)
        {
            para = Dataprovider.Instance.processdata(para);
            DataTable dt = new DataTable();
            string query = "exec FINDHANGHANGKHONG " + para[0] + ", N'" + para[1] + "'," + para[2];
            dt = Dataprovider.Instance.ExcuteQuery(query, connection);
            return dt;
        }
    }
}
