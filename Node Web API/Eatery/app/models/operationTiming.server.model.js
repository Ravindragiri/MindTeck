var mongoose = require('mongoose');

var restaurantRatingSchema = new mongoose.Schema({

    dayOfWeek: String,
    timeOpen: String,
    timeclosed: String,

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