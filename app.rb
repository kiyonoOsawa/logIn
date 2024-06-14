require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?
require './models'

enable :sessions

get '/' do
  if session[:user]
    erb :index
  else
    erb :sign_in
  end
end

get '/signin' do
  erb :sign_in
end

get '/signup' do
  erb :sign_up
end

post '/signin' do
  user = User.find_by(mail: params[:mail])
  if user && user.authenticate(params[:password])
    session[:user] = user.id
    redirect '/'
  else
    redirect '/signin'
  end
end

post '/signup' do
  user = User.create(name: params[:name], mail: params[:mail], password: params[:password], password_confirmation: params[:password_confirmation])
  if user.persisted?
    session[:user] = user.id
    redirect '/'
  else
    redirect '/signup'
  end
end
