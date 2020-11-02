using Eatery.Business.Interface;
using Eatery.Common;
using Eatery.DAL.Interface;
using Eatery.DAL.Repository.Interface;
using Eatery.DataContracts;
using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Business
{
    public class MenuItemRatingBL : IMenuItemRatingBL
    {
        private readonly IMenuItemRatingRepository _menuItemRatingRepository;
        private readonly IUnitOfWork _unitOfWork;

        public MenuItemRatingBL(
            IMenuItemRatingRepository menuItemRatingRepository,
            IUnitOfWork unitOfWork)
        {
            this._menuItemRatingRepository = menuItemRatingRepository;
            this._unitOfWork = unitOfWork;
        }

        public bool Add(MenuItemRatingDTO ratingDTO)
        {
            if (ratingDTO != null)
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {
                    MenuItemRating rating = ObjectTypeConverter.Convert<MenuItemRatingDTO, MenuItemRating>(ratingDTO);
                    //rating.CreatedBy = ratingDTO.userID;
                    //rating.CreatedDate = DateTime.Now;

                    this._menuItemRatingRepository.Add(context, rating);
                    _unitOfWork.Commit(context);

                    return true;
                }
            }
            return false;
        }

        public bool Remove(MenuItemRatingDTO ratingDTO)
        {
            if (ratingDTO != null)
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {
                    MenuItemRating rating = ObjectTypeConverter.Convert<MenuItemRatingDTO, MenuItemRating>(ratingDTO);

                    this._menuItemRatingRepository.Delete(context, rating);
                    _unitOfWork.Commit(context);

                    return true;
                }
            }
            return false;
        }
    }
}
