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

describe "Post techno"
	"A page":
		topic: t ->
			test = this
			phantom.create (p) ->
				p.createPage (page) ->
					test.callback null, page, p

		"can open a URL on localhost":
			topic: t (page) ->
				page.open "http://127.0.0.1:10113/articles/2011-11-02-ce-blog-change-de-technos/", (status) =>
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
						assert.equal title, "Le blog d'Olivier » Ce blog change de technos"

				"has page title":
					topic: t (page) ->
						page.evaluate (-> $("h1").text()), (title) => @callback null, title
					
					"which is correct": (title) ->
						assert.equal title, "Ce blog change de technos"

				"has navbar":
					topic: t (page) ->
						page.evaluate (-> $(".navbar.navbar-fixed-top").length), (topbar) => @callback null, topbar
					
					"which is no empty": (topbar) ->
						assert.equal topbar, 1

				"has topbar title":
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

				"has section":
					topic: t (page) ->
						page.evaluate (-> $("h2").length), (value) => @callback null, value

					"which are 4": (value) ->
						assert.equal value, 4

				"has top meta 1 post":
					topic: t (page) ->
						page.evaluate (-> $("#post_top_meta1").length), (value) => @callback null, value

					"which are 1": (value) ->
						assert.equal value, 1

				"has links":
					topic: t (page) ->
						page.evaluate (-> $("#post_top_meta1 a").length), (value) => @callback null, value

					"which are 11": (value) ->
						assert.equal value, 6

				"has permlink":
					topic: t (page) ->
						page.evaluate (-> $("#post_top_meta1 a")[0].getAttribute('href')), (value) => @callback null, value

					"which are href": (value) ->
						assert.equal value, "/articles/2011-11-02-ce-blog-change-de-technos/"

				"has comment link":
					topic: t (page) ->
						page.evaluate (-> $("#post_top_meta1 a")[1].getAttribute('href')), (value) => @callback null, value

					"which are href": (value) ->
						assert.equal value, "#disqus_thread"

				"has category link":
					topic: t (page) ->
						page.evaluate (-> $("#post_top_meta1 a")[2].getAttribute('href')), (value) => @callback null, value

					"which are href": (value) ->
						assert.equal value, "/category/Uncategorized"

				"has bottom social block":
					topic: t (page) ->
						page.evaluate (-> $("#social_bottom").length), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, 1

				"has social buttons":
					topic: t (page) ->
						page.evaluate (-> $("#social_bottom div.social").length), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, 4

				"has related articles":
					topic: t (page) ->
						page.evaluate (-> $("h3")[0].innerText), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, "Articles similaires"

				"has related articles list":
					topic: t (page) ->
						page.evaluate (-> $("table.table.table-striped tr").length), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, 5

				"has columns":
					topic: t (page) ->
						page.evaluate (-> $("table.table.table-striped tr td").length), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, 5

				"has comments":
					topic: t (page) ->
						page.evaluate (-> $("h3")[1].innerText), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, "Commentaires"

		teardown: (page, ph) ->
			ph.exit()

