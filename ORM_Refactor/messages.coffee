Sequelize = require 'sequelize'
sequelize = new Sequelize 'chat', 'root', 'batterchalks'

User = sequelize.define 'User',
  username: Sequelize.STRING

Room = sequelize.define 'Room',
  roomname: Sequelize.STRING

Message = sequelize.define 'Message',
  text: Sequelize.STRING

User.hasMany Message
Room.hasMany Message
Message.belongsTo User
Message.belongsTo Room

User.sync().done (err) -> throw err if err
Room.sync().done (err) -> throw err if err
Message.sync().done (err) -> throw err if err

messages = module.exports

messages.add = (message, callback) ->
  (message[key] ?= '') for key in ['username', 'roomname', 'text']
  User.findOrCreate username: message.username
    .done (err, user) ->
      Room.findOrCreate roomname: message.roomname
        .done (err, room) ->
          newMessage = Message.build
            UserId: user.dataValues.id
            RoomId: room.dataValues.id
            text: message.text
          newMessage.save().done callback

messages.get = (roomname, callback) ->
  options =
    attributes: ['User.username', 'Room.roomname', 'text', 'createdAt']
    include: [User, Room]
    order: 'createdAt DESC'
    limit: 100
  if roomname? then options.where = 'Room.roomname': roomname
  Message.findAll options
    .done callback
  
