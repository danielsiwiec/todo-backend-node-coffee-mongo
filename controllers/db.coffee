module.exports = ->

  mongoose = require 'mongoose'

  mongoose.connect 'mongodb://todo:todo@ds049651.mongolab.com:49651/heroku_app34400100'
  mongoose.connection.on 'open', ->
    console.log 'Connected to db'

  mongoose
