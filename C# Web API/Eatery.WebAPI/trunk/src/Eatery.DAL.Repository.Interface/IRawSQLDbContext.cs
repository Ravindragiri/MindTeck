using Eatery.DataContracts;
using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.DAL.Repository.Interface
{
    public interface IRawSQLDbContext
    {
        List<RestaurantSearchDTO> GetNearRestaurants(SearchCriteriaDTO criteria);
        List<RestaurantSearchDTO> GetRestaurantsByAnyCriteria(SearchCriteriaDTO criteria, string searchText);
        RestaurantProfileDTO GetRestaurantProfileInfo(int userID);
        List<MenuItemSearchDTO> GetNearMenuItems(SearchCriteriaDTO criteria);
        List<MenuItemSearchDTO> SearchMenuItems(SearchCriteriaDTO criteria);
        List<MenuItemSearchDTO> GetAllNearByMenuItems(SearchCriteriaDTO criteria);
        MenuItemSearchDTO GetMenuItemDetail(int MenuItemID, decimal latitude, decimal longitude);
    }
}
