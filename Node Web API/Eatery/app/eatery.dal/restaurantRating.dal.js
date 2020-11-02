var Q = require('q');
var mongoose = require('mongoose')
require('../models/restaurantRating.server.model');
var restaurantRating = mongoose.model('restaurantRating');

var dal = {};

dal.add = add;
dal.remove = remove;

module.exports = dal;

function add(restaurantRatingModel) {

    var deferred = Q.defer();
    
    restaurantRatingModel
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

function remove(restaurantRatingUserID) {

    var deferred = Q.defer();
    
    restaurantRating.find({ restaurantRatingUserID: restaurantRatingUserID }, function (err, _restaurantRatingModels) {
        if (err) throw err;
        
        _restaurantRatingModels.forEach(function (_restaurantRatingModel) {
            _restaurantRatingModel.remove(function (err) {
                if (err) deferred.reject(err);
        
                console.log('User successfully deleted!');
            });
        });
    });
    return deferred.promise;
}
