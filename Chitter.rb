require 'sinatra/base'
require 'sinatra/reloader'

class Chitter < Sinatra::Base
  configure :development do
    Sinatra::Reloader
  end

  get '/' do
    'Chitter'
  end

  run! if app_file == $0
end