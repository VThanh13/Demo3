using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    public class CompanyDAO
    {
        private static CompanyDAO instance;
        public static CompanyDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new CompanyDAO();
                }
                return instance;
            }
            //set => instance = value;
        }

        public void Delete(string id, string connection)
        {
            string query = "DELETEHANGSANXUAT";
            SqlParameter[] sqlpara = new SqlParameter[1];
            sqlpara[0] = new SqlParameter("@MaHSX", int.Parse(id));
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Insert(string[] para, string connection)
        {
            string query = "INSERTHANGSANXUAT";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaHSX", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@TenHSX", para[1]);
            sqlpara[2] = new SqlParameter("@SLGhe", int.Parse(para[2]));

            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Update(string[] para, string connection)
        {
            string query = "UPDATEHANGSANXUAT";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaHSX", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@TenHSX", para[1]);
            sqlpara[2] = new SqlParameter("@SLGhe", int.Parse(para[2]));

            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public DataTable Find(string[] para, string connection)
        {
            para = Dataprovider.Instance.processdata(para);
            DataTable dt = new DataTable();
            string query = "exec FINDHANGSANXUAT " + para[0] + ", N'"+ para[1] + "'," + para[2] ;
            dt = Dataprovider.Instance.ExcuteQuery(query, connection);
            return dt;
        }
    }
}
