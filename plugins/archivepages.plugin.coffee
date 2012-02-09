# Requires
path = require 'path'
fs = require 'fs'
url = require 'url'
util = require 'bal-util'

docpadPath = path.dirname require.resolve 'docpad'
DocpadPlugin = require docpadPath + '/plugin.coffee'

# Define Plugin
class ArchivePagesPlugin extends DocpadPlugin
	# Plugin Name
	name: 'archivepages'
	archives: {}
	tmpPath: null

	constructor: ->
		@archives = {}

	# Cleaning has finished
	cleanFinished: ({docpad,logger},next) ->
		@tmpPath = docpad.rootPath + '/tmp/' + @name
		# Create docpad tmp directory
		tmpArchives = @tmpPath + '/archive'
		util.rmdir @tmpPath, (err) ->
			logger.log 'warn', err  if err
			util.ensurePath tmpArchives, (err) ->
				logger.log 'warn', err  if err
				next()

	# Parsing all files has finished
	parseFinished: ({docpad,logger,util},next) ->
		@archives = {}
		@archives.meta = {}
		@archives.years = []
		that = @

		# Prepare
		documents = docpad.documents
		logger.log 'debug', 'Generating archives'

		# Async
		tasks = new util.Group (err) ->
			logger.log 'debug', 'Generated archives'
			next err

		tasks.total = 2

		# Find documents
		documents.find {}, (err, docs, length) ->
			return tasks.exit err  if err
			docs.forEach (doc) ->
				if doc.relativeBase.indexOf('post') == 0
					created = new Date(doc.date).toString('yyyy')
					if !that.archives.meta[created]
						that.archives.meta[created] = {}
						that.archives.meta[created].count = 0
						that.archives.meta[created].documents = []
					that.archives.meta[created].count++
					that.archives.meta[created].documents.push(doc)
					if that.archives.years.indexOf(created) < 0
						that.archives.years.push(created)
			that.archives.years = that.archives.years.sort()
			for year, value of that.archives.meta
				that.archives.meta[year].documents = value.documents.sort (a, b) ->
					new Date(b.date) - new Date(a.date)
			tasks.complete()

		# dump archives documents
		for key, value of @archives.meta
			fileFullPath = @tmpPath + '/archive/' + key + '.html.markdown'
			logger.log 'debug', 'Generated archive: ' + fileFullPath
			fs.writeFile fileFullPath, '---\nlayout: archive\narchive: ' + key + '\ntitle: Archive ' + key + '\n---', (err) ->
				logger.log 'warn', err  if err

		# dump scan documents
		util.scandir(
			# Path
			@tmpPath,

			# File Action
			(fileFullPath,fileRelativePath,nextFile) ->
				document = docpad.createDocument(
					fullPath: fileFullPath
					relativePath: fileRelativePath
				)
				document.load (err) ->
					return nextFile err  if err
					document.save()
					nextFile err

			# Dir Action
			false,

			# Next
			(err) ->
				logger.log 'warn', 'Failed to parse documents', err  if err
				tasks.complete err
		)

	renderStarted: ({docpad, documents, templateData, logger, util}, next) ->
		logger.log 'debug', 'Set archives in Site'
		templateData.Site.archives = @archives
		templateData.site.archives = @archives
		next()

# Export
module.exports = ArchivePagesPlugin

