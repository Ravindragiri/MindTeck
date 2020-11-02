using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DTO
{
    public class RegisterOwnerWithRestaurantDTO
    {
        public RegisterOwnerWithRestaurantDTO()
        {
            this.ResponseMessageDTO = new ResponseMessageDTO();
        }
        public RestaurantDTO RestaurantDTO { get; set; }
        public UserDTO UserDTO { get; set; }
        public ResponseMessageDTO ResponseMessageDTO { get; set; }

        
    }

    
}
