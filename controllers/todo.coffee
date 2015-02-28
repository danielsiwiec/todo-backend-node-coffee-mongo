module.exports = ->

  toWireType = (todo) ->
    id: todo.id
    title: todo.title
    order: todo.order
    completed: todo.completed

  addUrl = (base, todo) ->
    todo.url = "http://#{base}/#{todo.id}"
    todo

  Todo = require('../models/todo')()

  findAll: (baseUrl) ->
    Todo.find().exec().then (todos) ->
      addUrl(baseUrl, toWireType(todo)) for todo in todos

  findById: (id, baseUrl) ->
    Todo.findOne({'id': id}).exec().then (todo) ->
      addUrl baseUrl, toWireType(todo)

  create: (todo, baseUrl) ->
    todo.completed = false

    Todo.create(todo).then (todo) ->
      todo = toWireType(todo)
      addUrl baseUrl, todo

  update: (id, patch, baseUrl) ->
    Todo.findOneAndUpdate({id: id}, patch).exec().then (todo) ->
      addUrl baseUrl, toWireType(todo)

  deleteAll: ->
    Todo.remove().exec()

  deleteById: (id) ->
    Todo.remove({id: id}).exec()
