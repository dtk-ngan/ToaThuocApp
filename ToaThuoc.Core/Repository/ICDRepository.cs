using System;
using System.Collections.Generic;
using System.Text;
using System.Data;

namespace ToaThuoc.Core.Repository
{
    public class ICDRepository
    {
        private DataAccess _db = new DataAccess();

        public Dictionary<string, string> GetAllICD()
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            DataTable dt = _db.Query("SELECT MaICD, MoTaICD FROM ICD ORDER BY MaICD");
            foreach (DataRow r in dt.Rows)
            {
                dic[r["MaICD"].ToString()] = r["MoTaICD"].ToString();
            }
            return dic;
        }
    }
}
