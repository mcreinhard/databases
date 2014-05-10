mysql = require 'mysql'
### If the node mysql module is not found on your system, you may
   need to do an "sudo npm install -g mysql". 

   You'll need to fill the following out with your mysql username and password.
   database: "chat" specifies that we're using the database called
   "chat", which we created by running schema.sql.###
dbConnection = mysql.createConnection
  user: "root"
  password: "batterchalks"
  database: "chat"

do dbConnection.connect
### Now you can make queries to the Mysql database using the
   dbConnection.query() method.
   See https://github.com/felixge/node-mysql for more details about
   using this module.

   You already know how to create an http server from the previous
   assignment; you can re-use most of that code here. ###

messages = {}

messages.add = (message) ->
  (message[key] ?= '') for key in ['username', 'roomname', 'text']
  message.createdAt = do (new Date()).toJSON
  console.log message
  dbConnection.query "INSERT INTO messages
                        (username, roomname, text, createdAt)
                        values ('#{message.username}', '#{message.roomname}',
                          '#{message.text}', '#{message.createdAt}');", (err) ->
    throw err if err

messages.get = (roomname, callback) ->
  console.log roomname
  console.log "SELECT username, roomname, text FROM messages
                        #{if roomname? then ("WHERE roomname = '" + roomname + "'") else ""}
                        ORDER BY createdAt DESC;"
  dbConnection.query "SELECT username, roomname, text FROM messages
                        #{if roomname? then ("WHERE roomname = '" + roomname + "'") else ""}
                        ORDER BY createdAt DESC;", (err, rows) ->
    throw err if err
    console.log(rows)
    callback(rows)

module.exports = messages
