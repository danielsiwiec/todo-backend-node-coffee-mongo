module.exports = ->

  mongoose = require('../controllers/db')()

  autoIncrement = require 'mongoose-auto-increment'
  autoIncrement.initialize mongoose.connection

  todoSchema = new mongoose.Schema
    order: Number
    title: String
    completed: Boolean

  todoSchema.plugin autoIncrement.plugin,
    model: 'Todo'
    field: 'id'

  mongoose.model 'Todo', todoSchema
