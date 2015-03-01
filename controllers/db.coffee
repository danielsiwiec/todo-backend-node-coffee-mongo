module.exports = ->

  mongoose = require 'mongoose'
  config = require '../config'

  mongoose.connect config.dbUrl
  mongoose.connection.on 'open', -> console.log 'Connected to db'

  mongoose
