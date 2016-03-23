ENV['RACK_ENV'] ||='development'

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  get '/' do
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
    tag = Tag.create(tag: params[:tags])
    link.tags << tag
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
