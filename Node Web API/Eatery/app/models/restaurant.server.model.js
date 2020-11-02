var mongoose = require('mongoose');

var restaurantSchema = new mongoose.Schema({

	userID : [{ type: mongoose.Schema.Types.ObjectId, ref: 'user', required: true }],

	menuItems: [{ type: mongoose.Schema.Types.ObjectId, ref: 'menuItem' }],

	restaurantRating: [{ type: mongoose.Schema.Types.ObjectId, ref: 'restaurantRating' }],
	operationTiming: [{ type: mongoose.Schema.Types.ObjectId, ref: 'operationTiming' }],

    province: String,
	city: String,
	address: String,
	pinCode: String,
    
    createdBy : {
        type: mongoose.Schema.Types.ObjectId, 
        required: true
    },
	createdDate : {
        type: Date,
        required: true
    },
	updatedBy : {
			type: mongoose.Schema.Types.ObjectId
	},
	updatedDate : Date

});