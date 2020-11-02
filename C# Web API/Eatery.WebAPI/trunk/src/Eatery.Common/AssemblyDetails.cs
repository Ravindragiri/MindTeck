using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Common
{
    public class AssemblyDetails
    {
        string _activatorClass;
        string _fullPath;
        public string ActivatorClass
        {
            get { return _activatorClass; }
            set { _activatorClass = value; }
        }
        public string FullPath
        {
            get { return _fullPath; }
            set { _fullPath = value; }
        }
    }
}
