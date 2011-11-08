# Requires
path = require 'path'
cson = require 'cson'

docpadPath = path.dirname require.resolve 'docpad'
DocpadPlugin = require docpadPath + '/plugin.coffee'

# Define Plugin
class ConfigurationPlugin extends DocpadPlugin
	# Plugin Name
	name: 'configuration'
	config: null

	# Plugin priority
	priority: 100

	cleanAfter: ({},next) ->
		filename = "#{__dirname}/../../config.coffee"
		@docpad.logger.log 'info', 'Loading configuration file @ ' + filename
		if path.existsSync filename
			@config = cson.parseFileSync filename
			@docpad.logger.log 'info', 'Configuration file @ ' + filename + ' loaded.'
		else
			@docpad.logger.log 'warn', 'Configuration file not found: ' + filename
		next()

	renderBefore: ({templateData}, next) ->
		@docpad.logger.log 'debug', 'Setting configuration in Site template data'
		if @config
			@docpad.logger.log 'debug', 'Configuration in Site template data, done.'
			templateData.Site.config = @config
			templateData.site.config = @config
		next()

# Export
module.exports = ConfigurationPlugin

