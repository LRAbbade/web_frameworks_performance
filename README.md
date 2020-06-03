# Web Frameworks Performance

A comprehensive performance comparison of web frameworks.

This work intends to extend the findings of [Abbade et al. on Performance Comparison of Programming Languages for Internet of Things Middleware](https://onlinelibrary.wiley.com/doi/abs/10.1002/ett.3891), in which Python's Flask, Javascript's Express, and Java's Spring, were compared in an IoT Middleware scenario. In this work, the focus has been shifted to web applications. The following frameworks are tested (the source code for each API is in a folder with its name):

+ C# - [.net](https://docs.microsoft.com/en-us/dotnet/)
+ C++ - [Oat++](https://github.com/oatpp/oatpp)
+ C++ - [Poco](https://pocoproject.org/)
+ C++ - [Silicon](https://github.com/matt-42/silicon)
+ C++ - [Websocketpp](https://github.com/zaphoyd/websocketpp)
+ C++ - [Wt](https://www.webtoolkit.eu/wt/)
+ Clojure - [Composure](https://github.com/metosin/compojure-api)
+ Elixir - [Phoenix](https://www.phoenixframework.org/)
+ Go - [FastHTTP](https://github.com/valyala/fasthttp)
+ Go - [Gin](https://github.com/gin-gonic/gin)
+ Go - [Mux](https://github.com/gorilla/mux)
+ Go - [Net/http](https://golang.org/pkg/net/http/)
+ Java - [Jooby](https://github.com/jooby-project/jooby)
+ Java - [Proteus](https://github.com/noboomu/proteus)
+ Java - [Reactive Spring](https://spring.io/reactive)
+ Java - [Spring](https://spring.io/)
+ Javascript - [Express](https://expressjs.com/)
+ Javascript - [Fastify](https://www.fastify.io/)
+ Javascript - [Koa](https://koajs.com/)
+ Javascript - [Node.js](https://nodejs.org/en/)
+ Javascript - [Restify](http://restify.com/)
+ Kotlin - [Ktor](https://ktor.io/)
+ PHP - [Laravel](https://laravel.com/)
+ Python - [AIOHTTP](https://docs.aiohttp.org/en/stable/)
+ Python - [Bottle](https://bottlepy.org/docs/dev/)
+ Python - [CherryPy](https://cherrypy.org/)
+ Python - [Django](https://www.djangoproject.com/)
+ Python - [FastAPI](https://fastapi.tiangolo.com/)
+ Python - [Flask](https://flask.palletsprojects.com/en/1.1.x/)
+ Python - [Pyramid](https://trypyramid.com/)
+ Python - [Sanic](https://sanic.readthedocs.io/en/latest/)
+ Python - [Tornado](https://www.tornadoweb.org/en/stable/)
+ R - [Plumber](https://www.rplumber.io/)
+ Ruby - [Rails](https://rubyonrails.org/)
+ Rust - [Actix](https://actix.rs/)
+ Rust - [Rocket](https://github.com/SergioBenitez/Rocket)
+ Scala - [Play](https://www.playframework.com/)
+ Scala - [Vertx](https://vertx.io/)

The main objective is to test different languages and frameworks, both sync and async, to understand:

1. Are compiled programming languages really that much faster or does async make a bigger difference?
2. How much of a difference can you get in the same language with different frameworks?

Every API is built in a Docker container, the overall configuration of the container is the same for every framework.

There's a general test suite written in Python on the folder `tests/` to quickly test each API and assert it's working as expected, before proceeding to load tests. The tests will always reach for port 80, so you should route port 80 to your application port in Docker. To run it:

```sh
cd tests
pip install -r requirements.txt
python -m unittest
```

If you wish to contribute to this project, or believe a framework should be included, please consider forking this project or creating an issue, contributions are most welcomed.
