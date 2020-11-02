var restaurantRatingDal = require('../../eatery.dal/restaurantRating.dal.js');
var mongoose = require('mongoose');
var restaurantRating = mongoose.model('restaurantRating');

exports.add = function (req, res) {
    var restaurantRatingModel = new restaurantRating(req.body);
    
    restaurantRatingDal.add(restaurantRatingModel)
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

exports.remove = function (req, res) {
    var restaurantRatingUserID = req.query.restaurantRatingUserID;

    restaurantRatingDal.remove(restaurantRatingUserID)
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

