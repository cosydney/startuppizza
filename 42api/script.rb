
require "oauth2"
require 'json'
require 'csv'


UID = 
SECRET = 
# Create the client with your credentials
client = OAuth2::Client.new(UID, SECRET, site: "https://api.intra.42.fr")
# Get an access token
token = client.client_credentials.get_token

# puts JSON.pretty_generate(user)

def get_info(login, token)
  user = token.get("/v2/users/#{login}").parsed
  array = []
  array << user["first_name"]
  array << user["phone"]
  array << user["login"]
  array << user["email"]
  array << user["last_name"]
  CSV.open("students.csv", "w") do |csv|
    csv << array
  end
end

get_info('sycohen', token)