# Requires
path = require 'path'
fs = require 'fs'
url = require 'url'
util = require 'bal-util'

docpadPath = path.dirname require.resolve 'docpad'
DocpadPlugin = require docpadPath + '/plugin.coffee'

# Define Plugin
class TagPagesPlugin extends DocpadPlugin
	# Plugin Name
	name: 'tagpages'
	tags: {}
	tmpPath: null

	# Cleaning has finished
	cleanAfter: ({},next) ->
		@tmpPath = @docpad.config.rootPath + '/tmp/' + @name
		@docpad.logger.log 'info', 'Creating ' + @tmpPath
		# Create docpad tmp directory
		tmpTags = @tmpPath + '/tag'
		util.rmdir @tmpPath, (err) ->
			@docpad.logger.log 'warn', err  if err
			util.ensurePath tmpTags, (err) ->
				@docpad.logger.log 'warn', err  if err
				next()

	# Parsing all files has finished
	parseAfter: ({},next) ->
		@tags = {}
		@tags.meta = {}
		@tags.tags = []
		that = @

		# Prepare
		documents = @docpad.documents
		@docpad.logger.log 'info', 'Generating tags'

		# Async
		tasks = new util.Group (err) ->
			that.docpad.logger.log 'info', 'Generated tags'
			next err
		
		tasks.total = 2

		# Find documents
		documents.find {}, (err, docs, length) ->
			return tasks.exit err  if err
			docs.forEach (doc) ->
				if doc.relativeBase.indexOf('post') == 0
					if doc.tags
						doc.tags.forEach (tag) ->
							if !that.tags.meta[tag]
								that.tags.meta[tag] = {}
								that.tags.meta[tag].count = 0
								that.tags.meta[tag].documents = []
							that.tags.meta[tag].count++
							that.tags.meta[tag].documents.push(doc)
							if that.tags.tags.indexOf(tag) < 0
								that.tags.tags.push(tag)
			that.tags.tags = that.tags.tags.sort()
			tasks.complete()

		# dump tags documents
		for key, value of @tags.meta
			fileFullPath = @tmpPath + '/tag/' + key + '.html.markdown'
			@docpad.logger.log 'debug', 'Generated tag: ' + fileFullPath
			fs.writeFile fileFullPath, '---\nlayout: tag\ntag: ' + key + '\ntitle: Tag ' + key + '\n---', (err) ->
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
		@docpad.logger.log 'debug', 'Set tags in Site'
		templateData.Site.tags = @tags
		templateData.site.tags = @tags
		next()

# Export
module.exports = TagPagesPlugin

