module.exports = function (app) {

    var menuItemRatingApiController = require('../controllers/api/menuItemRating.server.api.controller');
	app.post('/api/menuItemRating/add', menuItemRatingApiController.add);
    app.delete('/api/menuItemRating/remove', menuItemRatingApiController.remove);
}