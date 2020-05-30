var restify = require('restify');

var server = restify.createServer();
server.get('/', (req, res, next) => {
    res.send('Hello World');
    next();
});

server.listen(8080, '0.0.0.0', function() {
  console.log('%s listening at %s', server.name, server.url);
});
