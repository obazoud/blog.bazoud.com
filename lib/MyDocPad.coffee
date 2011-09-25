# Requires
docpad = require 'docpad'
util = require 'bal-util'

module.exports.MyDocPad = class MyDocPad extends docpad.Docpad
	# Init
	constructor: ({rootPath,outPath,srcPath,skeleton,maxAge,port,server,logLevel}={}) ->
		super {rootPath,outPath,srcPath,skeleton,maxAge,port,server,logLevel}
		@logger.log 'info', 'Using MyDocPad'

	# Handle
	action: (action,next=null) ->
		# Prepare
		logger = @logger
		next or= -> process.exit()

		# Clear
		if @actionTimeout
			clearTimeout(@actionTimeout)
			@actionTimeout = null

		# Check
		if @loading
			@actionTimeout = setTimeout(
				=>
					@action(action, next)
				1000
			)
			return
		
		# Handle
		switch action
			when 'skeleton', 'scaffold'
				@skeletonAction (err) ->
					return @error(err)  if err
					next()

			when 'generate'
				@generateAction (err) ->
					return @error(err)  if err
					next()

			when 'watch'
				@watchAction (err) ->
					return @error(err)  if err
					logger.log 'info', 'DocPad is now watching you...'
					next()

			when 'server', 'serve'
				@serverAction (err) ->
					return @error(err)  if err
					logger.log 'info', 'DocPad is now serving you...'
					next()

			else
				@skeletonAction (err) =>
					return @error(err)  if err
					@generateAction (err) =>
						return @error(err)  if err
						@serverAction (err) =>
							return @error(err)  if err
							@watchAction (err) =>
								return @error(err)  if err
								logger.log 'info', 'DocPad is now watching and serving you...'
	
	# Trigger a plugin event
	# next(err)
	triggerEvent: (eventName,data,next) ->
		# Async
		logger = @logger
		tasks = new util.Group (err) ->
			logger.log 'debug', "Plugins completed for #{eventName}"
			next err
		tasks.total = @pluginsArray.length

		# Cycle
		for plugin in @pluginsArray
			data.docpad = @
			data.logger = logger
			data.util = util
			try
				plugin[eventName].apply plugin, [data,tasks.completer()]
			catch err
				logger.log 'debug', eventName + ' fails: ' + err

	# Server
	serverAction: (next) ->
		@triggerEvent 'serverBeforeConfiguration', {@server}, (err) ->
			next err
		@triggerEvent 'serverFinished', {@server}, (err) ->
			logger.log 'debug', 'next2'
			next err
		next()


