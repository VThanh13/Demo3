using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    public class TicketDAO
    {
        private static TicketDAO instance;
        public static TicketDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new TicketDAO();
                }
                return instance;
            }
            //set => instance = value;
        }

        public void Delete(string id, string connection)
        {
            string query = "DELETEVE";
            SqlParameter[] sqlpara = new SqlParameter[1];
            sqlpara[0] = new SqlParameter("@MaVE", int.Parse(id));
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
    
        public void Insert(string[] para, string connection)
        {
            string query = "INSERTVE";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaVE", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@MaCB", int.Parse(para[1]));
            sqlpara[2] = new SqlParameter("@MaMB", int.Parse(para[2]));
            sqlpara[3] = new SqlParameter("@MaKH", int.Parse(para[3]));
            sqlpara[4] = new SqlParameter("@MaDV", int.Parse(para[4]));
            sqlpara[5] = new SqlParameter("@MaHD", int.Parse(para[5]));
            sqlpara[6] = new SqlParameter("@Ghe", int.Parse(para[6]));
            sqlpara[7] = new SqlParameter("@IsHuyVe", para[7]);

            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }

        public void Update(string[] para, string connection)
        {
            string query = "UPDATEVE";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaVE", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@MaCB", int.Parse(para[1]));
            sqlpara[2] = new SqlParameter("@MaMB", int.Parse(para[2]));
            sqlpara[3] = new SqlParameter("@MaKH", int.Parse(para[3]));
            sqlpara[4] = new SqlParameter("@MaDV", int.Parse(para[4]));
            sqlpara[5] = new SqlParameter("@MaHD", int.Parse(para[5]));
            sqlpara[6] = new SqlParameter("@Ghe", int.Parse(para[6]));
            sqlpara[7] = new SqlParameter("@IsHuyVe", para[7]);

            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public DataTable Find(string[] para, string connection)
        {
            para = Dataprovider.Instance.processdata(para);
            DataTable dt = new DataTable();
            string query = "exec FINDVE " + para[0] + "," + para[1] + "," + para[2] + "," 
                + para[3] + "," + para[4] + "," + para[5] + "," + para[6] + ", '" + para[7] + "'";
            dt = Dataprovider.Instance.ExcuteQuery(query, connection);
            return dt;
        }
    }
}
