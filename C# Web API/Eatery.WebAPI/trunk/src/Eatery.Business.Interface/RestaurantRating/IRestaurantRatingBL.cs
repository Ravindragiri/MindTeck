using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Business.Interface
{
    public interface IRestaurantRatingBL
    {
        bool Add(RestaurantRatingDTO ratingDTO, int userID);
        bool Remove(RestaurantRatingDTO rating);
    }
}
