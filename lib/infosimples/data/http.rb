module Infosimples::Data
  # Infosimples::Data::HTTP exposes common HTTP routines that can be used by the
  # Infosimples::Data API client.
  #
  class HTTP
    # Perform an HTTP request with support for multipart requests.
    #
    # @param [Hash] options Options hash.
    # @param options [String] url      URL to be requested.
    # @param options [Symbol] method   HTTP method (:get, :post, :multipart).
    # @param options [Hash]   payload  Data to be sent through the HTTP request.
    # @param options [Integer] http_timeout HTTP open/read timeout in seconds.
    #
    # @return [String] Response body of the HTTP request.
    #
    def self.request(options = {})
      uri     = URI(options[:url])
      method  = options[:method] || :get
      payload = options[:payload] || {}
      timeout = options[:http_timeout]
      headers = { 'User-Agent' => Infosimples::Data::USER_AGENT }

      case method
      when :get
        uri.query = URI.encode_www_form(payload)
        req = Net::HTTP::Get.new(uri.request_uri, headers)

      when :post
        req = Net::HTTP::Post.new(uri.request_uri, headers)
        req.set_form_data(payload)

      when :multipart
        req = Net::HTTP::Post.new(uri.request_uri, headers)
        boundary, body = prepare_multipart_data(payload)
        req.content_type = "multipart/form-data; boundary=#{boundary}"
        req.body = body

      else
        fail Infosimples::Data::ArgumentError, "Illegal HTTP method (#{method})"
      end

      http = Net::HTTP.new(uri.hostname, uri.port)
      http.use_ssl = true if (uri.scheme == 'https')
      http.open_timeout = timeout
      http.read_timeout = timeout + 10
      http.max_retries = 0 # default is max_retries = 1
      res = http.request(req)
      res.body

    rescue Net::OpenTimeout, Net::ReadTimeout
      raise Infosimples::Data::Timeout
    end

    # Prepare the multipart data to be sent via a :multipart request.
    #
    # @param [Hash] payload Data to be prepared via a multipart post.
    #
    # @return [String, String] Boundary and body for the multipart post.
    #
    def self.prepare_multipart_data(payload)
      boundary = 'randomstr' + rand(1_000_000).to_s # a random unique string

      content = []
      payload.each do |param, value|
        content << '--' + boundary
        content << "Content-Disposition: form-data; name=\"#{param}\""
        content << ''
        content << value
      end
      content << '--' + boundary + '--'
      content << ''

      [boundary, content.join("\r\n")]
    end
  end
end
