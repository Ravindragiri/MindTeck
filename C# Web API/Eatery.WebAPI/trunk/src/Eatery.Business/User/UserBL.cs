using Eatery.DataContracts;
using Eatery.Business.Interface;
using Eatery.Common;
using Eatery.DAL.Interface;
using Eatery.DAL.Repository.Interface;
using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Business
{
    public class UserBL : IUserBL
    {
        private readonly IUserRepository _userRepository;
        private readonly IRestaurantRepository _RestaurantRepository;
        private readonly IRawSQLDbContext _rawSQLDbContext;
        private readonly IUnitOfWork _unitOfWork;

        public UserBL(
            IUserRepository userRepository,
            IRestaurantRepository RestaurantRepository,
            IRawSQLDbContext rawSQLDbContext,
            IUnitOfWork unitOfWork)
        {
            this._userRepository = userRepository;
            this._RestaurantRepository = RestaurantRepository;
            this._rawSQLDbContext = rawSQLDbContext;
            this._unitOfWork = unitOfWork;
        }

        public UserDTO CreateNewUser(UserDTO userDTO)
        {
            if (userDTO != null && userDTO.ID == 0)
            {
                using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
                {
                    User user = ObjectTypeConverter.Convert<UserDTO, User>(userDTO);

                    this._userRepository.Add(context, user);
                    _unitOfWork.Commit(context);

                    return ObjectTypeConverter.Convert<User, UserDTO>(user);
                }
            }
            return default(UserDTO);
        }

        public UserDTO Update(UserDTO userDTO, int userID)
        {
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                User user = ObjectTypeConverter.Convert<UserDTO, User>(userDTO);
                user.UpdatedDate = DateTime.Now;
                user.UpdatedBy = userID;

                user = this._userRepository.Update(context, user);
                _unitOfWork.Commit(context);
                if (user != null)
                {
                    return ObjectTypeConverter.Convert<User, UserDTO>(user);
                }
            }
            return default(UserDTO);
        }

        public UserDTO GetUserByEmail(string email)
        {
            UserDTO userDto = default(UserDTO);
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                try
                {
                    User user = this._userRepository.GetAllQuery(context).FirstOrDefault(x => x.Email == email);
                    if (user != null)
                    {
                        userDto = ObjectTypeConverter.Convert<User, UserDTO>(user);
                        return userDto;
                    }
                }
                catch (Exception ex)
                {
                    //AppLogManager.LogError(ex);
                    throw ex;
                }
            }
            return userDto;
        }

        public UserDTO GetUserByEmailPassword(string email, string password)
        {
            UserDTO userDto = default(UserDTO);
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                try
                {
                    User user = this._userRepository.GetAllQuery(context).FirstOrDefault(x => x.Email == email && x.Password == password);
                    if (user != null)
                    {
                        userDto = ObjectTypeConverter.Convert<User, UserDTO>(user);
                        return userDto;
                    }
                }
                catch (Exception ex)
                {
                    //AppLogManager.LogError(ex);
                    throw ex;
                }
            }
            return userDto;
        }

        public UserDTO GetUserById(int userID)
        {
            UserDTO userDto = default(UserDTO);
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                try
                {
                    User user = this._userRepository.GetAllQuery(context).FirstOrDefault(x => x.ID == userID);
                    if (user != null)
                    {
                        userDto = ObjectTypeConverter.Convert<User, UserDTO>(user);
                        return userDto;
                    }
                }
                catch (Exception ex)
                {
                    //AppLogManager.LogError(ex);
                    throw ex;
                }
            }
            return userDto;
        }

        public string GetUsernameById(int userID)
        {
            string username = string.Empty;
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                try
                {
                    User user = this._userRepository.GetAllQuery(context).FirstOrDefault(x => x.ID == userID);
                    if (user != null)
                    {
                        username = user.Username;
                    }
                }
                catch (Exception ex)
                {
                    //AppLogManager.LogError(ex);
                    throw ex;
                }
            }
            return username;
        }

        public int GetUserIdByUserName(string username)
        {
            int userID = default(int);
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                try
                {
                    User user = this._userRepository.GetAllQuery(context).FirstOrDefault(x => x.Username == username);
                    if (user != null)
                    {
                        userID = user.ID;
                    }
                }
                catch (Exception ex)
                {
                    //AppLogManager.LogError(ex);
                    throw ex;
                }
            }
            return userID;
        }

        /// <summary>
        /// Checking if the number exists (Retrieve password if number was register in that device)
        /// </summary>
        /// <param name="countryCode">country code</param>
        /// <param name="phoneNumber">phone number without country code</param>
        /// <param name="deviceIdentityNumber">identity</param>
        /// <param name="languageG">Language (identified by checking sim_mnc and sim_mcc)</param>
        /// <param name="LanguageC">Language set in the device, if not found it will set zz</param>
        /// <returns></returns>
        public bool CheckIfPhoneNumberRegistered(string countryCode, string phoneNumber, string deviceIdentityNumber, string languageG, string LanguageC)
        {
            bool rtnVal = true;

            return rtnVal;
        }

        public bool CheckUserNameExist(string username)
        {
            bool rtnVal = false;
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                try
                {
                    rtnVal = this._userRepository.GetAllQuery(context).Any(x => x.Username == username);
                }
                catch (Exception ex)
                {
                    //AppLogManager.LogError(ex);
                    throw ex;
                }
            }
            return rtnVal;
        }

        public bool CheckEmailExist(string email)
        {
            bool rtnVal = false;
            using (IEateryDbContext context = _unitOfWork.GetEateryDbContext())
            {
                try
                {
                    rtnVal = this._userRepository.GetAllQuery(context).Any(x => x.Email == email);
                }
                catch (Exception ex)
                {
                    //AppLogManager.LogError(ex);
                    throw ex;
                }
            }
            return rtnVal;
        }
    }
}
