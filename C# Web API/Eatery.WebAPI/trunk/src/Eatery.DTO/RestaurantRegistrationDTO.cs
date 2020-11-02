﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DTO
{
    public class RestaurantRegistrationDTO
    {
        public RestaurantRegistrationDTO()
        {
            this.ResponseMessageDTO = new ResponseMessageDTO();
        }
        public RestaurantDTO RestaurantDTO { get; set; }
        public int UserID { get; set; }
        public ResponseMessageDTO ResponseMessageDTO { get; set; }
    }

    
}
