require 'em-http-request'

# At least one of the services returns HTML; use a regular expression to extract the
# IP address from the given response string. Returns the IP address as a string
def parse(response)
  response.scan(/\b(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\b/).first
end

uris = [
  'http://checkip.amazonaws.com/',
  'http://checkip.dyndns.org/',
  'http://ifconfig.me/ip',
  'http://corz.org/ip/',
]

responses = {}

EventMachine.run do
  uris.each do |uri|
    http = EventMachine::HttpRequest.new(uri).get
    http.callback do
      if http.response_header.status == 200
        responses[uri] = parse(http.response)
      end
      EventMachine.stop if responses.length == 2
    end
  end
end

responses.each do |uri, ip_address|
  puts "#{uri}\t#{ip_address}"
end