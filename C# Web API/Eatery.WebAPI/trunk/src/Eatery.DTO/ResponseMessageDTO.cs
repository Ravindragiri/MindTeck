using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DTO
{
    public class ResponseMessageDTO
    {
        public int StatusCode { get; set; }
        public string Message { get; set; }
        public List<Error> Errors { get; set; }
    }

    public class Error
    {
        public string Key { get; set; }
        public string Message { get; set; }
    }
}
