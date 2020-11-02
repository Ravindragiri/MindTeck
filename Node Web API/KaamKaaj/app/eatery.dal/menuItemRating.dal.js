var Q = require('q');
var mongoose = require('mongoose')
require('../models/menuItemRating.server.model');
var menuItemRating = mongoose.model('menuItemRating');

var dal = {};

dal.add = add;
dal.remove = remove;

module.exports = dal;

function add(menuItemRatingModel) {

    var deferred = Q.defer();
    
    menuItemRatingModel
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

function remove(menuItemRatingUserID) {

    var deferred = Q.defer();
    
    menuItemRating.find({ menuItemRatingUserID: menuItemRatingUserID }, function (err, _menuItemRatingModels) {
        if (err) throw err;
        
        _menuItemRatingModels.forEach(function (_menuItemRatingModel) {
            _menuItemRatingModel.remove(function (err) {
                if (err) deferred.reject(err);
        
                console.log('User successfully deleted!');
            });
        });
    });
    return deferred.promise;
}
