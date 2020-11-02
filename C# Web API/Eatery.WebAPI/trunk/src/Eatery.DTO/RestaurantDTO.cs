using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DTO
{
    public class RestaurantDTO
    {
        public RestaurantDTO()
        {
            this.MenuItemList = new List<MenuItemDTO>();
            this.OperationTimings = new List<OperationTimingDTO>();
        }

        public int? ID { get; set; }
        public int? UserID { get; set; }
        public string Province { get; set; }
        public string City { get; set; }
        public string Address { get; set; }
        public string PinCode { get; set; }

        public List<MenuItemDTO> MenuItemList { get; set; }

        public List<OperationTimingDTO> OperationTimings { get; set; }
    }
}
