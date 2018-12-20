
require "oauth2"
require 'json'
require 'csv'


UID = ""
SECRET = ""
# Create the client with your credentials
client = OAuth2::Client.new(UID, SECRET, site: "https://api.intra.42.fr")
# Get an access token
token = client.client_credentials.get_token

# puts JSON.pretty_generate(user)

def get_info(login, token)
  user = token.get("/v2/users/#{login}").parsed
  puts user
  array = []
  array << user["first_name"]
  array << user["last_name"]
  array << user["email"]
  array << user["phone"]
  array << user["login"]
  CSV.open("students.csv", "ab") do |csv|
    csv << array
  end
end

# get_info('sycohen', token)

def main(token)
  logins = ['amelman','bvigne','cbreisch','clecalie','cuzureau','etrobert','flirus','galemair','gtaja','kprimice','lowczarc','male-gal','mbelalou','mbelloun','mgessa','mimhoff','mjoubert','mkhemakh','mpham','msaubin','mtordjma','piabdo','rodaniel','schatagn','sycohen','tavelino','thmelen','vbaudot','wbaridon','ydarlet','ylesueur', 'sycohen']
  for login in logins
    puts("next login", login)
    get_info(login, token)
  end
end

main(token)