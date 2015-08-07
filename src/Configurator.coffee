helpers = require('./helpers')


class Configurator

	config: null


	constructor: ->
		@config =
			params:
				rootDir: ''
		return


	addConfig: (config) ->
		helpers.extend(@config, config)
		return


	getConfig: (section = null) ->
		return if section then helpers.expand(@config[section], @config.params) else helpers.expand(@config, @config.params)


	setRootDir: (dir) ->
		@config.params.rootDir = dir
		return


module.exports = Configurator