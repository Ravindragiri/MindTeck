using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Business.Interface
{
    public interface IRestaurantBL
    {
        List<RestaurantDTO> SearchRestaurants(SearchCriteriaDTO searchCriteria);
        RestaurantRegistrationDTO Register(RestaurantRegistrationDTO RestaurantRegistrationDTO);
        RestaurantRegistrationDTO RegisterRestaurant(RestaurantRegistrationDTO RestaurantRegistrationDTO);
        RestaurantDTO GetRestaurantById(int RestaurantID);
        List<RestaurantSearchDTO> GetNearRestaurants(SearchCriteriaDTO criteria);
        List<RestaurantSearchDTO> GetRestaurantsByAnyCriteria(SearchCriteriaDTO criteria, string searchText);
        int Count();
        RestaurantProfileDTO GetRestaurantProfileInfo(int userID);
        RestaurantDTO GetRestaurantByUserID(int userID);
    }
}
