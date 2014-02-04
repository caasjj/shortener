require 'sinatra'
require 'active_record'
require 'pry'

###########################################################
# Configuration
###########################################################

set :public_folder, File.dirname(__FILE__) + '/public'

configure :development, :production do
    ActiveRecord::Base.establish_connection(
       :adapter => 'sqlite3',
       :database =>  'db/dev.sqlite3.db'
     )
end

# Handle potential connection pool timeout issues
after do
    ActiveRecord::Base.connection.close
end

###########################################################
# Models
###########################################################
# Models to Access the database through ActiveRecord.
# Define associations here if need be
# http://guides.rubyonrails.org/association_basics.html

class Link < ActiveRecord::Base
end

###########################################################
# Routes
###########################################################

get '/' do  
    @links =  Link.find(:all)
    erb :index
end

get '/new' do
    erb :form
end

get '/:id' do
  redirect to 'http://'.concat( Link.find_by_short(params[:id]).url ), 302
end

post '/new' do
  link = Link.new
  link.url = params[:url]
  l = Link.find_by_url( link.url )
  if l == nil
    link.short = Random.new.rand(100)
    link.save
    body link.short.to_s
  else
    body l.short.to_s
  end
  status 200  
end

# MORE ROUTES GO HERE