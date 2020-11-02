using Eatery.Business.Interface;
using Eatery.Common;
using Eatery.DTO;
using MultipartDataMediaFormatter.Infrastructure;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;

namespace Eatery.Service.Controllers
{
    public class RestaurantController : ApiController
    {
        public RestaurantController() { }

        public readonly IRestaurantBL _RestaurantBL;
        public readonly IUserBL _userBL;
        public RestaurantController(
            IRestaurantBL RestaurantBL,
            IUserBL userBL)
        {
            this._RestaurantBL = RestaurantBL;
            this._userBL = userBL;
        }

        public List<RestaurantDTO> SearchRestaurants(PagingSortingParamsDTO pagingSortingParams, SearchCriteriaDTO searchCriteria)
        {
            List<RestaurantDTO> Restaurants = default(List<RestaurantDTO>);
            try
            {
                if (searchCriteria != null)
                {
                    return this._RestaurantBL.SearchRestaurants(searchCriteria);
                }
            }
            catch (Exception ex)
            {

            }
            return Restaurants;
        }

        [HttpPost]
        public IHttpActionResult RegisterOwnerWithRestaurant(RegisterOwnerWithRestaurantDTO RestaurantRegistration)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    UserDTO UserDTO = RestaurantRegistration.UserDTO;
                    bool usernameAlreadyExists = this._userBL.CheckUserNameExist(UserDTO.Username);
                    if (usernameAlreadyExists)
                    {
                        return Ok(new
                        {
                            Message = MessageHelper.Messages.UsernameNotAvailable,
                            StatusCode = (int)SystemCode.StatusCode.AlreadyExists
                        });
                    }

                    bool emailAlreadyExists = this._userBL.CheckEmailExist(UserDTO.Email);
                    if (emailAlreadyExists)
                    {
                        return Ok(new
                        {
                            Message = MessageHelper.Messages.EmailNotAvailable,
                            StatusCode = (int)SystemCode.StatusCode.AlreadyExists
                        });
                    }


                    RestaurantRegistration = this._RestaurantBL.RegisterOwnerWithRestaurant(RestaurantRegistration);
                    if (RestaurantRegistration.UserDTO.ID > 0 &&
                        RestaurantRegistration.RestaurantDTO.ID > 0)
                    {
                        return Ok(new
                        {
                            data = RestaurantRegistration,
                            Message = MessageHelper.Messages.UserRegisteredSuccessfully,
                            StatusCode = (int)SystemCode.StatusCode.Success
                        });
                    }
                    else
                    {
                        return Ok(new
                        {
                            data = RestaurantRegistration,
                            Message = MessageHelper.Messages.UserRegistrationFailed,
                            StatusCode = (int)SystemCode.StatusCode.Failed
                        });
                    }
                }
                return BadRequest(ModelState);
            }
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        [HttpPost]
        public IHttpActionResult Register(RestaurantRegistrationDTO restaurantRegistrationDTO)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    RestaurantDTO restaurantDTO = restaurantRegistrationDTO.RestaurantDTO;
                    int userID = restaurantRegistrationDTO.UserID;
                    
                    restaurantDTO = this._RestaurantBL.Register(restaurantDTO, userID);
                    if (restaurantDTO.ID > 0)
                    {
                        return Ok(new
                        {
                            data = restaurantDTO,
                            Message = MessageHelper.Messages.UserRegisteredSuccessfully,
                            StatusCode = (int)SystemCode.StatusCode.Success
                        });
                    }
                    else
                    {
                        return Ok(new
                        {
                            data = restaurantDTO,
                            Message = MessageHelper.Messages.UserRegistrationFailed,
                            StatusCode = (int)SystemCode.StatusCode.Failed
                        });
                    }
                }
                return BadRequest(ModelState);
            }
            
            catch (Exception ex)
            {
                return InternalServerError(ex);
            }
        }

        public RestaurantDTO GetRestaurantById(int RestaurantID)
        {
            return this._RestaurantBL.GetRestaurantById(RestaurantID);
        }

      

        [HttpGet]
        [ResponseType(typeof(RestaurantSearchResultDTO))]
        public IHttpActionResult GetNearRestaurants([FromUri]SearchCriteriaDTO searchCriteriaDTO)
        {
            if (searchCriteriaDTO != null)
            {
                try
                {
                    if (ModelState.IsValid)
                    {
                        var RestaurantSearchDTOList = this._RestaurantBL.GetNearRestaurants(searchCriteriaDTO);
                        if (RestaurantSearchDTOList != null && RestaurantSearchDTOList.Count > 0)
                        {
                            var RestaurantSearchResultDTO = new RestaurantSearchResultDTO()
                                {
                                    RestaurantSearchDTOList = RestaurantSearchDTOList,
                                    ResponseMessageDTO = new ResponseMessageDTO()
                                    {
                                        Message = MessageHelper.Messages.ReadSuccess,
                                        StatusCode = (int)SystemCode.StatusCode.Success
                                    }
                                };
                            return Ok(RestaurantSearchResultDTO);
                        }
                        return NotFound();
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
            return BadRequest();
        }

        #region Get Restaurants By Any Criteria

        [HttpGet]
        [ResponseType(typeof(RestaurantSearchResultDTO))]
        public IHttpActionResult GetRestaurantsByAnyCriteria([FromUri]SearchCriteriaDTO searchCriteriaDTO)
        {
            try
            {
                string searchText = string.Empty;
                searchText = PrepareSearchText(searchCriteriaDTO);
                if (!string.IsNullOrWhiteSpace(searchText))
                {
                    var RestaurantSearchDTOList = this._RestaurantBL.GetRestaurantsByAnyCriteria(searchCriteriaDTO, searchText);
                    if (RestaurantSearchDTOList != null && RestaurantSearchDTOList.Count > 0)
                    {
                        var RestaurantSearchResultDTO = new RestaurantSearchResultDTO()
                        {
                            RestaurantSearchDTOList = RestaurantSearchDTOList,
                            ResponseMessageDTO = new ResponseMessageDTO()
                            {
                                Message = MessageHelper.Messages.ReadSuccess,
                                StatusCode = (int)SystemCode.StatusCode.Success
                            }
                        };
                        return Ok(RestaurantSearchResultDTO);
                    }
                    return NotFound();
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

        private string PrepareSearchText(SearchCriteriaDTO searchCriteriaDTO)
        {
            string strsearchText = string.Empty;
            StringBuilder sbSearchText = new StringBuilder();

            if (!string.IsNullOrWhiteSpace(searchCriteriaDTO.Keyword))
            {
                sbSearchText.Append(searchCriteriaDTO.Keyword);
            }
            else
            {
                ModelState.AddModelError("searchCriteriaDTO.Keyword", "The field Keyword is Required.");
            }
            if (!string.IsNullOrWhiteSpace(searchCriteriaDTO.Location))
            {
                sbSearchText.Append(",");
                sbSearchText.Append(searchCriteriaDTO.Location);
            }

            return sbSearchText.ToString();
        }

        #endregion

        public int Count()
        {
            int count = default(int);
            try
            {
                count = this._RestaurantBL.Count();
            }
            catch (Exception ex)
            {

                throw;
            }
            return count;
        }

        [HttpGet]
        [ResponseType(typeof(RestaurantProfileDTO))]
        public IHttpActionResult GetRestaurantProfileInfo([FromUri]int userID)
        {
            if (userID > 0)
            {
                try
                {
                    if (ModelState.IsValid)
                    {
                        var RestaurantProfileDTO = this._RestaurantBL.GetRestaurantProfileInfo(userID);
                        if (RestaurantProfileDTO != null)
                        {
                            RestaurantProfileDTO.ResponseMessageDTO = new ResponseMessageDTO()
                            {
                                Message = MessageHelper.Messages.ReadSuccess,
                                StatusCode = (int)SystemCode.StatusCode.Success
                            };
                            return Ok(RestaurantProfileDTO);
                        }
                        return NotFound();
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
            return BadRequest();
        }
    }
}