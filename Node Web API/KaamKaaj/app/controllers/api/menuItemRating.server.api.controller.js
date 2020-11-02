var menuItemRatingDal = require('../../eatery.dal/menuItemRating.dal.js');
var mongoose = require('mongoose');
var menuItemRating = mongoose.model('menuItemRating');

exports.add = function (req, res) {
    var menuItemRatingModel = new menuItemRating(req.body);
    
    menuItemRatingDal.add(menuItemRatingModel)
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
    var menuItemRatingUserID = req.query.menuItemRatingUserID;

    menuItemRatingDal.remove(menuItemRatingUserID)
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

