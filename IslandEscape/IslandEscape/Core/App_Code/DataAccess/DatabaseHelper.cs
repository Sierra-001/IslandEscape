using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace IslandEscape.Core.App_Code.DataAccess
{
    public static class DatabaseHelper
    {
        public static string GetConnectionString()
        {
            return ConfigurationManager.ConnectionStrings["IslandEscapeDB"].ConnectionString;
        }

        public static SqlConnection GetConnection()
        {
            SqlConnection conn = new SqlConnection(GetConnectionString());
            conn.Open();
            return conn;
        }

        public static int ExecuteNonQuery(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }
                    return cmd.ExecuteNonQuery();
                }
            }
        }

        public static object ExecuteScalar(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }
                    return cmd.ExecuteScalar();
                }
            }
        }

        public static DataTable ExecuteDataTable(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        return dt;
                    }
                }
            }
        }

        public static DataSet ExecuteDataSet(string query, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataSet ds = new DataSet();
                        adapter.Fill(ds);
                        return ds;
                    }
                }
            }
        }

        public static SqlDataReader ExecuteReader(string query, SqlParameter[] parameters = null)
        {
            SqlConnection conn = GetConnection();
            using (SqlCommand cmd = new SqlCommand(query, conn))
            {
                if (parameters != null)
                {
                    cmd.Parameters.AddRange(parameters);
                }
                return cmd.ExecuteReader(CommandBehavior.CloseConnection);
            }
        }

        public static SqlParameter CreateParameter(string name, object value)
        {
            return new SqlParameter(name, value ?? DBNull.Value);
        }

        public static SqlParameter CreateParameter(string name, SqlDbType type, object value)
        {
            SqlParameter param = new SqlParameter(name, type);
            param.Value = value ?? DBNull.Value;
            return param;
        }

        public static SqlParameter CreateParameter(string name, SqlDbType type, int size, object value)
        {
            SqlParameter param = new SqlParameter(name, type, size);
            param.Value = value ?? DBNull.Value;
            return param;
        }

        public static DataTable ExecuteStoredProcedure(string procedureName, SqlParameter[] parameters = null)
        {
            using (SqlConnection conn = GetConnection())
            {
                using (SqlCommand cmd = new SqlCommand(procedureName, conn))
                {
                    cmd.CommandType = CommandType.StoredProcedure;

                    if (parameters != null)
                    {
                        cmd.Parameters.AddRange(parameters);
                    }

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);
                        return dt;
                    }
                }
            }
        }
    }
}

#region Old DatabaseHelper
//using System;
//using System.Collections.Generic;
//using System.Configuration;
//using System.Data;
//using System.Data.SqlClient;
//using System.Linq;
//using System.Web;

//namespace IslandEscape.Core.App_Code.DataAccess
//{
//    public class DatabaseHelper
//    {
//        public static string GetConnectionString()
//        {
//            return ConfigurationManager.ConnectionStrings["IslandEscapeDB"].ConnectionString;
//        }

//        public static SqlConnection GetConnection()
//        {
//            SqlConnection conn = new SqlConnection(GetConnectionString());
//            conn.Open();
//            return conn;
//        }

//        public static int ExecuteNonQuery(string query, SqlParameter[] parameters = null)
//        {
//            using (SqlConnection conn = GetConnection())
//            using (SqlCommand cmd = new SqlCommand(query, conn))
//            {
//                if (parameters != null) cmd.Parameters.AddRange(parameters);
//                return cmd.ExecuteNonQuery();
//            }
//        }

//        public static object ExecuteScalar(string query, SqlParameter[] parameters = null)
//        {
//            using (SqlConnection conn = GetConnection())
//            using (SqlCommand cmd = new SqlCommand(query, conn))
//            {
//                if (parameters != null) cmd.Parameters.AddRange(parameters);
//                return cmd.ExecuteScalar();
//            }
//        }

//        public static DataTable ExecuteDataTable(string query, SqlParameter[] parameters = null)
//        {
//            using (SqlConnection conn = GetConnection())
//            using (SqlCommand cmd = new SqlCommand(query, conn))
//            {
//                if (parameters != null) cmd.Parameters.AddRange(parameters);
//                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
//                {
//                    DataTable dt = new DataTable();
//                    adapter.Fill(dt);
//                    return dt;
//                }
//            }
//        }

//        public static DataSet ExecuteDataSet(string query, SqlParameter[] parameters = null)
//        {
//            using (SqlConnection conn = GetConnection())
//            using (SqlCommand cmd = new SqlCommand(query, conn))
//            {
//                if (parameters != null) cmd.Parameters.AddRange(parameters);
//                using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
//                {
//                    DataSet ds = new DataSet();
//                    adapter.Fill(ds);
//                    return ds;
//                }
//            }
//        }

//        public static SqlParameter CreateParameter(string name, object value)
//        {
//            return new SqlParameter(name, value ?? DBNull.Value);
//        }
//    }
//}
#endregion