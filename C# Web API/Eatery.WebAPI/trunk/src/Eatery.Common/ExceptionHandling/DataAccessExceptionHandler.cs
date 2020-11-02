using Eatery.Common.ExceptionHandling.ExceptionTypes;
using Microsoft.Practices.EnterpriseLibrary.ExceptionHandling;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Common.ExceptionHandling
{
    public class DataAccessExceptionHandler
    {
        public static bool HandleException(ref System.Exception ex)
        {
            bool rethrow = false;
            if ((ex is SqlException))
            {
                SqlException dbExp = (SqlException)ex;
                if (dbExp.Number >= 50000)
                {
                    rethrow = ExceptionPolicy.HandleException(ex, AppConstants.DataAccessCustomPolicy);
                    ex = new DataAccessCustomException(ex.Message);
                }
                else
                {
                    rethrow = ExceptionPolicy.HandleException(ex, AppConstants.DataAccessPolicy);
                    if (rethrow)
                    {
                        throw ex;
                    }
                }
            }
            else if (ex is System.Exception)
            {
                rethrow = ExceptionPolicy.HandleException(ex, "DataAccessPolicy");
                if (rethrow)
                {
                    throw ex;
                }
            }
            return rethrow;
        }
    }
}
