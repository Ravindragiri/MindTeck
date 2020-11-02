var Q = require('q');
var mongoose = require('mongoose')

require('../models/user.server.model');
var user = mongoose.model('user');

require('../models/blockUser.server.model');
var blockUser = mongoose.model('blockUser');

var dal = {};

dal.add = add;
dal.createNewUser = createNewUser;
dal.update = update;
dal.remove = remove;
dal.getUserByEmail = getUserByEmail;
dal.getUserByEmailPassword = getUserByEmailPassword;
dal.getUserById = getUserById;
dal.getUsernameById = getUsernameById;
dal.getUserIdByUserName = getUserIdByUserName;
dal.checkIfPhoneNumberRegistered = checkIfPhoneNumberRegistered;
dal.checkUserNameExist = checkUserNameExist;
dal.checkEmailExist = checkEmailExist;

module.exports = dal;

function createNewUser(userModel) {

    var deferred = Q.defer();
    
    userModel
    .save(function (err, result) {
        if (err) deferred.reject(err);
        
        if (result) {
            deferred.resolve(result);
        } else {
            deferred.resolve();
        }
    });
    
    return deferred.promise;
}

function update(userModel, userID) {

    var deferred = Q.defer();
    
    if(!user) {
        user.updatedBy = userModel.userID;
        user.updatedDate = new Date();
    }
    user.save(function(err, user) {
        if (err) {
            deferred.reject(err);
        }
        if (user) {
            deferred.resolve(user);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;    
}

function remove(userModel, userID) {
    
    var deferred = Q.defer();
    
    userModel.find({ _id: userID }, function(err, user) {
        if (err) {
            deferred.reject(err);
        }

        // delete him
        user.remove(function(err) {
        if (err) {
            deferred.reject(err);
        }

        console.log('user successfully deleted!');
        });
    });
    return deferred.promise;
}

function getUserByEmail(email) {
    
    var deferred = Q.defer();
    
    _user
    .findOne({ 'email' : email })
    .exec(function (err, user) {
        
        if (err) {
            deferred.reject(err);
        }
        if (user) {
            deferred.resolve(user);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function getUserByEmailPassword(email, password) {
    
    var deferred = Q.defer();
    
    _user
    .findOne({ 'email' : email }, { 'password' : password })
    .exec(function (err, user) {
        
        if (err) {
            deferred.reject(err);
        }
        if (user) {
            deferred.resolve(user);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function getUserById(userID) {
    
    var deferred = Q.defer();
    
    _user
    .findOne({ '_id' : userID })
    .exec(function (err, user) {
        
        if (err) {
            deferred.reject(err);
        }
        if (user) {
            deferred.resolve(user);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function getUsernameById(userID) {
    
    var deferred = Q.defer();
    
    _user
    .findOne({ '_id' : userID })
    .select('username')
    .exec(function (err, result) {
        
        if (err) {
            deferred.reject(err);
        }
        if (result) {
            deferred.resolve(result);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function getUserIdByUserName(username) {
    
    var deferred = Q.defer();
    
    _user
    .findOne({ 'username' : username })
    .select('_id')
    .exec(function (err, result) {
        
        if (err) {
            deferred.reject(err);
        }
        if (result) {
            deferred.resolve(result);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function checkIfPhoneNumberRegistered(countryCode, phoneNumber, deviceIdentityNumber, languageG, LanguageC) {
        
}

function checkUserNameExist(username) {
    
    var deferred = Q.defer();
    
    _user
    .findOne({ 'username' : username })
    .exec(function (err, doc) {
        
        if (err) {
            deferred.reject(err);
        }
        if (doc.length) {
            deferred.resolve(true);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function checkEmailExist(email) {
    
    var deferred = Q.defer();
    
    _user
    .findOne({ 'email' : email })
    .exec(function (err, doc) {
        
        if (err) {
            deferred.reject(err);
        }
        if (doc.length) {
            deferred.resolve(true);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}








