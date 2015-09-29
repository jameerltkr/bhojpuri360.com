/* Site model Menu */
var mongoose = require('mongoose');

var menu = mongoose.Schema({
    menu_name: String,
    menu_url: String,
    description: String
});

var Menu = mongoose.model('Menu', menu);

module.exports = {
    Menu: Menu
};