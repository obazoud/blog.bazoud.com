# Requires
path = require 'path'
datejsPath = path.dirname require.resolve 'datejs'
datejs = require datejsPath + '/date-fr-FR.js'

docpadPath = path.dirname require.resolve 'docpad'
DocpadPlugin = require docpadPath + '/plugin.coffee'

class ModuleaddonsPlugin extends DocpadPlugin
	# Plugin Name
	name: 'moduleaddons'

	# Parsing all files has finished
	cleanFinished: ({docpad, logger, util}, next) ->
		next()

module.exports = ModuleaddonsPlugin
