mysql = require 'mysql'

dbConnection = mysql.createConnection
  user: "root"
  password: "batterchalks"
  database: "chat"

do dbConnection.connect

messages = {}

# Callback takes parameter (err)
messages.add = (message, callback) ->
  (message[key] ?= '') for key in ['username', 'roomname', 'text']
  message.createdAt = do (new Date()).toJSON

  queryString = "INSERT INTO messages (username, roomname, text, createdAt)
                 values ('#{message.username}', '#{message.roomname}',
                 '#{message.text}', '#{message.createdAt}');"

  dbConnection.query queryString, callback

# Callback takes parameters (err, results) where results is the returned array of message
# objects
messages.get = (roomname, callback) ->

  queryString = "SELECT username, roomname, text FROM messages
                 #{if roomname? then ("WHERE roomname = '" + roomname + "'") else ""}
                 ORDER BY createdAt DESC;"

  dbConnection.query queryString, callback

module.exports = messages
