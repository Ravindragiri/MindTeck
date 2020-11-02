using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Business.Interface
{
    public interface IMenuItemRatingBL
    {
        bool Add(MenuItemRatingDTO ratingDTO, int userID);
        bool Remove(MenuItemRatingDTO rating);
    }
}
