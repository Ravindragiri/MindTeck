var mongoose = require('mongoose');

var menuItemSchema = new mongoose.Schema({

	title: String,
	description: String,
	
	price: String,
	
    menuItemRatings: [{ type: mongoose.Schema.Types.ObjectId, ref: 'menuItemRating' }],
    
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