require 'sinatra'
require 'sinatra/activerecord'
require './models/user'
require './models/post'

enable :sessions
set :database, {adapter: "postgresql", database: "rumblr"}

get '/' do

end

# Create account
get '/register' do

end

post '/register' do

end

# Sign in & out
get '/sign_in' do

end

post '/sign_in' do

end

get 'sign_out' do

end


