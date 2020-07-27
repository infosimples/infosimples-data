require 'net/http'
require 'openssl'
require 'openssl/cipher'
require 'digest/sha2'
require 'base64'
require 'json'

module Infosimples
  module Data
    def self.new(token, args = {})
      Infosimples::Data::Client.new(token, args)
    end
  end
end

require 'infosimples/data/client'
require 'infosimples/data/code'
require 'infosimples/data/errors'
require 'infosimples/data/http'
require 'infosimples/data/version'
