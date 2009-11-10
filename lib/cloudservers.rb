#!/usr/bin/env ruby
# 
# == Cloud Servers API
module CloudServers

  VERSION = '0.0.1'
  require 'net/http'
  require 'net/https'
  require 'uri'
  require 'digest/md5'
  require 'time'
  require 'rubygems'
  require 'json'

  unless "".respond_to? :each_char
    require "jcode"
    $KCODE = 'u'
  end

  $:.unshift(File.dirname(__FILE__))
  require 'cloudservers/authentication'
  require 'cloudservers/connection'
  require 'cloudservers/server'

end



class SyntaxException             < StandardError # :nodoc:
end
class ConnectionException         < StandardError # :nodoc:
end
class AuthenticationException     < StandardError # :nodoc:
end
class InvalidResponseException    < StandardError # :nodoc:
end
class ExpiredAuthTokenException   < StandardError # :nodoc:
end
