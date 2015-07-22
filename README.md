# dpd-externalcollection
Deployd plugin. Store a collectin in a different mongodb instance

## Installation

In your apps root folder:

	npm install dpd-externalcollection

## Usage

From your Deployd dashboard click the "+" to add a new collection and choose "External Collection".

Under the newly created collection choose the *config* tab and insert host, port and db name of the mongodb instance you want to use. Make sure that the db is running before doing this!

# Switching between databases!

You can even switch between databases! It's as simple as changing the config. This can be very handy during development.

