# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require

require_relative 'helpers'

configure do
  set :erb, escape_html: true
  set :sessions, true
  set :show_exceptions, :after_handler if development?
  disable :dump_errors unless development?

  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  use OmniAuth::Builder do
    provider :developer, fields: [:name], uid_field: :name
  end
end

helpers Helpers

get '/' do
  erb :index
end

post '/logout' do
  session.destroy
  redirect '/'
end

get '/auth/:provider/callback' do
  session[:user] = request.env['omniauth.auth']['info']['name']
  redirect '/'
end

if development?
  post '/auth/developer/callback' do
    session[:user] = request.env['omniauth.auth']['info']['name']
    redirect '/'
  end
end
