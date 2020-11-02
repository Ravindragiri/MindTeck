using Eatery.Business.Interface;
using Eatery.Common;
using Eatery.DTO;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Net;
using System.Net.Http;
using System.Text;
using System.Web.Http;
using System.Web.Http.Description;

namespace Eatery.Service.Controllers
{
    public class UserController : ApiController
    {
        public readonly IUserBL _userBL;
        public readonly IRestaurantBL _RestaurantBL;

        public UserController() { }

        public UserController(
            IUserBL userBL,
            IRestaurantBL RestaurantBL)
        {
            this._userBL = userBL;
            this._RestaurantBL = RestaurantBL;
        }

        public UserDTO CreateNewUser(UserDTO userDTO)
        {
            return this._userBL.CreateNewUser(userDTO);
        }

        public UserDTO GetUserByEmail(string email)
        {
            return this._userBL.GetUserByEmail(email);
        }

        public UserDTO GetUserByEmailPassword(string email, string password)
        {
            return this._userBL.GetUserByEmailPassword(email, password);
        }

        public UserDTO GetUserById(int userID)
        {
            return this._userBL.GetUserById(userID);
        }

        //public UserProfileDTO GetUserProfileByUserID(int userID)
        //{
        //    return this._userBL.GetUserProfileByUserID(userID);
        //}

        //public MyProfileDTO GetMyProfileByUserID(int userID)
        //{
        //    return this._userBL.GetMyProfileByUserID(userID);
        //}

        public string GetUsernameById(int userID)
        {
            return this._userBL.GetUsernameById(userID);
        }

        public int GetUserIdByUserName(string username)
        {
            return this.GetUserIdByUserName(username);
        }
    }
}
