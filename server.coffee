# Requires
docpad = require 'docpad'
mydocpad = require './lib/MyDocPad'
express = require 'express'
fs = require 'fs'
gzippo = require './lib/gzippo.js'
RSS = require 'rss'

# Variables
oneDay = 86400000
expiresOffset = oneDay * 0

# -------------------------------------
# Server

# Configuration
masterPort = process.env.PORT || 10113

# Create Server
masterServer = express.createServer()

# Setup DocPad
docpadPort = masterPort
docpadServer = masterServer

cache = []

# -------------------------------------
# Middlewares

configureDocPadInstance = (docpadInstance) ->
	# Static Middleware
	docpadInstance.action 'generate', (next) ->
		docpadInstance.action 'watch', (next) ->
			docpadInstance.action 'server', (next) ->
				docpadServer.use gzippo.staticGzip docpadInstance.outPath, { maxAge: expiresOffset }

				# Router Middleware
				docpadServer.use docpadServer.router

				# 404 Middleware
				docpadServer.use (req,res,next) ->
					cache.push { path: req.path, referer : req.header('Referer'), when: new Date() }
					fs.readFile __dirname + '/out/404.html', 'utf8', (err, text) ->
						res.send text, 404

				# 404 rss
				docpadServer.get '/404.xml', (req, res) ->
					feed = new RSS {
						title: 'Le Blog d Olivier: 404 feed'
						feed_url: 'http://blog.bazoud.com/404.xml'
						site_url: 'http://blog.bazoud.com'
						author: 'Olivier Bazoud'
					}
					for page in cache
						feed.item {
							title:  'blog.bazoud.com: 404 Not Found'
							description: page.referer + ' -> ' + page.path
							url: 'http://blog.bazoud.com/404.xml'
							author: 'Olivier Bazoud'
							date: page.when.toIsoDateString()
						}
					res.header "Content-Type", "text/xml; charset=UTF-8"
					res.send feed.xml(), 200

# Configure
docpadServer.configure 'development', () ->
	# Settings
	docpadInstance = new mydocpad.MyDocPad {
		logLevel: 6
		port: docpadPort
		maxAge: 0
		server: masterServer
		rootPath: __dirname
	}
	configureDocPadInstance docpadInstance

docpadServer.configure 'production', () ->
	# Settings
	docpadInstance = new mydocpad.MyDocPad {
		logLevel: 6
		port: docpadPort
		maxAge: expiresOffset
		server: masterServer
		rootPath: __dirname
	}
	configureDocPadInstance docpadInstance

# -------------------------------------
# Start Server

# Start Server
masterServer.listen masterPort
console.log 'Express server listening on port %d', masterServer.address().port

# DNS Servers
# masterServer.use express.vhost 'yourwebsite.*', docpadServer


# -------------------------------------
# Redirects

# Place your redirects here

# healthCheck
docpadServer.get '/healthCheck', (req, res) ->
	res.send 'ok', 200

# feeds
docpadServer.get '/feed', (req, res) ->
	res.redirect '/feed.xml', 301

docpadServer.get '/rss', (req, res) ->
	res.redirect '/rss.xml', 301

docpadServer.get '/atom', (req, res) ->
	res.redirect '/atom.xml', 301

# legacy
docpadServer.get '/feed/atom', (req, res) ->
	res.redirect '/atom.xml', 301
docpadServer.get '/feed/rss2', (req, res) ->
	res.redirect '/feed.xml', 301
docpadServer.get '/feed/rss2/comments', (req, res) ->
	res.redirect 'http://feeds.bazoud.com/bazoud/comments', 301
docpadServer.get '^/feed/tag/*$', (req, res) ->
	res.redirect '/feed.xml', 301
docpadServer.get '^/post/tag/*$', (req, res) ->
	res.redirect '/feed.xml', 301

docpadServer.get '^/wp-*$', (req, res) ->
  res.send 'Gone', 410

# images
docpadServer.get '/public/billets/eclipse1.png', (req, res) ->
	res.redirect '/images/eclipse1.png', 301
docpadServer.get '/public/billets/feisty/29.png', (req, res) ->
	res.redirect '/images/29.png', 301
docpadServer.get '/wp-content/uploads/eclipse2.png', (req, res) ->
	res.redirect '/images/eclipse2.png', 301

