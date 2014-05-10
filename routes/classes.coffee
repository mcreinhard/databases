_ = require 'underscore'
express = require 'express'
messages = require '../SQL/messages'

router = express.Router()

router.all '/*', (req, res, next) ->
  res.set defaultCorsHeaders
  do next

router.route '/messages'
  .get (req, res, next) ->
  # TODO: Error handling
    messages.get null, (results) ->
      res.status 200
        .json results: results
  .post (req, res, next) ->
    messages.add req.body
    res.send 201

router.route '/:roomname'
  .get (req, res, next) ->
    messages.get (req.param 'roomname'), (results) ->
      res.status 200
        .json results: results
  .post (req, res, next) ->
    messages.add _(req.body).extend roomname: req.param 'roomname'
    res.send 201

module.exports = router

defaultCorsHeaders =
  "access-control-allow-origin": "*"
  "access-control-allow-methods": "GET, POST, PUT, DELETE, OPTIONS"
  "access-control-allow-headers": "content-type, accept"
  "access-control-max-age": 10 # Seconds.

