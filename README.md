# Web Frameworks Performance

A comprehensive performance comparison of web frameworks.

This work intends to extend the findings of [Abbade et al. on Performance Comparison of Programming Languages for Internet of Things Middleware](https://onlinelibrary.wiley.com/doi/abs/10.1002/ett.3891), in which Python's Flask, Javascript's Express, and Java's Spring, were compared in an IoT Middleware scenario. In this work, the focus has been shifted to web applications. The following frameworks are tested (the source code for each API is in a folder with its name):

+ :black_square_button: C# - [.net](https://docs.microsoft.com/en-us/dotnet/)
+ :black_square_button: C++ - [Oat++](https://github.com/oatpp/oatpp)
+ :black_square_button: C++ - [Poco](https://pocoproject.org/)
+ :black_square_button: C++ - [Silicon](https://github.com/matt-42/silicon)
+ :black_square_button: C++ - [Websocketpp](https://github.com/zaphoyd/websocketpp)
+ :black_square_button: C++ - [Wt](https://www.webtoolkit.eu/wt/)
+ :black_square_button: Clojure - [Composure](https://github.com/metosin/compojure-api)
+ :black_square_button: Elixir - [Phoenix](https://www.phoenixframework.org/)
+ :black_square_button: Go - [FastHTTP](https://github.com/valyala/fasthttp)
+ :black_square_button: Go - [Gin](https://github.com/gin-gonic/gin)
+ :black_square_button: Go - [Mux](https://github.com/gorilla/mux)
+ :black_square_button: Go - [Net/http](https://golang.org/pkg/net/http/)
+ :white_check_mark: Java - [Jooby](https://github.com/jooby-project/jooby)
+ :white_check_mark: Java - [Proteus](https://github.com/noboomu/proteus)
+ :white_check_mark: Java - [Reactive Spring](https://spring.io/reactive)
+ :white_check_mark: Java - [Spring](https://spring.io/)
+ :white_check_mark: Java - [Vertx](https://vertx.io/)
+ :white_check_mark: Javascript - [Express](https://expressjs.com/)
+ :white_check_mark: Javascript - [Fastify](https://www.fastify.io/)
+ :white_check_mark: Javascript - [Koa](https://koajs.com/)
+ :white_check_mark: Javascript - [Node.js](https://nodejs.org/en/)
+ :white_check_mark: Javascript - [Restify](http://restify.com/)
+ :black_square_button: Kotlin - [Ktor](https://ktor.io/)
+ :white_check_mark: PHP - [Laravel](https://laravel.com/)
+ :white_check_mark: Python - [AIOHTTP](https://docs.aiohttp.org/en/stable/)
+ :white_check_mark: Python - [Bottle](https://bottlepy.org/docs/dev/)
+ :white_check_mark: Python - [CherryPy](https://cherrypy.org/)
+ :white_check_mark: Python - [Django](https://www.djangoproject.com/)
+ :white_check_mark: Python - [Django ASGI](https://docs.djangoproject.com/en/3.0/howto/deployment/asgi/)
+ :white_check_mark: Python - [FastAPI](https://fastapi.tiangolo.com/)
+ :white_check_mark: Python - [Flask](https://flask.palletsprojects.com/en/1.1.x/)
+ :white_check_mark: Python - [Pyramid](https://trypyramid.com/)
+ :white_check_mark: Python - [Sanic](https://sanic.readthedocs.io/en/latest/)
+ :white_check_mark: Python - [Tornado](https://www.tornadoweb.org/en/stable/)
+ :black_square_button: R - [Plumber](https://www.rplumber.io/)
+ :black_square_button: Ruby - [Rails](https://rubyonrails.org/)
+ :black_square_button: Rust - [Actix](https://actix.rs/)
+ :black_square_button: Rust - [Rocket](https://github.com/SergioBenitez/Rocket)
+ :white_check_mark: Scala - [Play](https://www.playframework.com/)

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
