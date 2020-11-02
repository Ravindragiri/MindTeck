using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DataContracts
{
    public class RestaurantRating
    {
        public int? ID { get; set; }
        //public int? userID { get; set; }
        public int RestaurantID { get; set; }
        public int RatingValue { get; set; }

        public int? CreatedBy { get; set; }
        public DateTime? CreatedDate { get; set; }
        public int? UpdatedBy { get; set; }
        public DateTime? UpdatedDate { get; set; }
    }
}
