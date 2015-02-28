express = require 'express'
routes = require './app/routes'
config = require './config'

app = express()
routes app



app.listen config.port, ->
  console.log "Node server started on port #{config.port}"
