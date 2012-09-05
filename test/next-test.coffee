vows = require 'vows'
assert = require 'assert'
phantom = require 'phantom'
sys = require 'sys'

describe = (name, bat) -> vows.describe(name).addBatch(bat).export(module)

# Make coffeescript not return anything
# This is needed because vows topics do different things if you have a return value
t = (fn) ->
	(args...) ->
		fn.apply this, args
		return

describe "Blog next"
	"A page":
		topic: t ->
			test = this
			phantom.create (p) ->
				p.createPage (page) ->
					test.callback null, page, p

		"can open a URL on localhost":
			topic: t (page) ->
				page.open "http://127.0.0.1:10113/", (status) =>
					page.includeJs "http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"
					@callback null, page, status

			"and succeed": (err, page, status) ->
				assert.equal status, "success"

			"and the page, once it loads,":
				topic: t (page) ->
					setTimeout =>
						@callback null, page
					, 1000

				"has a button":
					topic: t (page) ->
						page.evaluate (-> $("a.btn.small.primary").text()), (next) => @callback null, next

					"which has text": (next) ->
						assert.equal next, "La suite..."

				"has a next link":
					topic: t (page) ->
						page.evaluate (->
							elem = document.querySelector("a.btn.small.primary")
							return false if !elem
							evt = document.createEvent("MouseEvents")
							evt.initMouseEvent("click", true, true, window, 1, 1, 1, 1, 1, false, false, false, false, 0, null)
							if elem.dispatchEvent(evt)
								return elem.getAttribute('href')
							if elem.hasAttribute('href')
								document.location = elem.getAttribute('href')
								return elem.getAttribute('href')
							return null
						), (next) => @callback null, next

					"which has a next url": (next) ->
						assert.equal next, "/next"

		teardown: (page, ph) ->
			ph.exit()

