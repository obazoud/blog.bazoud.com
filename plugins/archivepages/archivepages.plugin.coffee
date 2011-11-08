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

	# Cleaning has finished
	cleanAfter: ({},next) ->
		@archives = {}
		@tmpPath = @docpad.config.rootPath + '/tmp/' + @name
		@docpad.logger.log 'info', 'Creating ' + @tmpPath
		# Create docpad tmp directory
		tmpArchives = @tmpPath + '/archive'
		util.rmdir @tmpPath, (err) ->
			@docpad.logger.log 'warn', err  if err
			util.ensurePath tmpArchives, (err) ->
				@docpad.logger.log 'warn', err  if err
				next()

	# Parsing all files has finished
	parseAfter: ({},next) ->
		@archives = {}
		@archives.meta = {}
		@archives.years = []
		that = @

		# Prepare
		documents = @docpad.documents
		@docpad.logger.log 'info', 'Generating archives'

		# Async
		tasks = new util.Group (err) ->
			that.docpad.logger.log 'info', 'Generated archives'
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
			tasks.complete()

		# dump archives documents
		for key, value of @archives.meta
			fileFullPath = @tmpPath + '/archive/' + key + '.html.markdown'
			@docpad.logger.log 'debug', 'Generated archive: ' + fileFullPath
			fs.writeFile fileFullPath, '---\nlayout: archive\narchive: ' + key + '\ntitle: Archive ' + key + '\n---', (err) ->
				@docpad.logger.log 'warn', err  if err

		# dump scan documents
		util.scandir(
			# Path
			@tmpPath,

			# File Action
			(fileFullPath,fileRelativePath,nextFile) ->
				document = that.docpad.createDocument(
					fullPath: fileFullPath
					relativePath: fileRelativePath
				)
				document.load (err) ->
					return nextFile err  if err
					document.contextualize (next) ->
						document.store()
						nextFile err

			# Dir Action
			false,

			# Next
			(err) ->
				that.docpad.logger.log 'warn', 'Failed to parse documents', err  if err
				tasks.complete err
		)

	# Rendering all files has started
	renderBefore: ({templateData},next) ->
		@docpad.logger.log 'debug', 'Set archives in Site'
		templateData.Site.archives = @archives
		templateData.site.archives = @archives
		next()

# Export
module.exports = ArchivePagesPlugin

