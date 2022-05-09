# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require

Dir['./lib/**/*.rb'].sort.each { |file| require file }

configure do
  set :erb, escape_html: true
  set :show_exceptions, :after_handler if development?
  disable :dump_errors unless development?
end

get '/' do
  erb :index
end
