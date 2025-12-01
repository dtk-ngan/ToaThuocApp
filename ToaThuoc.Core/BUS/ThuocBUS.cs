using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using ToaThuoc.Core.Repository;

namespace ToaThuoc.Core.BUS
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
