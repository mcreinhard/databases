_ = require 'underscore'

messages = {}

data = []

messages.add = (message) ->
  (message[key] ?= '') for key in ['username', 'text', 'roomname']
  message.createdAt = do (new Date()).toJSON
  data.push message

# Possible options:
#   order: 'property'          sorts by property
#   order: '-property'         sorts by property in decreasing order
#   filter: {property: value}  returns only messages with message[property] === value
messages.get = (options) ->
  filter = _.identity
  sort = _.identity
    
  if options?.filter?
    [key, val] = [k, v] for k, v of options.filter
    if key?
      filter = (list) -> _(list).filter ((x) -> x[key] is val)
    
  if options?.order?
    sort = 
      if options.order[0] is '-'
        (list) -> do (_(list).sortBy options.order[1..]).reverse
      else
        (list) -> _(list).sortBy options.order

  filter sort data

module.exports = messages
