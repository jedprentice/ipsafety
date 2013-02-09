ipsafety
========

Fun little asynchronous HTTP exercise in Ruby. We want to be able to retrieve our own public IP(v4) from 3rd party
provider. We are a little skeptical about the quality of these 3rd party services and want to be absolutely sure that we
are getting correct results. That's why we decided to query not just one, but four different services and only
accept a result if is confirmed by a second provider. We also want to perform our IP lookup as quickly
as possible and avoid delays. To accomplish that, we need to perform our lookups in parallel and return
results as soon as they are confirmed.
The process is as follows:
1. Send parallel requests to all four services
2. If you receive a success response (status 200) parse the body and extract the IP(v4)
3. Once you receive the same IP from two different providers, return the result immediately, don't
wait for any outstanding requests to complete
The services to query are:
* http://checkip.amazonaws.com/
* http://checkip.dyndns.org/
* http://ifconfig.me/ip
* http://corz.org/ip