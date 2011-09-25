zombie = require 'zombie'
assert = require 'assert'

browser = new zombie.Browser { debug: true, userAgent: 'ff' }

browser.on 'error', (err) ->
  console.log 'Error:', err

browser.on 'loaded', () ->
  console.log 'loaded:', browser.html()


browser.visit 'http://localhost:10113/index.html', (err, browser, status) ->
	if err
		console.log err
	assert.equal(browser.text('title'), "Le blog d'Olivier » Les derniers articles")

