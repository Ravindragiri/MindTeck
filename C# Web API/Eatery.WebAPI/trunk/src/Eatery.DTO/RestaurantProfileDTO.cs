using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DTO
{
    public class RestaurantProfileDTO
    {
        public UserDTO UserDTO { get; set; }
        public RestaurantDTO RestaurantDTO { get; set; }
        public ResponseMessageDTO ResponseMessageDTO { get; set; }
    }
}
