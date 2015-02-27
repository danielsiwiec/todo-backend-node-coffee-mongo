_ = require 'lodash'

express = require 'express'
cors = require 'cors'

app = express()
app.use cors()

bodyParser = require 'body-parser'
app.use bodyParser.json()

todo_db = {}
id = 0

app.get '/', (req,res) ->
  todos = (todo for id,todo of todo_db)
  res.json todos
  res.end()

app.get '/:id', (req,res) ->
  todo = todo_db[req.params['id']]
  res.json todo
  res.end()

app.post '/', (req,res) ->
  todo = req.body
  todo.id = ++id
  todo.completed = false
  todo.url = "http://#{req.get 'host'}/#{todo.id}"

  todo_db[id]=todo
  res.json todo
  res.end()

app.patch '/:id', (req, res) ->
  todo = todo_db[req.params['id']]
  _.merge todo, req.body
  todo_db[req.params['id']]=todo
  res.json todo
  res.end()

app.delete '/', (req, res) ->
  todo_db = {}
  res.status(204).end()

app.delete '/:id', (req, res) ->
  delete todo_db[req.params['id']]
  res.status(204).end()

port = process.env.PORT || 8080

app.listen port, ->
  console.log "Node server started on port #{port}"
