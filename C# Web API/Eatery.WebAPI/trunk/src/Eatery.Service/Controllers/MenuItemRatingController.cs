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
    public class MenuItemRatingController : ApiController
    {
        public readonly IMenuItemRatingBL _menuItemRatingBL;
        public MenuItemRatingController(IMenuItemRatingBL menuItemRatingBL)
        {
            this._menuItemRatingBL = menuItemRatingBL;
        }

        [HttpPost]
        public IHttpActionResult Add(MenuItemRatingDTO ratingDTO, int userID)
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
                    rtnVal = this._menuItemRatingBL.Add(ratingDTO, userID);
                }
                catch (Exception ex)
                {
                    return InternalServerError(ex);
                }
            }
            return Ok(rtnVal);
        }

        [HttpPost]
        public IHttpActionResult Remove(MenuItemRatingDTO ratingDTO)
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
                    rtnVal = this._menuItemRatingBL.Remove(ratingDTO);
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
