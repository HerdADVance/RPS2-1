require 'sinatra'
require 'digest/sha1'
require_relative 'lib/rpsrunner.rb'
enable:sessions

set:bind, '0.0.0.0'

get '/' do
  erb :index
end

post '/matches' do
  @username = params[:username]
  @display = params[:display]
  @password = params[:password]
  @siusername = params[:siusername]
  @sipassword = params[:sipassword]
  erb :matches
end

post '/signup' do 
  @username = params[:username]
  @display = params[:display]
  @password = params[:password]
  @password = Digest::SHA1.hexdigest @password
  if RPS.orm.getplayerbyusername(@username).first != nil
    erb :error
  else
    RPS.orm.createplayer(@display, @username, @password)
    RPS::SignIn.run(params)
    erb :matches
  end

end


post '/signin' do 
  result = RPS::SignIn.run(params)
  if result[:success?]
    session[:sesh_id]=result[:session_id]
    erb :matches
  end
end








# post '/' do
#   user_input = params[:word]
#   @t = PigLatin.word(user_input)
#   @x = 5
#   erb :translate
# end