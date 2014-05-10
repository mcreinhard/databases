_ = require 'underscore'
express = require 'express'
messages = require '../ORM_Refactor/messages'

router = express.Router()

router.all '/*', (req, res, next) ->
  res.set defaultCorsHeaders
  messages.sync (err) -> next err

router.route '/:roomname'
  .get (req, res, next) ->
    unless (req.param 'roomname') is 'messages'
      roomname = req.param 'roomname'
    messages.get roomname, (err, results) ->
      if err then next err
      else res.json 200, results: results
  .post (req, res, next) ->
    message = req.body
    unless (req.param 'roomname') is 'messages'
      _(message).extend roomname: req.param 'roomname'
    messages.add message, (err) ->
      if err then next err
      else res.send 201

module.exports = router

defaultCorsHeaders =
  "access-control-allow-origin": "*"
  "access-control-allow-methods": "GET, POST, PUT, DELETE, OPTIONS"
  "access-control-allow-headers": "content-type, accept"
  "access-control-max-age": 10 # Seconds.

