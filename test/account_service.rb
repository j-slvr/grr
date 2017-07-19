#!/usr/bin/env ruby

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(this_dir, '../lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grr-client'
require 'json'

@execution_times, *rest = ARGV

@logger = Logger.new(STDOUT)

@client = Grr::Client.new(Port: "6575", Host:"localhost" )



def rootRequest
    
    rootReq = Grr::RestRequest.new(
        method:       'GET',
        location:     '/', 
        queryString:  '', 
        headers:      'Accept: text/plain, Content-Type: application/json',
        body: ''
    )

    @client.request(rootReq)

end

def loginRequest

    loginReq = Grr::RestRequest.new(
        method:       'POST',
        location:     '/sessions', 
        queryString:  '', 
        headers:      'Accept: text/plain, Content-Type: application/json',
        body:         '{ "user": "00000001-3100-4444-9999-000000000001" }' #Userid of Kevin Cool Jr
    )

    resp = @client.request(loginReq)
    json = JSON.parse(resp.body)
    sessionId = json["id"]
    #sessionId = '6c0d9ced-13c7-482c-9e33-85ff633d4604'
    @logger.info("SessionId is #{sessionId}")

    sessionId

end

def sessionRequest(sId)

    sessionRequest = Grr::RestRequest.new(
        method:       'GET',
        location:     '/sessions/' + sId, 
        queryString:  'embed=user,permissions,features', 
        headers:      'Accept: text/plain, Content-Type: application/json',
        body:         ''
    )

    #session = @client.request(sessionRequest)
    reqArray = Array.new(@execution_times.to_i || 10, sessionRequest)
    @client.concurrentRequests(reqArray)

end


#sId = loginRequest
sessionRequest "4c1fd429-4917-43e2-9248-0fb36ed6928e"




