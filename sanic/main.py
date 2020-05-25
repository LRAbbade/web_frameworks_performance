from sanic import Sanic
from sanic import response

app = Sanic("hello_example")


@app.route("/")
async def test(request):
    return response.text('Hello World')


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000)
