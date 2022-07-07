using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    public class DetailDAO
    {
        private static DetailDAO instance;
        public static DetailDAO Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new DetailDAO();
                }
                return instance;
            }
            //set => instance = value;
        }

        public void Delete(string id1, string id2,string connection)
        {
            string query = "DELETECHITIETCHUYENBAY";
            SqlParameter[] sqlpara = new SqlParameter[2];
            sqlpara[0] = new SqlParameter("@MaCB", int.Parse(id1));
            sqlpara[1] = new SqlParameter("@MaMB", int.Parse(id2));
            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Insert(string[] para, string connection)
        {
            string query = "INSERTCHITIETCHUYENBAY";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaCB", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@MaMB", int.Parse(para[1]));
            sqlpara[2] = new SqlParameter("@NgayBay", DateTime.Parse(para[2]));
            sqlpara[3] = new SqlParameter("@GioBay", DateTime.Parse(para[3]));
            sqlpara[4] = new SqlParameter("@DonGia", int.Parse(para[4]));
            sqlpara[5] = new SqlParameter("@SoVe", int.Parse(para[5]));
            sqlpara[6] = new SqlParameter("@SoVeDaDat", int.Parse(para[6]));
            sqlpara[7] = new SqlParameter("@TrangThaiCB", para[7]);

            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public void Update(string[] para, string connection)
        {
            string query = "UPDATECHITIETCHUYENBAY";
            SqlParameter[] sqlpara = new SqlParameter[para.Length];
            sqlpara[0] = new SqlParameter("@MaCB", int.Parse(para[0]));
            sqlpara[1] = new SqlParameter("@MaMB", int.Parse(para[1]));
            sqlpara[2] = new SqlParameter("@NgayBay", DateTime.Parse(para[2]));
            sqlpara[3] = new SqlParameter("@GioBay", DateTime.Parse(para[3]));
            sqlpara[4] = new SqlParameter("@DonGia", int.Parse(para[4]));
            sqlpara[5] = new SqlParameter("@SoVe", int.Parse(para[5]));
            sqlpara[6] = new SqlParameter("@SoVeDaDat", int.Parse(para[6]));
            sqlpara[7] = new SqlParameter("@TrangThaiCB", para[7]);

            Dataprovider.Instance.ExecProc(query, connection, sqlpara);
        }
        public DataTable Find(string[] para, string connection)
        {
            para = Dataprovider.Instance.processdata(para);
            DataTable dt = new DataTable();
            string query = "exec FINDCHITIETCHUYENBAY " + para[0] + ", " + para[1] + ",'" + para[2]+"', '" +para[3] + "',"
                +para[4] + ", "+ para[5] +"," + para[6] +", '" + para[7] + "'";
            dt = Dataprovider.Instance.ExcuteQuery(query, connection);
            return dt;
        }
    }
}
