using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Eatery.Common
{
    public static class AppConstants
    {
        public const string BusinessLogicCustomPolicy = "BusinessLogicCustomPolicy";
        public const string PassThroughPolicy = "PassThroughPolicy";
        public const string BusinessLogicPolicy = "BusinessLogicPolicy";
        public const string DataAccessCustomPolicy = "DataAccessCustomPolicy";
        public const string DataAccessPolicy = "DataAccessPolicy";
        public const string UIPolicy = "UIPolicy";
        public const int PageSize = 10; 
    }

    public enum MessageStateEnum
    {
        Draft = 0,
        Normal = 1
    }

    public enum UserTypeEnum
    {
        Restaurant = 1,
        Customer = 2
    }

    public enum LoginTypeEnum
    {
        LocalAccount = 0,
        SocialAccount = 1
    }

    public enum SocialAccountTypeEnum
    {
        Facebook = 0,
        Google = 1
    }

    public enum GenderEnum
    {
        Male = 0,
        Female = 1
    }

    public class SystemCode
    {
        public enum StatusCode
        {
            SYSTEM_ERROR = -500,
            ServerValidationFailed = -10,
            NotFound = -9,
            FKConflict = -8,
            UnauthorizedAccess = -7,
            DeleteFailed = -6,
            AlreadyExists = -5,
            Invalid = -4,
            FailedRedirect = -3,
            ErrorRedirect = -2,
            Error = -1,
            Failed = 0,
            Success = 1,
            Redirect = 300
        }
    }

    public class MessageHelper
    {
        public class Messages
        {
            public const string SaveSuccess = "Record has been saved successfully.";
            public const string UpdateSuccess = "Record has been updated successfully.";
            public const string DeleteSuccess = "Record has been deleted successfully.";
            public const string ReadSuccess = "Record has been retrieved successfully.";
            public const string SaveFailed = "We're unable to save your record.";
            public const string DeleteFailed = "We're unable to delete your record.";
            public const string ErrorProcessing = "The system encountered an error while processing your request.";
            public const string ErrorProcessingRefNumber = "The system encountered an error while processing your request. Reference number: {0}";
            public const string DepartmentNameAlreadyExists = "A Department with '{0}' name already Exists.";
            public const string MaskAlreadyExists = "A Mask with '{0}' category, '{1}' brand and '{2}' size already Exists.";
            public const string DepartmentCodeAlreadyExists = "A Department with '{0}' code already Exists.";
            public const string DepartmentDeleteFailed = "The Department '{0}' can not be deleted, foreign key conflict";
            public const string MaskDeleteFailedFKConflict = "This Mask can not be deleted, foreign key conflict";
            public const string UserAlreadyExists = "The user is already registered!";
            public const string UserRegisteredSuccessfully = "The user is registered successfully!";
            public const string UserRegistrationFailed = "Registration failed.";
            public const string RecordNotFound = "Record with Id '{0}' not found.";
            public const string InvalidLoginCredentials = "Login failed. Invalid Login credentials.";
            public const string LoggedInSuccess = "You logged in successfully.";
            public const string CurrentPasswordIncorrect = "The password you entered is incorrect, please retype your current password.";
            public const string PasswordIncorrect = "The password you entered is incorrect.";
            public const string UserDoesnotExist = "User does not exist!";
            public const string MenuItemDoesnotExist = "MenuItem does not exist!";
            public const string RequiredFieldMissing = "Required field is missing! {0}";
            public const string RequiredFieldEmail = "The field email is required.";
            public const string EmailNotRegistered = "Email not registered!";
            public const string ResetPasswordEmailSent = "A link to reset your password has been sent. Please Check your email.";
            public const string UsernameNotAvailable = "User already exists with same username.";
            public const string EmailNotAvailable = "User already exists with same email.";
            public const string MessageSentSuccessfully = "Your message was sent successfully.";
            public const string MessageNotSent = "Your message was not sent.";
            public const string NoMessagesFound = "No messages found.";
            public const string NotFound = "Not Found!";
        }

        public class HtmlTexts
        {
            public const string Image = "Image";
            public const string NoImageUploaded = "No Image Uploaded";
        }
    }

}
