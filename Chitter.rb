require 'sinatra/base'
require 'sinatra/reloader'
require 'sinatra/flash'
require './lib/peep'
require './lib/user'

# for accessing test database
# ENV['ENVIRONMENT'] = 'test'

class Chitter < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload './lib/peep'
  end

  configure :test, :development do
    register Sinatra::Flash
    enable :sessions
  end

  get '/' do
    p '/ params: ', params
    @peeps = Peep.get_all
    erb :index
  end

  post '/add' do
    flash[:notice] = 'Your post has no content!' unless Peep.add(content: params['content'])
    redirect '/'
  end

  get '/register' do
    erb :register
  end

  post '/register' do
    User.register(name: params['name'], username: params['username'], email: params['email'], password: params['password'])
    redirect '/'
  end

  post '/sign_in' do
    flash[:notice_wrong_details] = 'Incorrect details!' unless User.sign_in(params['username'], params['password'])
    redirect '/'
  end

  run! if app_file == $0
end
