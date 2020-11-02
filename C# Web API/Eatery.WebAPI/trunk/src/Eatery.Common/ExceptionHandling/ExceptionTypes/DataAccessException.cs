using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Common.ExceptionHandling.ExceptionTypes
{
    public class DataAccessException : BaseException, ISerializable
    {
        public DataAccessException()
            : base()
        {
            // Add implementation (if required)
        }

        public DataAccessException(string message)
            : base(message)
        {
            // Add implemenation (if required)
        }

        public DataAccessException(string message, System.Exception inner)
            : base(message, inner)
        {
            // Add implementation
        }

        protected DataAccessException(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
            //Add implemenation
        }

    }
}
