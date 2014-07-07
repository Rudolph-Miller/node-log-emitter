request = require 'request'
async = require 'async'
aws = require 'aws-sdk'

class httpForward

  constructor: (@path, @method='post', @options) ->

  convert: (data, callback) =>
    if @options.convert
      @options.convert(data, callback)
    else if @options.json
      callback JSON.stringify data
    else
      callback data

  emit: (data) =>
    @convert data, (data) =>
      requestOptions =
        uri: @path
        method: @method
      if @options.json
        if typeof data is 'object'
          requestOptions.form = data
        else
          requestOptions.form = JSON.parse data
      else
        requestOptions.body = data

      requestOptions.headers = @options.headers if @options.headers
      request requestOptions, (err, body, data) =>
        if err
          console.log err
        else if @options.stdout
          console.log data

class dynamo

  constructor: (authonticateFilePath, @options) ->
    aws.config.loadFromPath authonticateFilePath
    @dynamo = new aws.DynamoDB

  convert: (data, callback) =>
    if @options.convert
      @options.convert(data, callback)
    else if @options.json
      callback JSON.stringify data
    else
      callback data

  emit: (data) =>
    @convert data, (data) =>
      if @options.emitter
        @options.emitter data
      else
        params =
          TableName: @options.tablename
          Item: {}
        async.forEach Object.keys(data), (key) ->
          #data[key] expected to be like {S: 'value'} etc
          params.Item[key] = data[key]
        @dynamo.putItem params, (err, data) ->
          if err
            console.log err

exports.httpForward = httpForward
exports.dynamo = dynamo
