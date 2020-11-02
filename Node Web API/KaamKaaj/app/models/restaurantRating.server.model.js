var mongoose = require('mongoose');

var restaurantRatingSchema = new mongoose.Schema({

    restaurantRatingValue : {
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

mongoose.model('restaurantRating', restaurantRatingSchema);