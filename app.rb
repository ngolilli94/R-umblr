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
    @user = User.create(
        username: params[:username], 
        password: params[:password],
        email: params[:email],
        first_name: params[:first_name],
        last_name: params[:last_name],
        birthday: params[:birthday]
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
    @user = User.find_by(username: params[:username])

    if @user && @user.password == params[:password]
        session[:user_id] = @user.id
        redirect "/"
    else
        # need warning message

        redirect "/sign_in"
    end
end

get '/sign_out' do
    session[:user_id] = nil

    redirect "/"
end

# Creating blog post
get '/create_post' do
    if session[:user_id]
        erb :create_post
    else
        erb :error_page
    end
end

post '/create_post' do
    @user = User.find_by(id: session[:user_id])

    @new_post = Post.create(
        title: params[:title],
        image: params[:image],
        content: params[:content],
        user_id: @user.id)
    if @new_post.save
        redirect "/post/#{@new_post.id}"
    else
        erb :create_post
    end

end

# Showing blog post
get '/post/:id' do
    @created_post = Post.find(params[:id])
  
    erb :show_single_post
end

# Showing all posts by single user
get '/user/:id/posts' do
    @single_user = User.find(params[:id])
    @user_posts = @single_user.posts

    erb :user_recent_posts
end



