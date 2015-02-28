module.exports = ->

  addUrl = (base, todo) ->
    todo.url = "http://#{base}/#{todo.id}"
    todo

  Todo = require('../models/todo')()

  findAll: (baseUrl) ->
    Todo.find().lean().exec (err, todos) ->
      addUrl(baseUrl, todo) for todo in todos

  findById: (id, baseUrl) ->
    Todo.findOne({'id': id}).lean().exec (err, todo) ->
      addUrl baseUrl, todo

  create: (todo, baseUrl) ->
    todo.completed = false

    Todo.create(todo).then (todo) ->
      todo = todo.toObject()
      addUrl baseUrl, todo

  update: (id, patch, baseUrl) ->
    Todo.findOneAndUpdate({id: id}, patch).lean().exec (err, todo) ->
      addUrl baseUrl, todo

  deleteAll: ->
    Todo.remove().exec()

  deleteById: (id) ->
    Todo.remove({id: id}).exec()
