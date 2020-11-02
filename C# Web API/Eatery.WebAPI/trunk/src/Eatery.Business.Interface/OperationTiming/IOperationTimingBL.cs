using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Business.Interface
{
    public interface IOperationTimingBL
    {
        bool Add(OperationTimingDTO operationTimingDTO, int userID);
    }
}
