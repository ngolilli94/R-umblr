require 'sinatra'
require 'sinatra/activerecord'
require './models/user'
require './models/post'

enable :sessions

set :database, {adapter: "postgresql", database: "rumblr"}

get '/' do
    if session[:user_id]
        erb :user_homepage
    else
        erb :default_homepage
    end
end

# Create account
get '/register' do
    erb :register_form
end

post '/register' do
    @user = Users.create(
        username: params[:username], 
        password: params[:password]
        )

        # Log user in
        session[:user_id] = @user.id
        # Send to homepage
        redirect "/"
end

# Sign in & out
get '/sign_in' do
    erb :sign_in_form
end

post '/sign_in' do
    if @user && user.password == params[:password]
        session[:user_id] = @user.id
        redirect "/"
    else
        # need warning message

        redirect "/sign_in"
    end
end

get 'sign_out' do
    session[:user_id] = nil

    redirect "/"
end


