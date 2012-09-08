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
					page.includeJs "http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"
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

				"has navbar":
					topic: t (page) ->
						page.evaluate (-> $(".navbar.navbar-fixed-top").length), (navbar) => @callback null, navbar
					
					"which is no empty": (navbar) ->
						assert.equal navbar, 1

				"has navbar title":
					topic: t (page) ->
						page.evaluate (-> $(".navbar.navbar-fixed-top a.brand").text()), (title) => @callback null, title
					
					"which is correct": (title) ->
						assert.equal title, "Le blog d'Olivier"

				"has footer":
					topic: t (page) ->
						page.evaluate (-> $("footer").length), (footer) => @callback null, footer
					
					"which is no empty": (footer) ->
						assert.equal footer, 1

				"has tags section":
					topic: t (page) ->
						page.evaluate (-> $("#tags").length), (tags) => @callback null, tags
					
					"which is no empty": (tags) ->
						assert.equal tags, 1

				"has tags":
					topic: t (page) ->
						page.evaluate (-> $("#tags a").length), (tags) => @callback null, tags
					
					"which is no empty": (tags) ->
						assert.isTrue tags > 50

				"has archives section":
					topic: t (page) ->
						page.evaluate (-> $("#archives").length), (archives) => @callback null, archives

					"which is no empty": (archives) ->
						assert.equal archives, 1

				"has archives":
					topic: t (page) ->
						page.evaluate (-> $("#archives a").length), (archives) => @callback null, archives

					"which is no empty": (archives) ->
						assert.equal archives, 7

				"has posts entries":
					topic: t (page) ->
						page.evaluate (-> $("table.table.table-striped tr").length), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, 35

				"has columns":
					topic: t (page) ->
						page.evaluate (-> $("table.table.table-striped td").length), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, 70

		teardown: (page, ph) ->
			ph.exit()

