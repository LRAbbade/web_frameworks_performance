from bottle import route, run, template


@route('/')
def index():
    return 'Hello World'

run(host='0.0.0.0', port=8080, server='gunicorn')
