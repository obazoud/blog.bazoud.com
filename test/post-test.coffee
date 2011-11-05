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
				page.open "http://127.0.0.1:10113/post/2011-11-02-ce-blog-change-de-technos.html", (status) =>
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
						assert.equal archives, 5

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
						assert.equal value, 3

				"has permlink":
					topic: t (page) ->
						page.evaluate (-> $("#post_top_meta1 a")[0].getAttribute('href')), (value) => @callback null, value

					"which are href": (value) ->
						assert.equal value, "/post/2011-11-02-ce-blog-change-de-technos.html"

				"has comment link":
					topic: t (page) ->
						page.evaluate (-> $("#post_top_meta1 a")[1].getAttribute('href')), (value) => @callback null, value

					"which are href": (value) ->
						assert.equal value, "/post/2011-11-02-ce-blog-change-de-technos.html#disqus_thread"

				"has category link":
					topic: t (page) ->
						page.evaluate (-> $("#post_top_meta1 a")[2].getAttribute('href')), (value) => @callback null, value

					"which are href": (value) ->
						assert.equal value, "/category/Uncategorized"

				"has top meta 2 post":
					topic: t (page) ->
						page.evaluate (-> $("#post_top_meta2").length), (value) => @callback null, value

					"which are 1": (value) ->
						assert.equal value, 1

				"has tags":
					topic: t (page) ->
						page.evaluate (-> $("#post_top_meta2 a").length), (value) => @callback null, value

					"which are 11": (value) ->
						assert.equal value, 11

				"has bottom meta 1 post":
					topic: t (page) ->
						page.evaluate (-> $("#post_bottom_meta1").length), (value) => @callback null, value

					"which are 1": (value) ->
						assert.equal value, 1

				"has links":
					topic: t (page) ->
						page.evaluate (-> $("#post_bottom_meta1 a").length), (value) => @callback null, value

					"which are 11": (value) ->
						assert.equal value, 3

				"has permlink":
					topic: t (page) ->
						page.evaluate (-> $("#post_bottom_meta1 a")[0].getAttribute('href')), (value) => @callback null, value

					"which are href": (value) ->
						assert.equal value, "/post/2011-11-02-ce-blog-change-de-technos.html"

				"has comment link":
					topic: t (page) ->
						page.evaluate (-> $("#post_bottom_meta1 a")[1].getAttribute('href')), (value) => @callback null, value

					"which are href": (value) ->
						assert.equal value, "/post/2011-11-02-ce-blog-change-de-technos.html#disqus_thread"

				"has category link":
					topic: t (page) ->
						page.evaluate (-> $("#post_bottom_meta1 a")[2].getAttribute('href')), (value) => @callback null, value

					"which are href": (value) ->
						assert.equal value, "/category/Uncategorized"

				"has bottom meta 2 post":
					topic: t (page) ->
						page.evaluate (-> $("#post_bottom_meta2").length), (value) => @callback null, value

					"which are 1": (value) ->
						assert.equal value, 1

				"has tags":
					topic: t (page) ->
						page.evaluate (-> $("#post_bottom_meta2 a").length), (value) => @callback null, value

					"which are 11": (value) ->
						assert.equal value, 11

				"has top social block":
					topic: t (page) ->
						page.evaluate (-> $("#social_top").length), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, 1

				"has social buttons":
					topic: t (page) ->
						page.evaluate (-> $("#social_top div.social").length), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, 4

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
						page.evaluate (-> $("h3")[2].innerText), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, "Articles similaires"

				"has related articles":
					topic: t (page) ->
						page.evaluate (-> $("table.zebra-striped tr").length), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, 3

				"has columns":
					topic: t (page) ->
						page.evaluate (-> $("table.zebra-striped td").length), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, 3

				"has comments":
					topic: t (page) ->
						page.evaluate (-> $("h3")[3].innerText), (value) => @callback null, value

					"which is no empty": (value) ->
						assert.equal value, "Commentaires"

#
# not available @ localhost
#				"has new comment":
#					topic: t (page) ->
#						page.evaluate (-> $("h3")[5].innerText), (value) => @callback null, value
#
#					"which is no empty": (value) ->
#						assert.equal value, "Add New Comment"
#
#				"has reactions":
#					topic: t (page) ->
#						page.evaluate (-> $("h3")[7].innerText), (value) => @callback null, value
#
#					"which is no empty": (value) ->
#						assert.equal value, "Réactions"
#

		teardown: (page, ph) ->
			ph.exit()

