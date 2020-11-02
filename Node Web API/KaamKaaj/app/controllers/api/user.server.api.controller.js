var userDal = require('../../eatery.dal/user.dal.js');

exports.createNewUser = function (req, res) {
    var userModel = req.body.userModel;
    
    userDal.createNewUser(userModel)
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

exports.deleteUser = function (req, res) {
    var userModel = req.body.userModel;
    var userID = req.body.userID;

    userDal.deleteUser(userModel, userID)
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

exports.getUserByEmail = function (req, res) {
    var email = req.query.email;

    userDal.getUserByEmail(email)
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

exports.getUserByEmailPassword = function (req, res) {
    var email = req.param.email;
    var password = req.param.password;

    userDal.getUserByEmailPassword(email, password)
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

exports.getUserById = function (req, res) {
    var userID = req.query.userID;

    userDal.getUserById(userID)
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

exports. GetUsernameById = function (req, res) {
    var userID = req.query.userID;

    userDal. GetUsernameById(userID)
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

exports.GetUserIdByUsername = function (req, res) {
    var username = req.query.username;

    userDal.GetUserIdByUsername(username)
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