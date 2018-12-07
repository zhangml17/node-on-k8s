var http = require('http');

http.createServer(function(req,res){
  console.log('Received request for URL:'+req.url);
  res.writeHead(200);
  res.end('Hello World!');
}).listen(3000);
