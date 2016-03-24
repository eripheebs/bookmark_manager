ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require 'sinatra/flash'

require_relative './lib/link'
require_relative './lib/tag'
require_relative './lib/user'
require_relative './data_mapper_setup'

class Bookmark < Sinatra::Base
  use Rack::MethodOverride
  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb :home
  end

  get '/log-in' do
    erb :"log-in"
  end

  post '/log-in' do
    user = User.first(email: params[:email])
    if user.nil?
      flash.now[:error] = ["User does not exist!"]
      erb :"log-in"
    elsif user.authenticate(params[:password])
      redirect to('/links')
    else
      flash.now[:error] = user.errors.full_messages
      erb(:"log-in")
    end
  end

  delete '/sessions' do
    flash.keep[:notice] = "Goodbye!"
    session[:user_id] = nil
    redirect to '/'
  end

  get '/sign-up' do
    erb(:'sign-up')
  end

  post '/sign-up' do
    @user = User.new(first_name: params[:first_name], last_name: params[:last_name],
      email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to('/links')
    else
      flash.now[:error] = @user.errors.full_messages
      erb(:'sign-up')
    end
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/links' do
    @links = Link.all
    erb(:links)
  end


  get '/link/add' do
    erb(:add_link)
  end


  get '/tags/:name' do
    @name = params[:name]
    @links = Tag.all(:name => @name).links
    erb(:tag)
  end

  post '/link/add' do
    link = Link.create(title: params[:title], href: params[:href])
    tag = Tag.first_or_create(name: params[:tag])
    LinkTag.first_or_create(:link => link, :tag => tag)
    redirect to('/links')
  end

  get '/tag/add/:id' do
    id = params[:id].to_i
    @link = Link.get(id)
    erb :add_tag
  end

  post '/tag/add/:id' do
    id = params[:id].to_i
    link = Link.get(id)
    tag = Tag.first_or_create(name: params[:tag])
    LinkTag.first_or_create(:link => link, :tag => tag)
    redirect to('/links')
  end



  # start the server if ruby file executed directly
  run! if app_file == $0
end
