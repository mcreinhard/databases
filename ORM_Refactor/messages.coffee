Sequelize = require 'sequelize'
sequelize = new Sequelize 'chat', 'root', 'batterchalks'

Message = sequelize.define 'Message',
  username: Sequelize.STRING
  roomname: Sequelize.STRING
  text: Sequelize.STRING
  
messages = module.exports

messages.sync = (callback) ->
  Message.sync().done callback

messages.add = (message, callback) ->
  (message[key] ?= '') for key in ['username', 'roomname', 'text']
  newMessage = Message.build message
  newMessage.save().done callback

messages.get = (roomname, callback) ->
  options =
    order: 'createdAt DESC'
    limit: 100
  if roomname? then options.where = roomname: roomname
  Message.findAll options
    .done callback
  
