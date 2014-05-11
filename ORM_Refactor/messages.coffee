Promise = require 'bluebird'
Sequelize = require 'sequelize'
sequelize = new Sequelize 'chat', 'root', 'batterchalks'

User = sequelize.define 'User',
  username: Sequelize.STRING

Room = sequelize.define 'Room',
  roomname: Sequelize.STRING

Message = sequelize.define 'Message',
  text: Sequelize.STRING

Message.belongsTo User
Message.belongsTo Room

Promise.all (do Model.sync for Model in [User, Room, Message])
.catch (err) -> throw err

messages = module.exports

messages.add = (message) ->
  (message[key] ?= '') for key in ['username', 'roomname', 'text']
  User.findOrCreate username: message.username
  .then (user) ->
    message.UserId = user.dataValues.id
    Room.findOrCreate roomname: message.roomname
  .then (room) ->
    message.RoomId = room.dataValues.id
    newMessage = Message.build message
    do newMessage.save

messages.get = (roomname) ->
  options =
    attributes: ['User.username', 'Room.roomname', 'text', 'createdAt']
    include: [User, Room]
    order: 'createdAt DESC'
    limit: 100
  if roomname? then options.where = 'Room.roomname': roomname
  Message.findAll options
