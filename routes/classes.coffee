_ = require 'underscore'
express = require 'express'
messages = require '../ORM_Refactor/messages'

router = express.Router()

router.all '/*', (req, res, next) ->
  res.set defaultCorsHeaders
  do next

router.route '/:roomname'
.get (req, res, next) ->
  unless (req.param 'roomname') is 'messages'
    roomname = req.param 'roomname'
  messages.get roomname
  .then (results) -> res.json 200, results: results
  .catch (err) -> next err
.post (req, res, next) ->
  message = req.body
  unless (req.param 'roomname') is 'messages'
    _(message).extend roomname: req.param 'roomname'
  messages.add message
  .then -> res.send 201
  .catch (err) -> next err

module.exports = router

defaultCorsHeaders =
  "access-control-allow-origin": "*"
  "access-control-allow-methods": "GET, POST, PUT, DELETE, OPTIONS"
  "access-control-allow-headers": "content-type, accept"
  "access-control-max-age": 10 # Seconds.
