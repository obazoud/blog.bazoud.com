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
					@callback null, page, status

			"and succeed": (err, page, status) ->
				assert.equal status, "success"

			"and the page, once it loads,":
				topic: t (page) ->
					setTimeout =>
						@callback null, page
					, 1000

				"has a next button":
					topic: t (page) ->
						page.evaluate (-> $(".btn").text()), (next) => @callback null, next
					
					"which has text": (next) ->
						assert.equal next, "La suite..."

