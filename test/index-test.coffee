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

describe "Blog index"
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

				"has a title":
					topic: t (page) ->
						page.evaluate (-> document.title), (title) => @callback null, title

					"which is correct": (title) ->
						assert.equal title, "Le blog d'Olivier » Les derniers articles"

				"has page title":
					topic: t (page) ->
						page.evaluate (-> $("h1").text()), (title) => @callback null, title
					
					"which is correct": (title) ->
						assert.equal title, "Les derniers articles"

				"has topbar":
					topic: t (page) ->
						page.evaluate (-> $("#topbar").length), (topbar) => @callback null, topbar
					
					"which is no empty": (topbar) ->
						assert.equal topbar, 1

				"has topbar title":
					topic: t (page) ->
						page.evaluate (-> $("#topbar a.brand").text()), (title) => @callback null, title
					
					"which is correct": (title) ->
						assert.equal title, "Le blog d'Olivier"

				"has footer":
					topic: t (page) ->
						page.evaluate (-> $("footer").length), (footer) => @callback null, footer
					
					"which is no empty": (footer) ->
						assert.equal footer, 1

				"has footer":
					topic: t (page) ->
						page.evaluate (-> $("footer").length), (footer) => @callback null, footer
					
					"which is no empty": (footer) ->
						assert.equal footer, 1

				"has tags":
					topic: t (page) ->
						page.evaluate (-> $("#tags").length), (tags) => @callback null, tags
					
					"which is no empty": (tags) ->
						assert.equal tags, 1

				"has archives":
					topic: t (page) ->
						page.evaluate (-> $("#archives").length), (archives) => @callback null, archives
					
					"which is no empty": (archives) ->
						assert.equal archives, 1

