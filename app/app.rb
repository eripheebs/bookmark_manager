ENV['RACK_ENV'] ||='development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions

  get '/' do
  end

  get '/users/new' do
    erb :'users/sign_up'
  end

  post '/users' do
    user = User.create(
      username: params[:username],
      email: params[:email],
      password_digest: params[:password]
    )
    session[:user_id] = user.id
    redirect '/links'
  end

  helpers do
      def current_user
        @current_user ||= User.get(session[:user_id])
      end
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(
      url: params[:url],
      title: params[:title])
    tags = Tag.make_tags(params[:tags])
    tags.each do |name|
      tag = Tag.create(tag: name)
      link.tags << tag
    end
    link.save
    redirect '/links'
  end

  get '/links/tags/:tag' do
    tag = Tag.first(tag: params[:tag])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  run! if app_file == $0
end
