using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Business.Interface
{
    public interface IMenuItemBL
    {
        int Count();
        bool Add(MenuItemDTO MenuItemDTO, int userID);
        MenuItemDTO GetMenuItemById(int MenuItemID);
        List<MenuItemSearchDTO> GetNearMenuItems(SearchCriteriaDTO criteria);
        List<MenuItemSearchDTO> SearchMenuItems(SearchCriteriaDTO criteria);
        List<MenuItemSearchDTO> GetAllNearByMenuItems(SearchCriteriaDTO criteria);
        MenuItemSearchDTO GetMenuItemDetail(int MenuItemID, decimal latitude, decimal longitude);
        List<MenuItemDTO> GetMenuItemsByRestaurantID(int RestaurantID, int? page, int pageSize);
        MenuItemPublishDTO PublishMenuItem(MenuItemPublishDTO menuItempublishDTO, int? userID);
    }
}
