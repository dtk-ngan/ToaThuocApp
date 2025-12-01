using System;
using System.Collections.Generic;
using System.Text;
using ToaThuoc.Core.Repository;

namespace ToaThuoc.Core.BUS
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
