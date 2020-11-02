using Eatery.Common.ExceptionHandling.ExceptionTypes;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Common.ExceptionHandling
{
    public class BusinessLogicExceptionHandler
    {
        public static bool HandleException(ref System.Exception ex)
        {
            bool rethrow = false;
            if ((ex is DataAccessException) || (ex is DataAccessCustomException))
            {
                rethrow = ExceptionPolicy.HandleException(ex, AppConstants.PassThroughPolicy);
                ex = new PassThroughException(ex.Message);
            }
            else if (ex is BusinessLogicCustomException)
            {
                rethrow = ExceptionPolicy.HandleException(ex, AppConstants.BusinessLogicCustomPolicy);
            }
            else
            {
                rethrow = ExceptionPolicy.HandleException(ex, AppConstants.BusinessLogicPolicy);
            }
            if (rethrow)
            {
                throw ex;
            }
            return rethrow;
        }
    }
}
