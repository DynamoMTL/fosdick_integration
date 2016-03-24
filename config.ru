require 'rubygems'
require 'bundler'

Bundler.require(:default)

require 'raven'
use Raven::Rack

require "./fosdick_endpoint"
run FosdickEndpoint
