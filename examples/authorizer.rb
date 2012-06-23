require 'sinatra'
require 'wordpress-com'

set :views, File.dirname(__FILE__)
enable :sessions

get '/' do
  if params[:code]
    wpc = WordpressCom.new(session[:client_id], session[:client_secret])
    wpc.get_token(params[:code], session[:redirect_uri])
    session[:wpc] = wpc.serialize
    redirect to('/')
  elsif session[:wpc]
    haml :authorizer_result
  else
    haml :authorizer_form
  end
end

post '/' do
  session[:client_id] = params[:client_id]
  session[:client_secret] = params[:client_secret]
  session[:blog] = params[:blog]
  session[:redirect_uri] = request.url

  wpc = WordpressCom.new(session[:client_id], session[:client_secret])
  redirect to(
    if session[:blog]
      wpc.authorize_url(request.url, :blog => session[:blog])
    else 
      wpc.authorize_url(request.url)
    end )
end

post '/forget' do
  session.clear
  redirect to('/')
end
