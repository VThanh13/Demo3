using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace Demo_CSDL
{
    public class CustomerDAO
    {
        private static CustomerDAO instance;
        public static CustomerDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new CustomerDAO();
                }
                return instance;
            }
            //set => instance = value;
        }

        public void Delete(string id, string connection)
        {
            string query = "DELETEKHACHHANG";
            SqlParameter[] sqlpara = new SqlParameter[1];
            sqlpara[0] = new SqlParameter("@MaKH", int.Parse(id));
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Insert(string[] para, string connection)
        {
            string query = "INSERTKHACHHANG";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaKH",int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@TenKH", para[1]);
            if (para[2].Length > 0)
                sqlpara[2] = new SqlParameter("@NgaySinh",DateTime.Parse(para[2]));
            else
                sqlpara[2] = new SqlParameter("@NgaySinh", DBNull.Value);

            if(para[3].Length > 0)
               sqlpara[3] = new SqlParameter("@DiaChi", para[3]);
            else
               sqlpara[3] = new SqlParameter("@DiaChi", DBNull.Value);

            if(para[4].Length > 0)
                sqlpara[4] = new SqlParameter("@GioiTinh", para[4]);
            else
                sqlpara[4] = new SqlParameter("@GioiTinh", DBNull.Value);
            sqlpara[5] = new SqlParameter("@SDT", para[5]);
            sqlpara[6] = new SqlParameter("@EMAIL", para[6]);
            sqlpara[7] = new SqlParameter("@UserName", para[7]);
            sqlpara[8] = new SqlParameter("@MatKhau", para[8]);
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Update(string[] para, string connection)
        {
            string query = "UPDATEKHACHHANG";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaKH", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@TenKH", para[1]);
            if (para[2].Length > 0)
                sqlpara[2] = new SqlParameter("@NgaySinh", DateTime.Parse(para[2]));
            else
                sqlpara[2] = new SqlParameter("@NgaySinh", DBNull.Value);

            if (para[3].Length > 0)
                sqlpara[3] = new SqlParameter("@DiaChi", para[3]);
            else
                sqlpara[3] = new SqlParameter("@DiaChi", DBNull.Value);

            if (para[4].Length > 0)
                sqlpara[4] = new SqlParameter("@GioiTinh", para[4]);
            else
                sqlpara[4] = new SqlParameter("@GioiTinh", DBNull.Value);
            sqlpara[5] = new SqlParameter("@SDT", para[5]);
            sqlpara[6] = new SqlParameter("@EMAIL", para[6]);
            sqlpara[7] = new SqlParameter("@UserName", para[7]);
            sqlpara[8] = new SqlParameter("@MatKhau", para[8]);
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public DataTable Find(string[] para, string connection)
        {
            para = Dataprovider.Instance.processdata(para);
            DataTable dt = new DataTable();
            string query = "exec FINDKHACHHANG " + para[0] + ", N'" 
                + para[1] + "', '" + para[2] + "', N'" + para[3]+"', N'" 
                + para[4] + "', '" + para[5]+ "', '" + para[6] + "', '" + para[7] + "','" + para[8] + "'";
            dt = Dataprovider.Instance.ExcuteQuery(query, connection);
            return dt;
        }
    }
}
