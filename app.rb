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
 if session[:sesh_id] #!= nil
    theid = session[:sesh_id]
    @userid = RPS::TS.finduser(theid)
    @matches = RPS.orm.displaymatches(@userid)
    @username = RPS.orm.getplayer(@userid).first['playername']
    #look in db to find all matches that only 
 end
  erb :matches
end


post '/games' do 
  if session[:sesh_id] #!= nil
    theid = session[:sesh_id]
    @userid = RPS::TS.finduser(theid)
    @matchid = params[:matchid]
    @username = RPS.orm.getplayer(@userid).first['playername']
    @games = RPS.orm.getgamesbymatch(@matchid)
 end
  erb :games
end

get '/games' do 
  if session[:sesh_id] #!= nil
    theid = session[:sesh_id]
    @userid = RPS::TS.finduser(theid)
    @username = RPS.orm.getplayer(@userid).first['playername']
    @matchid = params[:matchid]
    @games = RPS.orm.getgamesbymatch(@matchid)
 end
  erb :games
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
    session[:sesh_id] = hash[:session_id]
    #session[:display]=params[:username]
    redirect to('/matches')
  end
end


post '/signin' do 
  # params {"siusername"=>"ruin14", "sipassword"=>"1234"}
  # binding.pry
  result = RPS::SignIn.signinrun(params)
  if result[:success?]
    session[:sesh_id]=result[:session_id]
    session[:display]=params[:siusername]
    redirect to('/matches')
  end
end

post '/addmove' do
  @move = params[:playermove]
  @userid = params[:playerid]
  @matchid = params[:matchid]
  newpointlessobject = RPS::Games.new(@matchid)
  newpointlessobject.updatemove(@move, @userid, @matchid)
  # redirect to ('/games')
  redirect "/games?matchid=#{@matchid}"
end

post '/checkmatch' do 
  @userid = params[:userid]
  RPS::TS.checkmatch(@userid)
  redirect to('/matches')
end










# post '/' do
#   user_input = params[:word]
#   @t = PigLatin.word(user_input)
#   @x = 5
#   erb :translate
# end