using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DTO
{
    public class MenuItemRatingDTO
    {
        public int? ID { get; set; }
        public int? userID { get; set; }
        public int MenuItemID { get; set; }
        public int RatingValue { get; set; }
    }
}
