module Infosimples::Data
  # Infosimples::Data::Client is a client for the Infosimples Data API.
  class Client
    BASE_URL = 'https://data.infosimples.com/api/v1/:service.json'
    ENCRYPTABLE_ARGS = ['pkcs12_cert', 'pkcs12_pass', 'pass'].map {
      |arg| [arg, true]
    }.to_h

    attr_accessor :token, :timeout, :max_age

    # Create a Infosimples::Data API client.
    #
    # @param [String] Your access token.
    # @param [Hash]   options  Options hash.
    # @option options [Integer] :timeout (120)   Seconds before giving up of an
    #                                            automation being completed.
    # @option options [Integer] :max_age (86400) Duration in seconds for a
    #                                            cached automation to be
    #                                            allowed.
    #
    # @return [Infosimples::Data::Client] A Client instance.
    def initialize(token, options = {})
      self.token    = token
      self.timeout  = options[:timeout] || 120   # 120 seconds
      self.max_age  = options[:max_age] || 86400 # 24 hours in seconds
    end

    def automate(service, args = {})
      args.keys.each do |key|
        if ENCRYPTABLE_ARGS[key.to_s]
          args[key] = encrypt(args[key])
        end
      end
      request(service, :multipart, args)
    end

    # Get billing statistics from your account.
    #
    # @return [Array] Billing statistics per token.
    def billing
      request('billing', :get)
    end

    # Get prices for each service.
    #
    # @return [Array] Service with price.
    def pricing
      request('pricing', :get)
    end

    private

    def encrypt(data)
      @crypt ||= Infosimples::Data::SymmetricEncryption.new(token)
      @crypt.encrypt(data)
    end

    # Perform an HTTP request to the Infosimples Data API.
    #
    # @param [String] service  API method name.
    # @param [Symbol] method  HTTP method (:get, :post, :multipart).
    # @param [Hash]   payload Data to be sent through the HTTP request.
    #
    # @return [Hash] Parsed JSON from the API response.
    #
    def request(service, method = :get, payload = {})
      res = Infosimples::Data::HTTP.request(
        url: BASE_URL.gsub(':service', service),
        http_timeout: timeout,
        method: method,
        payload: payload.merge(
          token:   token,
          timeout: timeout,
          max_age: max_age,
          header:  1
        )
      )
      JSON.parse(res)
    end
  end
end
