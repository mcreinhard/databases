// Generated by CoffeeScript 1.7.1
(function() {
  var defaultCorsHeaders, express, messages, router, _;

  _ = require('underscore');

  express = require('express');

  messages = require('../SQL/messages');

  router = express.Router();

  router.all('/*', function(req, res, next) {
    res.set(defaultCorsHeaders);
    return next();
  });

  router.route('/messages').get(function(req, res, next) {
    return messages.get(null, function(results) {
      return res.status(200).json({
        results: results
      });
    });
  }).post(function(req, res, next) {
    messages.add(req.body);
    return res.send(201);
  });

  router.route('/:roomname').get(function(req, res, next) {
    return messages.get(req.param('roomname'), function(results) {
      return res.status(200).json({
        results: results
      });
    });
  }).post(function(req, res, next) {
    messages.add(_(req.body).extend({
      roomname: req.param('roomname')
    }));
    return res.send(201);
  });

  module.exports = router;

  defaultCorsHeaders = {
    "access-control-allow-origin": "*",
    "access-control-allow-methods": "GET, POST, PUT, DELETE, OPTIONS",
    "access-control-allow-headers": "content-type, accept",
    "access-control-max-age": 10
  };

}).call(this);

//# sourceMappingURL=classes.map