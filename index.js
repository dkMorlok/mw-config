require('coffee-script/register');
var Configurator = require('./src/Configurator');


module.exports = {

	createConfigurator: function() {
		var configurator = new Configurator();
		return configurator;
	}

};