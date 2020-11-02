using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Common.ExceptionHandling.ExceptionTypes
{
    public class UIException : Exception, ISerializable
    {
        public UIException()
            : base()
        {
            // Add implementation (if required)
        }

        public UIException(string message)
            : base(message)
        {
            // Add implemenation (if required)
        }

        public UIException(string message, System.Exception inner)
            : base(message, inner)
        {
            // Add implementation
        }

        protected UIException(SerializationInfo info, StreamingContext context)
            : base(info, context)
        {
            //Add implemenation
        }
    }
}
