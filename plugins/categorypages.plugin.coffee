# Requires
path = require 'path'
fs = require 'fs'
url = require 'url'
util = require 'bal-util'

docpadPath = path.dirname require.resolve 'docpad'
DocpadPlugin = require docpadPath + '/plugin.coffee'

# Define Plugin
class CategoryPagesPlugin extends DocpadPlugin
	# Plugin Name
	name: 'categorypages'
	categories: {}
	tmpPath: null

	constructor: ->
		@categories = {}

	# Cleaning has finished
	cleanFinished: ({docpad,logger},next) ->
		@tmpPath = docpad.rootPath + '/tmp/' + @name
		# Create docpad tmp directory
		tmpCategories = @tmpPath + '/category'
		util.rmdir @tmpPath, (err) ->
			logger.log 'warn', err  if err
			util.ensurePath tmpCategories, (err) ->
				logger.log 'warn', err  if err
				next()

	# Parsing all files has finished
	parseFinished: ({docpad,logger,util},next) ->
		@categories = {}
		@categories.meta = {}
		@categories.categories = []
		that = @

		# Prepare
		documents = docpad.documents
		logger.log 'debug', 'Generating categories'

		# Async
		tasks = new util.Group (err) ->
			logger.log 'debug', 'Generated categories'
			next err
		
		tasks.total = 2

		# Find documents
		documents.find {}, (err, docs, length) ->
			return tasks.exit err  if err
			docs.forEach (doc) ->
				if doc.relativeBase.indexOf('post') == 0
					if doc.categories
						doc.categories.forEach (category) ->
							if !that.categories.meta[category]
								that.categories.meta[category] = {}
								that.categories.meta[category].count = 0
								that.categories.meta[category].documents = []
							that.categories.meta[category].count++
							that.categories.meta[category].documents.push(doc)
							if that.categories.categories.indexOf(category) < 0
								that.categories.categories.push(category)
			that.categories.categories = that.categories.categories.sort()
			tasks.complete()

		# dump tags documents
		for key, value of @categories.meta
			fileFullPath = @tmpPath + '/category/' + key + '.html.markdown'
			logger.log 'debug', 'Generated category: ' + fileFullPath
			fs.writeFile fileFullPath, '---\nlayout: category\ncategory: ' + key + '\ntitle: Catégorie ' + key + '\n---', (err) ->
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
		logger.log 'debug', 'Set categories in Site'
		templateData.Site.categories = @categories
		templateData.site.categories = @categories
		next()

# Export
module.exports = CategoryPagesPlugin

