using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Common.ExceptionHandling.ExceptionTypes
{
    public class BaseException : Exception, ISerializable
    {
        public BaseException()
            : base()
        {
            // Add implementation (if required)
        }

        public BaseException(string message)
            : base(message)
        {
            // Add implementation (if required)
        }

        public BaseException(string message, System.Exception inner)
            : base(message, inner)
        {
            // Add implementation (if required)
        }

        protected BaseException(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
            // Add implementation (if required)
        }
    }
}
