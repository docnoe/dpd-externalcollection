util = require("util")

Collection = require("#{require.main.paths[0]}/deployd/lib/resources/collection")
EventEmitter = require("events").EventEmitter
_ = require("underscore")
debug = require("debug")("dpd-external-collection")
Connector = require "./lib/connector"

externalDbs = {}

class ExternalCollection
  @prototype.clientGeneration = true;
  @dashboard = JSON.parse(JSON.stringify(Collection.dashboard))
  @dashboard.pages.push "config"
  @events = _.clone(Collection.events)
  @label = "External Collection"
  @defaultPath = "/external"
  constructor: (name, options) ->
    config = options.config if options
    if config and config.host and config.port and config.name
      dbConfigAsString = "#{config.host}#{config.port}#{config.name}"
      if not externalDbs[dbConfigAsString]
        debug "creating new store"

        externalDbs[dbConfigAsString] = {}
        externalDbs[dbConfigAsString].db = new Connector(config).db

    options.db = externalDbs[dbConfigAsString] and externalDbs[dbConfigAsString].db or options.db
    Collection.apply this, [name, options]
    @properties = {} unless @properties
    return

util.inherits ExternalCollection, Collection
# ExternalCollection.dashboard = _.clone Collection.dashboard
console.log ExternalCollection.dashboard
ExternalCollection.basicDashboard =
  settings: [{
    name: 'host'
    type: 'text'
  }, {
    name: 'port'
    type: 'number'
  }, {
    name: 'name'
    type: 'text'
  }]


module.exports = ExternalCollection

