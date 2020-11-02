using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DTO
{
    public class RestaurantMenuItemsDTO
    {
        public RestaurantMenuItemsDTO()
        {
            this.MenuItemList = new List<MenuItemDTO>();
        }
        public int RestaurantID { get; set; }
        public int UserID { get; set; }
        public List<MenuItemDTO> MenuItemList { get; set; }
    }
}
