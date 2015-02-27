express = require 'express'
cors = require 'cors'

mongoose = require 'mongoose'

app = express()
app.use cors()

bodyParser = require 'body-parser'
app.use bodyParser.json()

mongoose.connect 'mongodb://todo:todo@ds049651.mongolab.com:49651/heroku_app34400100'
mongoose.connection.on 'open', ->
  console.log 'Connected to db'
  Todo.remove (err) ->

Todo = mongoose.model 'Todo',
  id: Number
  order: Number
  title: String
  completed: Boolean

id = 0

add_url = (base, todo) ->
  todo.url = "http://#{base}/#{todo.id}"

app.get '/', (req,res) ->
  Todo.find().lean().exec (err, todos) ->
    add_url(req.get('host'), todo) for todo in todos
    res.json todos
    res.end()

app.get '/:id', (req,res) ->
  Todo.findOne({'id': req.params['id']}).lean().exec (err, todo) ->
    add_url req.get('host'), todo
    res.json todo
    res.end()

app.post '/', (req,res) ->
  todo = req.body
  todo.id = ++id
  todo.completed = false
  add_url req.get('host'), todo

  todo_mod = new Todo todo
  todo_mod.save (err) ->
    res.json todo
    res.end()

app.patch '/:id', (req, res) ->
  Todo.findOneAndUpdate({id: req.params['id']}, req.body).lean().exec (err, todo) ->
    add_url req.get('host'), todo
    res.json todo
    res.end()


app.delete '/', (req, res) ->
  Todo.remove (err) ->
    res.status(204).end()

app.delete '/:id', (req, res) ->
  Todo.remove {id: req.params['id']}, (err) ->
    res.status(204).end()

port = process.env.PORT || 8080

app.listen port, ->
  console.log "Node server started on port #{port}"
