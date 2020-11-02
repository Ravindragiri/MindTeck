global.getAllCountries = function () {
    var countries = require('country-data').countries;
    countries.all.select('alpha2 alpha3 name');
};