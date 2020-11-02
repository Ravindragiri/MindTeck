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
    public class RestaurantRatingBL : IRestaurantRatingBL
    {
        private readonly IRestaurantRatingRepository _restaurantRatingRepository;
        private readonly IUnitOfWork _unitOfWork;

        public RestaurantRatingBL(
            IRestaurantRatingRepository restaurantRatingRepository,
            IUnitOfWork unitOfWork)
        {
            this._restaurantRatingRepository = restaurantRatingRepository;
            this._unitOfWork = unitOfWork;
        }

        public bool Add(RestaurantRatingDTO ratingDTO, int userID)
        {
            if (ratingDTO != null)
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {
                    RestaurantRating rating = ObjectTypeConverter.Convert<RestaurantRatingDTO, RestaurantRating>(ratingDTO);
                    rating.CreatedBy = userID;
                    rating.CreatedDate = DateTime.Now;

                    this._restaurantRatingRepository.Add(context, rating);
                    _unitOfWork.Commit(context);

                    return true;
                }
            }
            return false;
        }

        public bool Remove(RestaurantRatingDTO ratingDTO)
        {
            if (ratingDTO != null)
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {
                    RestaurantRating rating = ObjectTypeConverter.Convert<RestaurantRatingDTO, RestaurantRating>(ratingDTO);

                    this._restaurantRatingRepository.Delete(context, rating);
                    _unitOfWork.Commit(context);

                    return true;
                }
            }
            return false;
        }
    }
}
