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

describe "Alias article GWT"
	"A page":
		topic: t ->
			test = this
			phantom.create (p) ->
				p.createPage (page) ->
					test.callback null, page, p

		"can open a URL on localhost":
			topic: t (page) ->
				page.open "http://localhost:10113/post/2008/07/31/Can-I-speed-up-the-GWT-compiler", (status) =>
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
						assert.equal title, "Le blog d'Olivier » How to speed up the GWT compiler ? (Part I)"

				"has page title":
					topic: t (page) ->
						page.evaluate (-> $("h1").text()), (title) => @callback null, title
					
					"which is correct": (title) ->
						assert.equal title, "How to speed up the GWT compiler ? (Part I)"

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

		teardown: (page, ph) ->
			ph.exit()

describe "Alias 1 article GWT"
	"A page":
		topic: t ->
			test = this
			phantom.create (p) ->
				p.createPage (page) ->
					test.callback null, page, p

		"can open a URL on localhost":
			topic: t (page) ->
				page.open "http://localhost:10113/post/2008/07/31/how-to-speed-up-the-gwt-compiler-part-i/", (status) =>
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
						assert.equal title, "Le blog d'Olivier » How to speed up the GWT compiler ? (Part I)"

				"has page title":
					topic: t (page) ->
						page.evaluate (-> $("h1").text()), (title) => @callback null, title
					
					"which is correct": (title) ->
						assert.equal title, "How to speed up the GWT compiler ? (Part I)"

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

		teardown: (page, ph) ->
			ph.exit()

describe "Alias 2 article GWT"
	"A page":
		topic: t ->
			test = this
			phantom.create (p) ->
				p.createPage (page) ->
					test.callback null, page, p

		"can open a URL on localhost":
			topic: t (page) ->
				page.open "http://localhost:10113/post/2008/07/31/can-i-speed-up-the-gwt-compiler/", (status) =>
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
						assert.equal title, "Le blog d'Olivier » How to speed up the GWT compiler ? (Part I)"

				"has page title":
					topic: t (page) ->
						page.evaluate (-> $("h1").text()), (title) => @callback null, title
					
					"which is correct": (title) ->
						assert.equal title, "How to speed up the GWT compiler ? (Part I)"

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

		teardown: (page, ph) ->
			ph.exit()


describe "Alias 3 article GWT"
	"A page":
		topic: t ->
			test = this
			phantom.create (p) ->
				p.createPage (page) ->
					test.callback null, page, p

		"can open a URL on localhost":
			topic: t (page) ->
				page.open "http://localhost:10113/post/2008/07/31/Can-I-speed-up-the-GWT-compiler-Part-I", (status) =>
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
						assert.equal title, "Le blog d'Olivier » How to speed up the GWT compiler ? (Part I)"

				"has page title":
					topic: t (page) ->
						page.evaluate (-> $("h1").text()), (title) => @callback null, title
					
					"which is correct": (title) ->
						assert.equal title, "How to speed up the GWT compiler ? (Part I)"

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

		teardown: (page, ph) ->
			ph.exit()

describe "Alias 4 article GWT"
	"A page":
		topic: t ->
			test = this
			phantom.create (p) ->
				p.createPage (page) ->
					test.callback null, page, p

		"can open a URL on localhost":
			topic: t (page) ->
				page.open "http://localhost:10113/post/2008/07/31/can-i-speed-up-the-gwt-compiler-part-i", (status) =>
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
						assert.equal title, "Le blog d'Olivier » How to speed up the GWT compiler ? (Part I)"

				"has page title":
					topic: t (page) ->
						page.evaluate (-> $("h1").text()), (title) => @callback null, title
					
					"which is correct": (title) ->
						assert.equal title, "How to speed up the GWT compiler ? (Part I)"

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

		teardown: (page, ph) ->
			ph.exit()

describe "Alias 5 article GWT"
	"A page":
		topic: t ->
			test = this
			phantom.create (p) ->
				p.createPage (page) ->
					test.callback null, page, p

		"can open a URL on localhost":
			topic: t (page) ->
				page.open "http://localhost:10113/post/2008-07-31-can-i-speed-up-the-gwt-compiler.html", (status) =>
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
						assert.equal title, "Le blog d'Olivier » How to speed up the GWT compiler ? (Part I)"

				"has page title":
					topic: t (page) ->
						page.evaluate (-> $("h1").text()), (title) => @callback null, title
					
					"which is correct": (title) ->
						assert.equal title, "How to speed up the GWT compiler ? (Part I)"

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

		teardown: (page, ph) ->
			ph.exit()

