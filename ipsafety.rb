require 'net/http'

# Makes a HTTP GET request with the given URI. If the request succeeds, i.e.,
# we receive a 200 OK, the response is parsed and the result is returned as a
# string. Otherwise, returns a string containing the error.
def request(uri)
  response = Net::HTTP.get_response(uri)
  if response.class == Net::HTTPOK
    parse(response)
  else
    "Bad response: #{response}"
  end
end

# At least one of the services returns HTML; use a regular expression to extract the
# IP address from whatever we receive. Returns the IP address as a string
def parse(response)
  response.body.scan(/\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/)
end

uris = [
  URI('http://checkip.amazonaws.com/'),
  URI('http://checkip.dyndns.org/'),
  URI('http://ifconfig.me/ip'),
  URI('http://corz.org/ip/'),
]

uris.each do |uri|
  puts request(uri)
end
