express = require 'express'
routes = require './app/routes'
config = require './config'
port = config.port

app = express()
routes app

app.listen port, -> console.log "Node server started on port #{port}"
