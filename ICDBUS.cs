using System.Data;
using System.Collections.Generic;
using ToaThuoc.Repository;

namespace ToaThuoc.BUS
{
    public class ICDBUS
    {
        private ICDRepository _repo = new ICDRepository();
        private Dictionary<string, string> _dictICD = null;

        public Dictionary<string, string> LayICDDictionary()
        {
            if (_dictICD == null)
                _dictICD = _repo.GetAllICD();
            return _dictICD;
        }
    }
}