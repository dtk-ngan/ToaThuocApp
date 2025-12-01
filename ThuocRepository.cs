using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using ToaThuoc.Data;

namespace ToaThuoc.Repository
{
    public class ThuocRepository
    {
        private DataAccess _db = new DataAccess();

        public DataTable GetAllTenThuoc()
        {
            return _db.Query("SELECT TenThuocVaHamLuong FROM Thuoc");
        }

        public DataTable GetThuocByTen(string ten)
        {
            SqlParameter p = new SqlParameter("@ten", ten);
            return _db.Query("SELECT DonViTinh, PhuongThucSuDung FROM Thuoc WHERE TenThuocVaHamLuong=@ten", p);
        }
    }
}
