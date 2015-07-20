deployd = require "deployd"
Connector = (dbOptions) ->
  config =
    db:
      host: dbOptions.host
      port: dbOptions.port
      name: dbOptions.name

  connector = deployd(config)

module.exports = Connector