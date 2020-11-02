var restaurantDal = require('../../../app/dal/restaurant.dal.js');

exports.searchRestaurants = function (req, res) {

    var pagingSortingParams = req.param.pagingSortingParams;
    var searchCriteria = req.query.searchCriteria;

    restaurantDal.searchRestaurants(pagingSortingParams, searchCriteria)
        .then(function (result) {
        if (result) {
            res.send(result);
        } else {
            res.sendStatus(404);
        }
    })
        .catch(function (err) {
        res.status(400).send(err);
    });
}

exports.register = function (req, res) {
    var restaurantRegistration = req.body.restaurantRegistration;
    var userId = req.body.userId;

    restaurantDal.register(restaurantRegistration, userId)
        .then(function (result) {
            if (result) {
                res.send(result);
            } else {
                res.sendStatus(404);
            }
        })
        .catch(function (err) {
        res.status(400).send(err);
    });
};

exports.getRestaurantById = function (req, res) {

    var restaurantID = req.query.restaurantID;
    
    restaurantDal.getRestaurantById(restaurantID)
        .then(function (result) {
        if (result) {
            res.send(result);
        } else {
            res.sendStatus(404);
        }
    })
        .catch(function (err) {
        res.status(400).send(err);
    });
}

exports.getRestaurantContactDetailById = function (req, res) {

    var restaurantID = req.query.restaurantID;

    restaurantDal.getRestaurantContactDetailById(restaurantID)
        .then(function (result) {
        if (result) {
            res.send(result);
        } else {
            res.sendStatus(404);
        }
    })
        .catch(function (err) {
        res.status(400).send(err);
    });
}

exports.getNearRestaurants = function (req, res) {

    var searchCriteria = req.param.searchCriteria;
    
    restaurantDal.getNearRestaurants(searchCriteria)
        .then(function (result) {
        if (result) {
            res.send(result);
        } else {
            res.sendStatus(404);
        }
    })
        .catch(function (err) {
        res.status(400).send(err);
    });
}

exports.count = function (req, res) {

    restaurantDal.count()
        .then(function (result) {
        if (result) {
            res.send(result);
        } else {
            res.sendStatus(404);
        }
    })
        .catch(function (err) {
        res.status(400).send(err);
    });
};

exports.getRestaurantProfileInfo = function (req, res) {

    var userID = req.query.userID;
    
    restaurantDal.getRestaurantProfileInfo(userID)
        .then(function (result) {
        if (result) {
            res.send(result);
        } else {
            res.sendStatus(404);
        }
    })
        .catch(function (err) {
        res.status(400).send(err);
    });
}
