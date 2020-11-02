using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Common.ExceptionHandling.ExceptionTypes
{
    public class BusinessLogicException : BaseException, ISerializable
    {
        public BusinessLogicException()
            : base()
        {
            // Add implementation (if required)
        }

        public BusinessLogicException(string message)
            : base(message)
        {
            // Add Implementation (if required)
        }

        public BusinessLogicException(string message, System.Exception inner)
            : base(message, inner)
        {
            // Add implementation (if required)
        }

        protected BusinessLogicException(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
            // Add implementation (if required)
        }
    }
}
