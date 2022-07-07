using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    public class BillDAO
    {
        private static BillDAO instance;
        public static BillDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new BillDAO();
                }
                return instance;
            }
            //set => instance = value;
        }

        public void Delete(string id, string connection)
        {
            string query = "DELETEHOADON";
            SqlParameter[] sqlpara = new SqlParameter[1];
            sqlpara[0] = new SqlParameter("@MaHD", int.Parse(id));
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Insert(string[] para, string connection)
        {
            string query = "INSERTHOADON";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaHD", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@NgayGD", DateTime.Parse(para[1]));
            sqlpara[2] = new SqlParameter("@ThanhTien", int.Parse(para[2]));
            sqlpara[3] = new SqlParameter("@IsHuyHD", para[3]);
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Update(string[] para, string connection)
        {
            string query = "UPDATEHOADON";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaHD", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@NgayGD", DateTime.Parse(para[1]));
            sqlpara[2] = new SqlParameter("@ThanhTien", int.Parse(para[2]));
            sqlpara[3] = new SqlParameter("@IsHuyHD", para[3]);
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public DataTable Find(string[] para, string connection)
        {
            para = Dataprovider.Instance.processdata(para);
            DataTable dt = new DataTable();
            string query = "exec FINDHOADON " + para[0] + ",'" + para[1] + "'," + para[2] + ",'"+ para[3] +"'";
            dt = Dataprovider.Instance.ExcuteQuery(query, connection);
            return dt;
        }
    }
}
