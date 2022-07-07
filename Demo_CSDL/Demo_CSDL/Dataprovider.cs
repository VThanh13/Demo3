using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo_CSDL
{
    public class Dataprovider
    {

        private static Dataprovider instance;
        public static Dataprovider Instance
        {
            get
            {
                if (instance == null)
                {
                    instance = new Dataprovider();
                }
                return instance;
            }
            //set => instance = value;
        }

        public Dataprovider() { }

        string connect = @"Data Source=DESKTOP-5QAR7PK\SQLEXPRESS07;Initial Catalog=HEQTCSDL1;Integrated Security=True";
        

        public DataTable ExcuteQuery(string query , string connection_string)
        {
            DataTable table = new DataTable();
            if (connection_string.Length > 0)
                connect = connection_string;
            SqlConnection connection = new SqlConnection(connect);
            connection.Open();


            SqlDataAdapter adapter = new SqlDataAdapter(query, connection);


            adapter.Fill(table);


            connection.Close();

            return table;
        }

        public void ExecProc(string query, string connection_string, params SqlParameter[] pm)
        {
            if (connection_string.Length > 0)
                connect = connection_string;
            SqlConnection connection = new SqlConnection(connect);
            connection.Open();

            SqlCommand cmd = new SqlCommand(query, connection);
            cmd.CommandType = CommandType.StoredProcedure;

            foreach (SqlParameter a in pm)
            {
                cmd.Parameters.Add(a);
            }

            cmd.ExecuteNonQuery(); 

            connection.Close();
        }

        public int? ExecuteScalar(string sql, CommandType type, string connection_string)
        {
            if (connection_string.Length > 0)
                connect = connection_string;
            SqlConnection connection = new SqlConnection(connect);
            connection.Open();
            SqlCommand cmd = connection.CreateCommand();
            int? result = 0;
            cmd.CommandType = type;
            cmd.CommandText = sql;
            try
            {
                result = (int?)cmd.ExecuteScalar();
            }
            catch (SqlException)
            {

            }
            connection.Close();
            return result;
        }


        public DataTable GetDataToDataTable(string sqlExpess, CommandType type, string connection_string)
        {
            if (connection_string.Length > 0)
                connect = connection_string;
            SqlConnection connection = new SqlConnection(connect);
            connection.Open();
            DataTable table = new DataTable();
            SqlDataAdapter dataAdapter = new SqlDataAdapter(sqlExpess, connection);
            dataAdapter.Fill(table);
            connection.Close();
            return table;
        }

        public string[] processdata(string[] para) 
        {
            for(int i = 0; i< para.Count(); i++)
            {
                if (para[i].Length < 1)
                {
                    para[i] = "-1";
                }
            }
            return para;
        }
    }
}
