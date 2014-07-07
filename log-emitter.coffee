TailWatcher = require('./node-tail-watcher/tail-watcher').TailWatcher

class LogEmitter

  constructor: (filepath) ->
    @tail = new TailWatcher(filepath)
    @outputFunctions = []

    @tail.on 'push', (data) =>
      for item in @outputFunctions
        if typeof item is 'function'
          item(data)
        else if typeof item is 'object'
          item.emit data

    @tail.on 'error', (err) =>
      console.log err

  use: (item) =>
    @outputFunctions.push item

exports.LogEmitter = LogEmitter
