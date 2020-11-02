var Q = require('q');
var mongoose = require('mongoose')
require('../models/menuItem.server.model');
require('../models/user.server.model');
var _menuItem = mongoose.model('menuItem');
var _user = mongoose.model('user');

var dal = {};

dal.update = update;
dal.updateAll = updateAll;
dal.count = count;
dal.add = add;
dal.getMenuItemById = getMenuItemById;
dal.delete = delete;
dal.getNearMenuItems = getNearMenuItems;
dal.searchMenuItems = searchMenuItems;
dal.getAllNearByMenuItems = getAllNearByMenuItems;
dal.getMenuItemDetail = getMenuItemDetail;
dal.getMenuItemsByRestaurantID = getMenuItemsByRestaurantID;

module.exports = dal;

function update(menuItemModel, menuItemID) {

    var deferred = Q.defer();
    
    if(!menuItem) {
        menuItem.updatedBy = menuItemModel.menuItemID;
        menuItem.updatedDate = new Date();
    }
    menuItem.save(function(err, menuItem) {
        if (err) {
            deferred.reject(err);
        }
        if (menuItem) {
            deferred.resolve(menuItem);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;    
}

function updateAll(menuItemModels, menuItemID) {

    var deferred = Q.defer();
    
    menuItemModels.forEach(function(menuItem){
        
        if(!menuItem) {
            menuItem.updatedBy = menuItemModel.menuItemID;
            menuItem.updatedDate = DateTime.Now;
        }
        menuItem.save(function(err, menuItem) {
            if (err) {
                deferred.reject(err);
            }
            if (menuItem) {
                deferred.resolve(menuItem);
            } else {
                deferred.resolve();
            }
        });
    });
    return deferred.promise;    
}

function count() {
    
    var deferred = Q.defer();
    
    _menuItem
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

function add(menuItemModel) {

    var deferred = Q.defer();
    
    menuItemModel
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

function getMenuItemById(menuItemID) {
    
    var deferred = Q.defer();
    
    _menuItem
    .findOne({ _id : menuItemID })
    .exec(function (err, menuItem) {
        
        if (err) {
            deferred.reject(err);
        }
        if (menuItem) {
            deferred.resolve(menuItem);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function delete(menuItemModel) {
    
    var deferred = Q.defer();
    
    menuItemModel.find({ _id: menuItemID }, function(err, menuItem) {
        if (err) {
            deferred.reject(err);
        }

        // delete him
        menuItem.remove(function(err) {
        if (err) {
            deferred.reject(err);
        }

        console.log('menuItem successfully deleted!');
        });
    });
    return deferred.promise;
}

function getNearMenuItems(searchCriteria) {
    
    var deferred = Q.defer();
    
    _menuItem
    .find({
      loc: {
        $near: searchCriteria.coords,
        $maxDistance: searchCriteria.maxDistance
      }
    })
    .find({
        '$or':[
            {title:new RegExp(searchCriteria.searchText,'i')},
            {description:new RegExp(searchCriteria.searchText,'i')}
        ]
    })
    .populate({ path: 'user' })
    .populate({ path: 'restaurant' })
    .exec(function (err, menuItem) {
        
        if (err) {
            deferred.reject(err);
        }
        if (menuItem) {
            deferred.resolve(menuItem);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function searchMenuItems(searchCriteria) {
    
    var deferred = Q.defer();
    
    _menuItem
    .find({
      loc: {
        $near: searchCriteria.coords,
        $maxDistance: searchCriteria.maxDistance
      }
    })
    .find({
        '$or':[
            {title:new RegExp(searchCriteria.searchText,'i')},
            {description:new RegExp(searchCriteria.searchText,'i')}
        ]
    })
    .populate({ path: 'user' })
    .populate({ path: 'restaurant' })
    .exec(function (err, menuItem) {
        
        if (err) {
            deferred.reject(err);
        }
        if (menuItem) {
            deferred.resolve(menuItem);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function getAllNearByMenuItems(searchCriteria) {
    
    var deferred = Q.defer();
    
    _menuItem
    .find({
      loc: {
        $near: searchCriteria.coords,
        $maxDistance: searchCriteria.maxDistance
      }
    })
    .find({
        '$or':[
            {title:new RegExp(searchCriteria.searchText,'i')},
            {description:new RegExp(searchCriteria.searchText,'i')}
        ]
    })
    .populate({ path: 'user' })
    .populate({ path: 'restaurant' })
    .exec(function (err, menuItem) {
        
        if (err) {
            deferred.reject(err);
        }
        if (menuItem) {
            deferred.resolve(menuItem);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function getMenuItemDetail(menuItemID, latitude, longitude) {
    
    var deferred = Q.defer();
    
    _menuItem
    .findOne({ _id : menuItemID }, {latitude: latitude}, {longitude: longitude})
    .exec(function (err, menuItem) {
        
        if (err) {
            deferred.reject(err);
        }
        if (menuItem) {
            deferred.resolve(menuItem);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}

function getMenuItemsByRestaurantID(restaurantID, page, pageSize) {
    
    var deferred = Q.defer();
    
    _menuItem
    .findOne({toRestaurantID: restaurantID})
    .limit(pageSize)
    .skip(pageSize * page)
    .sort('_id', -1)
    .exec(function (err, menuItems) {
        
        if (err) deferred.reject(err);
        if (result) {
            deferred.resolve(menuItems);
        } else {
            deferred.resolve();
        }
    });
    return deferred.promise;
}