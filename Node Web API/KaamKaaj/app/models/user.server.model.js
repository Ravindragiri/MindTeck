var mongoose = require('mongoose');

// these values can be whatever you want - we're defaulting to a
// max of 5 attempts, resulting in a 2 hour lock
var MAX_LOGIN_ATTEMPTS = 5,
    LOCK_TIME = 2 * 60 * 60 * 1000;

var userSchema = new mongoose.Schema({
    
    phoneNumber: { type: String, required: true },
    countryCode: String,
    country: String,
    
    province: String,
    city: String,
    address: String,
    pinCode: String,

    loc: {
        type: { type: String },
        coordinates: []
    },
    email: String,
    
    username: String,
    password: { type: String, required: true },
    passwordHash: String,
    lastName: { type: String, required: true },
    firstName: { type: String, required: true },
    dateOfBirth: Date,
    
    passwordSalt: String,
    userType: Number,
    
    createdBy : {
        type: mongoose.Schema.Types.ObjectId, 
    },
    createdDate : {
        type: Date,
    },
    updatedBy : {
        type: mongoose.Schema.Types.ObjectId
    },
    updatedDate : Date

});

userSchema.index( {
    loc: '2dsphere'
    //country: 'text', 
    //province: 'text', 
    //city: 'text', 
    //address: 'text', 
    //pinCode: 'text', 
    //lastName: 'text',
    //firstName: 'text'
});

userSchema.virtual('isLocked').get(function () {
    // check for a future lockUntil timestamp
    return !!(this.lockUntil && this.lockUntil > Date.now());
});
/*
userSchema.pre('save', function (next) {
    var user = this;
    
    // only hash the password if it has been modified (or is new)
    if (!user.isModified('password')) return next();
    
    // generate a salt
    bcrypt.genSalt(SALT_WORK_FACTOR, function (err, salt) {
        if (err) return next(err);
        
        // hash the password using our new salt
        bcrypt.hash(user.password, salt, function (err, hash) {
            if (err) return next(err);
            
            // set the hashed password back on our user document
            user.password = hash;
            next();
        });
    });
});

userSchema.methods.comparePassword = function (candidatePassword, callback) {
    bcrypt.compare(candidatePassword, this.password, function (err, isMatch) {
        if (err) return callback(err);
        callback(null, isMatch);
    });
};
*/
userSchema.methods.comparePassword = function (candidatePassword, callback) {
    var isMatch = candidatePassword == this.password;
    callback(null, isMatch);
};
userSchema.methods.incLoginAttempts = function (callback) {
    // if we have a previous lock that has expired, restart at 1
    if (this.lockUntil && this.lockUntil < Date.now()) {
        return this.update({
            $set: { loginAttempts: 1 },
            $unset: { lockUntil: 1 }
        }, callback);
    }
    // otherwise we're incrementing
    var updates = { $inc: { loginAttempts: 1 } };
    // lock the account if we've reached max attempts and it's not locked already
    if (this.loginAttempts + 1 >= MAX_LOGIN_ATTEMPTS && !this.isLocked) {
        updates.$set = { lockUntil: Date.now() + LOCK_TIME };
    }
    return this.update(updates, callback);
};

// expose enum on the model, and provide an internal convenience reference 
var reasons = userSchema.statics.failedLogin = {
    NOT_FOUND: 0,
    PASSWORD_INCORRECT: 1,
    MAX_ATTEMPTS: 2
};

exports.reasons = reasons;
exports.userSchema = userSchema;

mongoose.model('user', userSchema);