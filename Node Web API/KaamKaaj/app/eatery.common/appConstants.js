common = (function () {
    
    var constValues = constValues || {}
    
    constValues.appConstants = 
    {
        BusinessLogicCustomPolicy : "BusinessLogicCustomPolicy",
        PassThroughPolicy : "PassThroughPolicy",
        BusinessLogicPolicy : "BusinessLogicPolicy",
        DataAccessCustomPolicy : "DataAccessCustomPolicy",
        DataAccessPolicy : "DataAccessPolicy",
        UIPolicy : "UIPolicy",
        PageSize : 10
    }
    
    constValues.statusCode = {
        
        SYSTEM_ERROR : -500,
        ServerValidationFailed : -10,
        NotFound : -9,
        FKConflict : -8,
        UnauthorizedAccess : -7,
        DeleteFailed : -6,
        AlreadyExists : -5,
        Invalid : -4,
        FailedRedirect : -3,
        ErrorRedirect : -2,
        Error : -1,
        Failed : 0,
        Success : 1,
        Redirect : 300
    }    

    constValues.userTypeEnum = {
        Restaurant : 1,
        Customer : 2
    }
    
    constValues.loginTypeEnum = {
        LocalAccount : 0,
        SocialAccount : 1
    }
    
    constValues.messages = {
        UserAlreadyExists : "The user is already registered!",
        UserRegisteredSuccessfully : "The user is registered successfully!",
        UserRegistrationFailed : "Registration failed.",
        RecordNotFound : "Record with Id '{0}' not found.",
        InvalidLoginCredentials : "Login failed. Invalid Login credentials.",
        LoggedInSuccess : "You logged in successfully.",
        CurrentPasswordIncorrect : "The password you entered is incorrect, please retype your current password.",
        PasswordIncorrect : "The password you entered is incorrect.",
        UserDoesnotExist : "User does not exist!",
        MenuItemDoesnotExist : "MenuItem does not exist!",
        RequiredFieldMissing : "Required field is missing! {0}",
        RequiredFieldEmail : "The field email is required.",
        EmailNotRegistered : "Email not registered!",
        ResetPasswordEmailSent : "A link to reset your password has been sent. Please Check your email.",
        UsernameNotAvailable : "User already exists with same username.",
        EmailNotAvailable : "User already exists with same email.",
        MessageSentSuccessfully : "Your message was sent successfully.",
        MessageNotSent : "Your message was not sent.",
        NoMessagesFound : "No messages found.",
        NotFound : "Not Found!"
    };
    
    constValues.htmlTexts = {
        Image : "Image",
        NoImageUploaded : "No Image Uploaded"
    }

    return constValues;
});

