var mongoose = require('mongoose');

var menuItemRatingSchema = new mongoose.Schema({

    menuItemRatingValue : {
        type: Number,
        required: true
    },
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

mongoose.model('menuItemRating', menuItemRatingSchema);