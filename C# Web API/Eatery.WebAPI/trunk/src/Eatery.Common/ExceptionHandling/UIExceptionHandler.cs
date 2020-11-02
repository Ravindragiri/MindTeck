using Eatery.Common.ExceptionHandling.ExceptionTypes;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Common.ExceptionHandling
{
    public static class UIExceptionHandler
    {

        public static bool HandleException(ref System.Exception ex)
        {
            bool rethrow = false;
            try
            {
                if (ex is BaseException)
                {
                    // do nothing as Data Access or Business Logic exception has already been logged / handled
                }
                else
                {
                    rethrow = ExceptionPolicy.HandleException(ex, AppConstants.UIPolicy);
                }
            }
            catch (Exception exp)
            {
                ex = exp;
            }
            return rethrow;
        }
    }
}
