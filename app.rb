require 'sinatra'
require 'pry-byebug'
require 'digest/sha1'
require_relative 'lib/rpsrunner.rb'
enable:sessions

set:bind, '0.0.0.0'

get '/' do
  erb :index
end

get '/matches' do
 if session[:app_session_id] #!= nil
    theid = session[:app_session_id]
    @userid = RPS::TS.finduser(theid)
    @matches = RPS.orm.displaymatches(@userid)
    #look in db to find all matches that only 
 end
  erb :matches
end

post '/signup' do 
  @username = params[:username]
  @display = params[:display]
  @password = params[:password]
  @id = params[:id]
  @password = Digest::SHA1.hexdigest @password
  if RPS.orm.getplayerbyusername(@username).first
    erb :error
  else
    RPS.orm.createplayer(@display, @username, @password)
    hash = RPS::SignIn.run(params)
    # binding.pry
    session[:app_session_id] = hash[:session_id]
    redirect to('/matches')
  end
end


post '/signin' do 
  # params {"siusername"=>"ruin14", "sipassword"=>"1234"}
  result = RPS::SignIn.signinrun(params)
  if result[:success?]
    session[:sesh_id]=result[:session_id]
    redirect to('/matches')
  end
end








# post '/' do
#   user_input = params[:word]
#   @t = PigLatin.word(user_input)
#   @x = 5
#   erb :translate
# end