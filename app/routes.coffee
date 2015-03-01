module.exports = (app) ->

  bodyParser = require 'body-parser'
  cors = require 'cors'

  app.use cors()
  app.use bodyParser.json()

  controller = require('../controllers/todo')()

  app.get '/', (req,res) ->
    controller.findAll(req.get 'host').then (todos) -> res.json todos

  app.get '/:id', (req,res) ->
    controller.findById(req.params['id'], req.get 'host').then (todo) ->
      res.json todo

  app.post '/', (req,res) ->
    controller.create(req.body, req.get 'host').then (todo) -> res.json todo

  app.patch '/:id', (req, res) ->
    controller.update(req.params['id'], req.body, req.get 'host').then (todo) ->
      res.json todo

  app.delete '/', (req, res) ->
    controller.deleteAll().then -> res.status(204).end()

  app.delete '/:id', (req, res) ->
    controller.deleteById(req.params['id']).then -> res.status(204).end()
