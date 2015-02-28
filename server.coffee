express = require 'express'
port = process.env.PORT || 8080

app = express()

routes = require './app/routes'
routes app

app.listen port, ->
  console.log "Node server started on port #{port}"
