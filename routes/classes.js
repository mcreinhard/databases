// Generated by CoffeeScript 1.7.1
(function() {
  var defaultCorsHeaders, express, messages, router, _;

  _ = require('underscore');

  express = require('express');

  messages = require('../ORM_Refactor/messages');

  router = express.Router();

  router.all('/*', function(req, res, next) {
    res.set(defaultCorsHeaders);
    return next();
  });

  router.route('/:roomname').get(function(req, res, next) {
    var roomname;
    if ((req.param('roomname')) !== 'messages') {
      roomname = req.param('roomname');
    }
    return messages.get(roomname).then(function(results) {
      return res.json(200, {
        results: results
      });
    })["catch"](function(err) {
      return next(err);
    });
  }).post(function(req, res, next) {
    var message;
    message = req.body;
    if ((req.param('roomname')) !== 'messages') {
      _(message).extend({
        roomname: req.param('roomname')
      });
    }
    return messages.add(message).then(function() {
      return res.send(201);
    })["catch"](function(err) {
      return next(err);
    });
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
