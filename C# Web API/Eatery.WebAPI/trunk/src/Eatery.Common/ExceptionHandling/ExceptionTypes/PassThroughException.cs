using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Common.ExceptionHandling.ExceptionTypes
{
    public class PassThroughException : BaseException, ISerializable
    {
        public PassThroughException()
            : base()
        {
            // Add implementation (if required)
        }

        public PassThroughException(string message)
            : base(message)
        {
            // Add implemenation (if required)
        }

        public PassThroughException(string message, System.Exception inner)
            : base(message, inner)
        {
            // Add implementation
        }

        protected PassThroughException(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
            //Add implemenation
        }
    }
}
