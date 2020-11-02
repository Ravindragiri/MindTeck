var Q = require('q');
var _ = require('lodash');
var mongoose = require('mongoose'),
    async = require('async');
require('../models/restaurant.server.model');
require('../models/user.server.model');
var _restaurants = mongoose.model('restaurant');
var _user = mongoose.model('user');

var restaurantDal = {};

restaurantDal.add = add;
restaurantDal.getDonorById = getDonorById;
restaurantDal.searchDonors = searchDonors;
restaurantDal.getDonorContactDetailById = getDonorContactDetailById;
restaurantDal.register = register;
restaurantDal.getNearDonors = getNearDonors;
restaurantDal.getDonorsByAnyCriteria = getDonorsByAnyCriteria;
restaurantDal.getDonorProfileInfo = getDonorProfileInfo;
restaurantDal.count = count;

function add(restaurantModel) {
    
    var deferred = Q.defer();
    
    restaurantModel
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

function searchDonors(pagingSortingParams, searchCriteria) {
    
    var deferred = Q.defer();
    
    _user
    .find({})
    .populate({ path: 'organs' })
    .find({ 'userType': 1 })
    .select('_id province city address pinCode organs')
    .exec(function (err, restaurants) {
        
        if (err) {
            deferred.reject(err);
        }
        if (restaurants) {
            deferred.resolve(restaurants);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function getDonorById(_id) {
    
    var deferred = Q.defer();
    
    _user
    .findOne({ '_id' : _id })
    .populate({ path: 'user' })
    .populate({ path: 'organs' })
    .select('_id province city address pinCode organs')
    .exec(function (err, restaurant) {
        
        if (err) {
            deferred.reject(err);
        }
        if (restaurant) {
            deferred.resolve(restaurant);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function getDonorContactDetailById(restaurantID) {
    
    var deferred = Q.defer();
    
    _user
    .findOne({ _id : restaurantID })
    .select('_id firstName address phoneNumber email')
    .exec(function (err, restaurant) {
        
        if (err) {
            deferred.reject(err);
        }
        if (restaurant) {
            deferred.resolve(restaurant);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function register(userModel) {
    
    var userDal = require('./user.dal.js');
    var deferred = Q.defer();
    
    userModel.createdDate = new Date();
    
    userDal.add(userModel)
    .then(function (user) {
        
        if (user) {
            var user = _.pick(user.toObject(), ['_id', 'province', 'city', 'address', 'pinCode', 'organs']);
            deferred.resolve(user);
        } else {
            deferred.resolve();
        }
    })
    .catch(function (err) {
        if (err) deferred.reject(err);
    });
    
    return deferred.promise;
}

function getNearDonors(searchCriteria) {
    
    var deferred = Q.defer();
    
    _user
    .aggregate(
        [
            {
                '$geoNear': {
                    'near': {
                        'type': 'Point',
                        'coordinates': [searchCriteria.coords[1] , searchCriteria.coords[0]]
                    },
                    'spherical': true, 
                    'distanceField': 'dist',
                    'maxDistance': searchCriteria.distance
                }
            },
            {
                $match: {
                    'userType': 1
                }
            },
            {
                $project: {
                    _id: 1,
                    province: 1,
                    city: 1,
                    address: 1,
                    pinCode: 1,
                    firstName: 1,
                    address: 1,
                    countryCode: 1,
                    loc: 1,
                    dist: 1,
                    email: 1,
                    isActive: 1,
                    organs: 1
                }
            },
            {
                "$sort": { "score": { "$meta": "textScore" } }
            },
            { "$limit": (searchCriteria.pageNumber - 1) * searchCriteria.pageSize },
            { "$skip": searchCriteria.pageSize }
        ])
        .exec(function (err, restaurant) {
        
        if (err) {
            deferred.reject(err);
        }
        if (restaurant) {
            deferred.resolve(restaurant);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function getDonorsByAnyCriteria(searchCriteria, searchText) {
    
    var deferred = Q.defer();
    
    _user
    .aggregate(
        [
            {
                '$geoNear': {
                    'near': {
                        'type': 'Point',
                        'coordinates': [searchCriteria.coords[1] , searchCriteria.coords[0]]
                    },
                    'spherical': true, 
                    'distanceField': 'dist',
                    'maxDistance': searchCriteria.distance
                }
            },
            {
                $match: {
                    $or: [
                        { 'organs.title': new RegExp(searchText, 'i') }, 
                        { 'organs.description': new RegExp(searchText, 'i') },
                        { 'country': new RegExp(searchText, 'i') },
                        { 'province': new RegExp(searchText, 'i') },
                        { 'city': new RegExp(searchText, 'i') },
                        { 'address': new RegExp(searchText, 'i') },
                        { 'lastName': new RegExp(searchText, 'i') },
                        { 'firstName': new RegExp(searchText, 'i') },
                    ]
                }
            },
            {
                $project: {
                    _id: 1,
                    province: 1,
                    city: 1,
                    address: 1,
                    pinCode: 1,
                    firstName: 1,
                    address: 1,
                    countryCode: 1,
                    loc: 1,
                    dist: 1,
                    email: 1,
                    isActive: 1,
                    organs: 1
                }
            },
            {
                "$sort": { "score": { "$meta": "textScore" } }
            },
            { "$limit": (searchCriteria.pageNumber - 1) * searchCriteria.pageSize },
            { "$skip": searchCriteria.pageSize }
        ])
        .exec(function (err, restaurant) {
        
        if (err) {
            deferred.reject(err);
        }
        if (restaurant) {
            deferred.resolve(restaurant);
        } else {
            deferred.resolve();
        }
    });
    
    return deferred.promise;
}

function getDonorProfileInfo(userID) {
    
    var deferred = Q.defer();
    
    _user
    .findOne({ _id : userID })
    .populate({ path: 'organs' })
    .exec(function (err, restaurant) {
        
        if (err) {
            deferred.reject(err);
        }
        if (restaurant) {
            deferred.resolve(restaurant);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function count() {
    
    var deferred = Q.defer();
    
    _restaurants
    .count({})
    .exec(function (err, count) {
        
        if (err) {
            deferred.reject(err);
        }
        if (count) {
            deferred.resolve(count);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function getDonorById(restaurantID) {
    
    var deferred = Q.defer();
    
    _restaurants
    .findOne({ '_id' : restaurantID })
    .populate({ path: 'user' })
    .populate({ path: 'organs' })
    .exec(function (err, restaurant) {
        
        if (err) {
            deferred.reject(err);
        }
        if (restaurant) {
            deferred.resolve(restaurant);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

module.exports = restaurantDal;
