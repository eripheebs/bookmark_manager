ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'

require 'pry'
require_relative './lib/link'
require_relative './lib/tag'

require_relative './lib/helpers/database_helper'

class Bookmark < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb(:home)
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
