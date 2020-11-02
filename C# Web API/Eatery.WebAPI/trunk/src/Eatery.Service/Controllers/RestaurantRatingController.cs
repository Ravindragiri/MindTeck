using Eatery.Business.Interface;
using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace Eatery.Service.Controllers
{
    public class RestaurantRatingController : ApiController
    {
        public readonly IRestaurantRatingBL _restaurantRatingBL;
        public RestaurantRatingController(IRestaurantRatingBL restaurantRatingBL)
        {
            this._restaurantRatingBL = restaurantRatingBL;
        }

        [HttpPost]
        public IHttpActionResult Add(RestaurantRatingDTO ratingDTO, int userID)
        {
            bool rtnVal = false;

            if (ratingDTO != null)
            {
                try
                {
                    if (!ModelState.IsValid)
                    {
                        return BadRequest(ModelState);
                    }
                    rtnVal = this._restaurantRatingBL.Add(ratingDTO, userID);
                }
                catch (Exception ex)
                {
                    return InternalServerError(ex);
                }
            }
            return Ok(rtnVal);
        }

        [HttpPost]
        public IHttpActionResult Remove(RestaurantRatingDTO ratingDTO)
        {
            bool rtnVal = false;
            if (ratingDTO != null)
            {
                try
                {
                    if (!ModelState.IsValid)
                    {
                        return BadRequest(ModelState);
                    }
                    rtnVal = this._restaurantRatingBL.Remove(ratingDTO);
                }
                catch (Exception ex)
                {
                    return InternalServerError(ex);
                }
            }
            return Ok(rtnVal);
        }
    }
}
