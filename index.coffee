util = require("util")

Collection = require("#{require.main.paths[0]}/deployd/lib/resources/collection")
EventEmitter = require("events").EventEmitter
_ = require("underscore")
debug = require("debug")("dpd-external-collection")
Connector = require "./lib/connector"

externalDbs = {}

class ExternalCollection
  @dashboard = JSON.parse(JSON.stringify(Collection.dashboard))
  constructor: (name, options) ->
    config = options.config if options
    if config and config.host and config.port and config.name and not externalDbs[name]
        debug "creating new store"

        connector = new Connector(config)
        externalDbs[name] = {}
        externalDbs[name].db = connector.db

    options.db = externalDbs[name] and externalDbs[name].db or options.db
    Collection.apply this, [name, options]
    @properties = {}  unless @properties
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

ExternalCollection.prototype.clientGeneration = true;
ExternalCollection.dashboard.pages.push "config"
ExternalCollection.dashboard.pages.push "configu"
ExternalCollection.events = _.clone(Collection.events)
ExternalCollection.label = "External Collection"
ExternalCollection.defaultPath = "/external"
module.exports = ExternalCollection

