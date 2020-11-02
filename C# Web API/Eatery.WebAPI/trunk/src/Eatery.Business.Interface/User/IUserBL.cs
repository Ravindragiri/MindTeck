using Eatery.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Business.Interface
{
    public interface IUserBL
    {
        UserDTO CreateNewUser(UserDTO userDTO);
        UserDTO GetUserByEmail(string email);
        UserDTO GetUserByEmailPassword(string email, string password);
        UserDTO GetUserById(int userID);
        string GetUsernameById(int userID);
        int GetUserIdByUserName(string username);
        UserDTO Update(UserDTO userDTO, int userID);
        //bool ResetPassword(int userID);
        bool CheckUserNameExist(string username);
        bool CheckEmailExist(string email);
    }
}
