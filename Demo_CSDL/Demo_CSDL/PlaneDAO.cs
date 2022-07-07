using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    public class PlaneDAO
    {
        private static PlaneDAO instance;
        public static PlaneDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new PlaneDAO();
                }
                return instance;
            }
            //set => instance = value;
        }

        public void Delete(string id, string connection)
        {
            string query = "DELETEMAYBAY";
            SqlParameter[] sqlpara = new SqlParameter[1];
            sqlpara[0] = new SqlParameter("@MaMB", int.Parse(id));
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Insert(string[] para, string connection)
        {
            string query = "INSERTMAYBAY";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaMB", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@TenMB", para[1]);
            sqlpara[2] = new SqlParameter("@MaHHK", int.Parse(para[2]));
            sqlpara[3] = new SqlParameter("@MaHSX", int.Parse(para[3]));

            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Update(string[] para, string connection)
        {
            string query = "UPDATEMAYBAY";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaMB", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@TenMB", para[1]);
            sqlpara[2] = new SqlParameter("@MaHHK", int.Parse(para[2]));
            sqlpara[3] = new SqlParameter("@MaHSX", int.Parse(para[3]));

            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public DataTable Find(string[] para,string connection) 
        {
            para = Dataprovider.Instance.processdata(para);
            DataTable dt = new DataTable();
            string query = "exec FINDMAYBAY " + para[0] + ", N'" + para[1] + "', " + para[2] + "," + para[3];
            dt = Dataprovider.Instance.ExcuteQuery(query, connection);
            return dt;
        }
    }
}
