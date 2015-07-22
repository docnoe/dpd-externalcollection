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
  @basicDashboard =
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
module.exports = ExternalCollection

