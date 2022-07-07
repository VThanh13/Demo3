using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    public class AirporDAO
    {
        private static AirporDAO instance;
        public static AirporDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new AirporDAO();
                }
                return instance;
            }
            //set => instance = value;
        }

        public void Delete(string id, string connection)
        {
            string query = "DELETESANBAY";
            SqlParameter[] sqlpara = new SqlParameter[1];
            sqlpara[0] = new SqlParameter("@MaSB", int.Parse(id));
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Insert(string[] para, string connection)
        {
            string query = "INSERTSANBAY";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaSB", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@MaTP", int.Parse(para[1]));
            sqlpara[2] = new SqlParameter("@TenSB", para[2]);
            sqlpara[3] = new SqlParameter("@IsLockedSB", para[3]);
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Update(string[] para, string connection)
        {
            string query = "UPDATESANBAY";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaSB", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@MaTP", int.Parse(para[1]));
            sqlpara[2] = new SqlParameter("@TenSB", para[2]);
            sqlpara[3] = new SqlParameter("@IsLockedSB", para[3]);
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public DataTable Find(string[] para, string connection)
        {
            para = Dataprovider.Instance.processdata(para);
            DataTable dt = new DataTable();
            string query = "exec FINDSANBAY " + para[0] + ", N'" + para[1] + "'," + para[2] + ",'" + para[3] + "'";
            dt = Dataprovider.Instance.ExcuteQuery(query, connection);
            return dt;
        }
    }
}
