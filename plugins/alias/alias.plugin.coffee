# Requires
path = require 'path'
fs = require 'fs'
sys = require 'sys'
url = require 'url'

docpadPath = path.dirname require.resolve 'docpad'
DocpadPlugin = require docpadPath + '/plugin.coffee'

# Define Plugin
class AliasPlugin extends DocpadPlugin
	# Plugin Name
	name: 'alias'
	
	# ALiases
	aliases: {}

	# Plugin priority
	priority: 100

	# Parsing all files has finished
	parseAfter: ({},next) ->
		@aliases = {}
		# Prepare
		documents = @docpad.documents

		# Find documents
		that = @
		documents.find {}, (err, docs, length) ->
			docs.forEach (document) ->
        if document.aliases
          document.aliases.forEach (alias) ->
          	if document.url
              that.aliases[alias.toLowerCase()] = document.url.toLowerCase()
      next()

	# Setting up the server is starting
	serverBefore: ({},next) ->
    that = @
    @docpad.server.all '/', (req,res,next) ->
      p = req.param 'p', null
      if p
        if that.aliases[req.url.toLowerCase()]
          res.redirect(that.aliases[req.url.toLowerCase()], 301)
          res.end()
        else
          next()
      else
        next()

	# Setting up the server has finished
	serverAfter: ({server},next) ->
		that = @
		server.all /\/[a-z0-9\-]+\/?$/i, (req,res,next) =>
			if !req.url.toLowerCase().match('\/$')
        req.url = req.url + '/'
			if that.aliases[req.url.toLowerCase()]
        res.redirect(that.aliases[req.url.toLowerCase()], 301)
        res.end()
  		else
        next()

# Export
module.exports = AliasPlugin
