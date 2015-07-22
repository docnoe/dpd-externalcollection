// Generated by CoffeeScript 1.9.0
var Collection, Connector, EventEmitter, ExternalCollection, debug, externalDbs, util, _;

util = require("util");

Collection = require(require.main.paths[0] + "/deployd/lib/resources/collection");

EventEmitter = require("events").EventEmitter;

_ = require("underscore");

debug = require("debug")("dpd-external-collection");

Connector = require("./lib/connector");

externalDbs = {};

ExternalCollection = (function() {
  ExternalCollection.dashboard = JSON.parse(JSON.stringify(Collection.dashboard));

  function ExternalCollection(name, options) {
    var config, connector;
    if (options) {
      config = options.config;
    }
    if (config && config.host && config.port && config.name && !externalDbs[name]) {
      debug("creating new store");
      connector = new Connector(config);
      externalDbs[name] = {};
      externalDbs[name].db = connector.db;
    }
    options.db = externalDbs[name] && externalDbs[name].db || options.db;
    Collection.apply(this, [name, options]);
    if (!this.properties) {
      this.properties = {};
    }
    return;
  }

  return ExternalCollection;

})();

util.inherits(ExternalCollection, Collection);

console.log(ExternalCollection.dashboard);

ExternalCollection.basicDashboard = {
  settings: [
    {
      name: 'host',
      type: 'text'
    }, {
      name: 'port',
      type: 'number'
    }, {
      name: 'name',
      type: 'text'
    }
  ]
};

ExternalCollection.prototype.clientGeneration = true;

ExternalCollection.dashboard.pages.push("config");

ExternalCollection.dashboard.pages.push("configu");

ExternalCollection.events = _.clone(Collection.events);

ExternalCollection.label = "External Collection";

ExternalCollection.defaultPath = "/external";

module.exports = ExternalCollection;
