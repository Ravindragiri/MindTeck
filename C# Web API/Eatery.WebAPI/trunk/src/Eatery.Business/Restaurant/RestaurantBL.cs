using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Eatery.Business;
using Eatery.Business.Interface;
using Eatery.DTO;
using Eatery.DAL.Repository.Interface;
using Eatery.DAL.Interface;
using Eatery.DataContracts;
using Eatery.Common;

namespace Eatery.Business
{
    public class RestaurantBL : IRestaurantBL
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IRestaurantRepository _RestaurantRepository;
        private readonly IUserRepository _userRepository;
        private readonly IMenuItemRepository _MenuItemRepository;
        private readonly IOperationTimingRepository _OperationTimingRepository;
        private readonly IRawSQLDbContext _rawSQLDbContext;

        public RestaurantBL(
            IUnitOfWork unitOfWork,
            IRestaurantRepository RestaurantRepository,
            IUserRepository userRepository,
            IMenuItemRepository MenuItemRepository,
            IOperationTimingRepository OperationTimingRepository,
            IRawSQLDbContext rawSQLDbContext)
        {
            this._unitOfWork = unitOfWork;
            this._RestaurantRepository = RestaurantRepository;
            this._userRepository = userRepository;
            this._MenuItemRepository = MenuItemRepository;
            this._OperationTimingRepository = OperationTimingRepository;
            this._rawSQLDbContext = rawSQLDbContext;
        }

        public List<RestaurantDTO> SearchRestaurants(SearchCriteriaDTO searchCriteria)
        {
            List<RestaurantDTO> Restaurants = default(List<RestaurantDTO>);
            if (searchCriteria != null)
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {
                    List<Restaurant> RestaurantList = this._RestaurantRepository.GetAllQuery(context).ToList();
                    if (RestaurantList != null && RestaurantList.Any())
                    {
                        Restaurants = ObjectTypeConverter.ConvertList<Restaurant, RestaurantDTO>(RestaurantList).ToList();
                    }
                }
            }
            return Restaurants;
        }

        public RegisterOwnerWithRestaurantDTO RegisterOwnerWithRestaurant(RegisterOwnerWithRestaurantDTO RestaurantRegistrationDTO)
        {
            if (RestaurantRegistrationDTO != null)
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {
                    using (var dbContextTransaction = ((IDbContext)context).GetDataBase().BeginTransaction())
                    {
                        try
                        {
                            User user = ObjectTypeConverter.Convert<UserDTO, User>(RestaurantRegistrationDTO.UserDTO);
                            this._userRepository.Add(context, user);
                            _unitOfWork.Commit(context);

                            if (user.ID > 0)
                            {
                                Restaurant Restaurant = ObjectTypeConverter.Convert<RestaurantDTO, Restaurant>(RestaurantRegistrationDTO.RestaurantDTO);
                                Restaurant.UserID = user.ID;
                                this._RestaurantRepository.Add(context, Restaurant);

                                _unitOfWork.Commit(context);
                                if (Restaurant.ID > 0)
                                {
                                    foreach (var MenuItemDTO in RestaurantRegistrationDTO.RestaurantDTO.MenuItemList)
                                    {
                                        MenuItem MenuItem = ObjectTypeConverter.Convert<MenuItemDTO, MenuItem>(MenuItemDTO);
                                        this._MenuItemRepository.Add(context, MenuItem);
                                        _unitOfWork.Commit(context);
                                    }
                                    dbContextTransaction.Commit();
                                }
                                else
                                {
                                    dbContextTransaction.Rollback();
                                }
                            }
                            else
                            {
                                dbContextTransaction.Rollback();
                            }
                        }
                        catch (Exception)
                        {
                            dbContextTransaction.Rollback();
                        }
                    }
                }
            }
            return RestaurantRegistrationDTO;
        }

        public RestaurantDTO Register(RestaurantDTO restaurantDTO, int userID)
        {
            if (restaurantDTO != null)
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {
                    using (var dbContextTransaction = ((IDbContext)context).GetDataBase().BeginTransaction())
                    {
                        try
                        {
                            if (userID > 0)
                            {
                                Restaurant restaurant = ObjectTypeConverter.Convert<RestaurantDTO, Restaurant>(restaurantDTO);
                                restaurant.UserID = userID;
                                restaurant.CreatedBy = userID;
                                restaurant.CreatedDate = DateTime.Now;
                                this._RestaurantRepository.Add(context, restaurant);

                                _unitOfWork.Commit(context);
                                if (restaurant.ID > 0)
                                {
                                    foreach (var operationTimingsDTO in restaurantDTO.OperationTimings)
                                    {
                                        OperationTiming operationTiming = ObjectTypeConverter.Convert<OperationTimingDTO, OperationTiming>(operationTimingsDTO);
                                        operationTiming.RestaurantID = restaurant.ID;
                                        operationTiming.CreatedBy = userID;
                                        operationTiming.CreatedDate = DateTime.Now;
                                        this._OperationTimingRepository.Add(context, operationTiming);
                                        _unitOfWork.Commit(context);
                                    }
                                    dbContextTransaction.Commit();
                                    restaurantDTO = ObjectTypeConverter.Convert<Restaurant, RestaurantDTO>(restaurant);
                                }
                                else
                                {
                                    dbContextTransaction.Rollback();
                                }
                            }
                            else
                            {
                                dbContextTransaction.Rollback();
                            }
                        }
                        catch (Exception ex)
                        {
                            dbContextTransaction.Rollback();
                        }
                    }
                }
            }
            return restaurantDTO;
        }

        public RestaurantDTO GetRestaurantById(int RestaurantID)
        {
            RestaurantDTO RestaurantDto = default(RestaurantDTO);
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                try
                {

                    var Restaurant = this._RestaurantRepository.GetAllQuery(context).FirstOrDefault(x => x.ID == RestaurantID);
                    if (Restaurant != null)
                    {
                        RestaurantDto = ObjectTypeConverter.Convert<Restaurant, RestaurantDTO>(Restaurant);
                        return RestaurantDto;
                    }
                }
                catch (Exception ex)
                {
                    //AppLogManager.LogError(ex);
                    throw ex;
                }
            }
            return RestaurantDto;
        }

        public RestaurantContactDetailDTO GetRestaurantContactDetailById(int RestaurantID)
        {
            RestaurantContactDetailDTO RestaurantContactDetailDto = default(RestaurantContactDetailDTO);
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                try
                {

                    RestaurantContactDetailDto = (from sp in this._RestaurantRepository.GetAllQuery(context)
                                                       join u in this._userRepository.GetAllQuery(context) on sp.UserID equals u.ID
                                                       where sp.ID == RestaurantID
                                                       select new RestaurantContactDetailDTO()
                                                       {
                                                           ID = sp.ID,
                                                           //UserID = u.ID,
                                                           FirstName = u.FirstName,
                                                           Address = sp.Address,
                                                           PhoneNumber = u.PhoneNumber,
                                                           Email = u.Email
                                                       }).FirstOrDefault();
                }
                catch (Exception ex)
                {
                    //AppLogManager.LogError(ex);
                    throw ex;
                }
            }
            return RestaurantContactDetailDto;
        }

        public List<RestaurantSearchDTO> GetNearRestaurants(SearchCriteriaDTO criteria)
        {
            List<RestaurantSearchDTO> RestaurantSearchDTOList = new List<RestaurantSearchDTO>();
            try
            {
                RestaurantSearchDTOList = this._rawSQLDbContext.GetNearRestaurants(criteria);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RestaurantSearchDTOList;
        }

        public List<RestaurantSearchDTO> GetRestaurantsByAnyCriteria(SearchCriteriaDTO criteria, string searchText)
        {
            List<RestaurantSearchDTO> RestaurantSearchDTOList = new List<RestaurantSearchDTO>();
            try
            {
                RestaurantSearchDTOList = this._rawSQLDbContext.GetRestaurantsByAnyCriteria(criteria, searchText);
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return RestaurantSearchDTOList;
        }

        public int Count()
        {
            int MenuItemsCount = default(int);
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                MenuItemsCount = this._MenuItemRepository.GetAllQuery(context).Count();
            }
            return MenuItemsCount;
        }

        public RestaurantProfileDTO GetRestaurantProfileInfo(int userID)
        {
            RestaurantProfileDTO RestaurantProfileDTO = default(RestaurantProfileDTO);
            try
            {
                RestaurantProfileDTO = this._rawSQLDbContext.GetRestaurantProfileInfo(userID);
            }
            catch (Exception)
            {

                throw;
            }
            return RestaurantProfileDTO;
        }

        public RestaurantDTO GetRestaurantByUserID(int userID)
        {
            RestaurantDTO RestaurantDTO = default(RestaurantDTO);
            try
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {
                    var Restaurant = (from Restaurants in this._RestaurantRepository.GetAllQuery(context)
                                           join users in this._userRepository.GetAllQuery(context) on Restaurants.UserID equals users.ID
                                           where users.ID == userID
                                           select Restaurants).FirstOrDefault();
                    if (Restaurant != null)
                    {
                        RestaurantDTO = ObjectTypeConverter.Convert<Restaurant, RestaurantDTO>(Restaurant);
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
            return RestaurantDTO;
        }
    }
}
