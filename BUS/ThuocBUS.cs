using System.Data;
using System.Collections.Generic;
using ToaThuoc.Repository;


namespace ToaThuoc.BUS
{
    public class ThuocBUS
    {
        private ThuocRepository _repo = new ThuocRepository();
        private DataTable _dtTenThuoc = null;

        public DataTable LayThongTinThuoc(string ten)
        {
            return _repo.GetThuocByTen(ten);
        }

        public DataTable AutoCompleteTenThuoc()
        {
            if (_dtTenThuoc == null)
                _dtTenThuoc = _repo.GetAllTenThuoc();
            return _dtTenThuoc;
        }
    }
}