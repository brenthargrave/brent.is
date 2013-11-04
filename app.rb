require 'sinatra'
require 'haml'

get '/' do
  if request.env["HTTP_HOST"].include? "tba.brent.is"
    redirect ENV["TBA_URL"]
  else
    haml :index
  end
end

