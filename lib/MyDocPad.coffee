# Requires
docpad = require 'docpad'
util = require 'bal-util'

module.exports.MyDocPad = class MyDocPad extends docpad.Docpad
	# Init
	constructor: ({rootPath,outPath,srcPath,skeleton,maxAge,port,server,logLevel}={}) ->
		super {rootPath,outPath,srcPath,skeleton,maxAge,port,server,logLevel}
		@logger.log 'info', 'Using MyDocPad'
	

