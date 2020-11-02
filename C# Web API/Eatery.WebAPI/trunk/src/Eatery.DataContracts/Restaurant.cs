using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DataContracts
{
    public class Restaurant
    {
        public int ID { get; set; }
        public int UserID { get; set; }
        //public string FirstName { get; set; }
        public decimal? Latitude { get; set; }
        public decimal? Longitude { get; set; }
        
        public string Province { get; set; }
        public string City { get; set; }
        public string Address { get; set; }
        public string PinCode { get; set; }
        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedDate { get; set; }
    }
}
