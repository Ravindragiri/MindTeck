var menuItemDal = require('../../../app/dal/menuItem.dal.js');

exports.count = function (req, res) {

    messageDal.count()
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

exports.add = function (req, res) {
    var menuItemRatingModel = req.body.menuItemRatingModel;
    
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

exports.update = function (req, res) {
    var menuItemRatingModel = req.body.menuItemRatingModel;
    
    menuItemRatingDal.update(menuItemRatingModel)
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

exports.delete = function (req, res) {
    var menuItemRatingModel = req.body.menuItemRatingModel;
    
    menuItemRatingDal.delete(menuItemRatingModel)
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

exports.getNearMenuItems = function (req, res) {

    var searchCriteria = req.param.searchCriteria;
    
    messageDal.getNearMenuItems(searchCriteria)
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

exports.searchMenuItems = function (req, res) {

    var searchCriteria = req.param.searchCriteria;
    
    messageDal.searchMenuItems(searchCriteria)
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

exports.getAllNearByMenuItems = function (req, res) {

    var searchCriteria = req.param.searchCriteria;
    
    messageDal.getAllNearByMenuItems(searchCriteria)
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

exports.getMenuItemDetail = function (req, res) {

    var menuItemID = req.query.menuItemID;
    var latitude = req.query.latitude;
    var longitude = req.query.longitude;

    messageDal.getMenuItemDetail(menuItemID, latitude, longitude)
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

exports.getMenuItemsByRestaurantID = function (req, res) {

    var restaurantID = req.query.restaurantID;
    var page = req.query.page;
    
    messageDal.getMenuItemsByRestaurantID(restaurantID, page)
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
