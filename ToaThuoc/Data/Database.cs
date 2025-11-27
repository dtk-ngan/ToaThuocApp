using System;
using System.Data;
using System.Data.SqlClient;

namespace ToaThuoc.Data
{
    public class DataAccess
    {
        private static string _connectionString = @"Server=CNTT-DUPHONG11\SQLEXPRESS;Database=ToaThuocDB;Trusted_Connection=True;";

        public DataAccess(string connectionString)
        {
            _connectionString = _connectionString;
        }

        public DataTable Query(string sql, params SqlParameter[] parameters)
        {
            DataTable dt = new DataTable();
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(dt);
            }
            return dt;
        }

        public int Execute(string sql, params SqlParameter[] parameters)
        {
            using (SqlConnection conn = new SqlConnection(_connectionString))
            {
                SqlCommand cmd = new SqlCommand(sql, conn);

                if (parameters != null)
                    cmd.Parameters.AddRange(parameters);

                conn.Open();
                return cmd.ExecuteNonQuery();
            }
        }
    }
}