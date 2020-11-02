using Eatery.Business.Interface;
using Eatery.Common;
using Eatery.DTO;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Web.Http;
using System.Web.Http.Description;

namespace Eatery.Service.Controllers
{
    public class MenuItemController : ApiController
    {

        public readonly IMenuItemBL _MenuItemBL;
        public readonly IRestaurantBL _RestaurantBL;
        public MenuItemController(
            IMenuItemBL MenuItemBL,
            IRestaurantBL RestaurantBL)
        {
            this._MenuItemBL = MenuItemBL;
            this._RestaurantBL = RestaurantBL;
        }

        public int Count()
        {
            int count = default(int);
            try
            {
                count = this._MenuItemBL.Count();
            }
            catch (Exception ex)
            {

                throw;
            }
            return count;
        }

        [HttpPost]
        [ResponseType(typeof(MenuItemResultDTO))]
        public IHttpActionResult Add(MenuItemDTO MenuItemDTO)
        {
            bool rtnVal = false;

            if (MenuItemDTO != null)
            {
                try
                {
                    if (ModelState.IsValid)
                    {
                        if (MenuItemDTO.RestaurantID == 0)
                        {
                            RestaurantDTO RestaurantDto = this._RestaurantBL.GetRestaurantByUserID(MenuItemDTO.UserID);
                            if (RestaurantDto != null)
                                MenuItemDTO.RestaurantID = RestaurantDto.ID.Value;
                        }

                        rtnVal = this._MenuItemBL.Add(MenuItemDTO, MenuItemDTO.UserID);
                        if (rtnVal)
                        {
                            return Ok(new
                            {
                                status = SystemCode.StatusCode.Success.ToString(),
                                message = MessageHelper.Messages.SaveSuccess,
                                data = MenuItemDTO,
                                statusCode = (int)SystemCode.StatusCode.Success
                            });
                        }
                        return Ok(new
                        {
                            status = SystemCode.StatusCode.Error.ToString(),
                            message = MessageHelper.Messages.SaveFailed,
                            statusCode = (int)SystemCode.StatusCode.Failed
                        });
                    }
                    else
                    {
                        return BadRequest(ModelState);
                    }
                }
                catch (Exception)
                {

                    throw;
                }
            }
            return BadRequest();
        }

        [HttpGet]
        [ResponseType(typeof(List<MenuItemSearchDTO>))]
        public IHttpActionResult GetNearMenuItems([FromUri]SearchCriteriaDTO searchCriteriaDTO)
        {
            List<MenuItemSearchDTO> MenuItemSearchDTOList = default(List<MenuItemSearchDTO>);
            if (searchCriteriaDTO != null)
            {
                try
                {
                    if (ModelState.IsValid)
                    {
                        MenuItemSearchDTOList = this._MenuItemBL.GetNearMenuItems(searchCriteriaDTO);
                        if (MenuItemSearchDTOList != null && MenuItemSearchDTOList.Count > 0)
                        {
                            MenuItemSearchDTOList.ForEach(x => x.DistanceInKilometers = Convert.ToDouble(string.Format("{0:F3}", x.DistanceInKilometers)));
                            return Ok(new
                            {
                                status = SystemCode.StatusCode.Success.ToString(),
                                data = MenuItemSearchDTOList,
                                statusCode = (int)SystemCode.StatusCode.Success
                            });
                        }
                    }
                    else
                    {
                        return BadRequest(ModelState);
                    }
                }
                catch (Exception ex)
                {
                    return InternalServerError(ex);
                }
            }
            return Ok(new
            {
                status = SystemCode.StatusCode.Error.ToString(),
                data = MenuItemSearchDTOList,
                statusCode = (int)SystemCode.StatusCode.Failed
            });
        }

        [HttpGet]
        [ResponseType(typeof(List<MenuItemSearchDTO>))]
        public IHttpActionResult SearchMenuItems([FromUri]SearchCriteriaDTO searchCriteriaDTO)
        {
            List<MenuItemSearchDTO> MenuItemSearchDTOList = default(List<MenuItemSearchDTO>);
            if (searchCriteriaDTO != null)
            {
                try
                {
                    if (ModelState.IsValid)
                    {
                        MenuItemSearchDTOList = this._MenuItemBL.SearchMenuItems(searchCriteriaDTO);
                        if (MenuItemSearchDTOList != null && MenuItemSearchDTOList.Count > 0)
                        {
                            MenuItemSearchDTOList.ForEach(x => x.DistanceInKilometers = Convert.ToDouble(string.Format("{0:F3}", x.DistanceInKilometers)));
                            return Ok(new
                            {
                                status = SystemCode.StatusCode.Success.ToString(),
                                data = MenuItemSearchDTOList,
                                statusCode = (int)SystemCode.StatusCode.Success
                            });
                        }
                    }
                    else
                    {
                        return BadRequest(ModelState);
                    }
                }
                catch (Exception ex)
                {
                    return InternalServerError(ex);
                }
            }
            return Ok(new
            {
                status = SystemCode.StatusCode.Error.ToString(),
                data = MenuItemSearchDTOList,
                statusCode = (int)SystemCode.StatusCode.Failed
            });
        }

        [HttpGet]
        [ResponseType(typeof(List<MenuItemSearchDTO>))]
        public IHttpActionResult GetAllNearByMenuItems([FromUri]SearchCriteriaDTO searchCriteriaDTO)
        {
            List<MenuItemSearchDTO> MenuItemSearchDTOList = default(List<MenuItemSearchDTO>);
            if (searchCriteriaDTO != null)
            {
                try
                {
                    if (ModelState.IsValid)
                    {
                        MenuItemSearchDTOList = this._MenuItemBL.GetAllNearByMenuItems(searchCriteriaDTO);
                        if (MenuItemSearchDTOList != null && MenuItemSearchDTOList.Count > 0)
                        {
                            MenuItemSearchDTOList.ForEach(x => x.DistanceInKilometers = Convert.ToDouble(string.Format("{0:F3}", x.DistanceInKilometers)));
                            return Ok(new
                            {
                                status = SystemCode.StatusCode.Success.ToString(),
                                data = MenuItemSearchDTOList,
                                statusCode = (int)SystemCode.StatusCode.Success
                            });
                        }
                    }
                    else
                    {
                        return BadRequest(ModelState);
                    }
                }
                catch (Exception ex)
                {
                    return InternalServerError(ex);
                }
            }
            return Ok(new
            {
                status = SystemCode.StatusCode.Error.ToString(),
                data = MenuItemSearchDTOList,
                statusCode = (int)SystemCode.StatusCode.Failed
            });
        }

        [HttpGet]
        [ResponseType(typeof(MenuItemSearchDTO))]
        public IHttpActionResult GetMenuItemDetail([FromUri]int MenuItemID, decimal latitude, decimal longitude)
        {
            MenuItemSearchDTO MenuItemSearchDTO = default(MenuItemSearchDTO);
            try
            {
                if (MenuItemID > 0)
                {
                    MenuItemSearchDTO = this._MenuItemBL.GetMenuItemDetail(MenuItemID, latitude, longitude);
                    if (MenuItemSearchDTO != null)
                    {
                        MenuItemSearchDTO.DistanceInKilometers = Convert.ToDouble(string.Format("{0:F3}", MenuItemSearchDTO.DistanceInKilometers));
                        return Ok(new
                        {
                            status = SystemCode.StatusCode.Success.ToString(),
                            data = MenuItemSearchDTO,
                            statusCode = (int)SystemCode.StatusCode.Success
                        });
                    }
                }
                else
                {
                    return BadRequest(ModelState);
                }
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
            return Ok(new
            {
                status = SystemCode.StatusCode.Error.ToString(),
                data = MenuItemSearchDTO,
                statusCode = (int)SystemCode.StatusCode.Failed
            });
        }

        [HttpGet]
        [ResponseType(typeof(List<MenuItemDTO>))]
        public IHttpActionResult GetMenuItemsByRestaurantID([FromUri]int RestaurantID, [FromUri]int page)
        {
            List<MenuItemDTO> MenuItemDTOList = new List<MenuItemDTO>();
            try
            {
                if (RestaurantID > 0)
                {
                    page = page - 1;
                    int pageSize = AppConstants.PageSize;
                    MenuItemDTOList = this._MenuItemBL.GetMenuItemsByRestaurantID(RestaurantID, page, pageSize);
                    return Ok(new
                    {
                        status = SystemCode.StatusCode.Success.ToString(),
                        data = MenuItemDTOList,
                        numpage = MenuItemDTOList == null ? 0 : Math.Ceiling(Convert.ToDecimal(MenuItemDTOList.Count / pageSize)) + 1,
                        statusCode = (int)SystemCode.StatusCode.Success
                    });
                }
                else
                {
                    return BadRequest(ModelState);
                }
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
            return Ok(new
            {
                status = SystemCode.StatusCode.Error.ToString(),
                data = MenuItemDTOList,
                statusCode = (int)SystemCode.StatusCode.Failed
            });
        }

    }
}
