module M2ySicred
  class Base
    def self.base_url
      M2ySicred.configuration.server_url
    end

    def self.fixie
      URI.parse M2ySicred.configuration.proxy
    end

    def self.base_headers
      headers = {}
      headers['Content-Type'] = 'application/json'
      headers['Authorization'] = "Bearer #{get_token}"
      headers
    end

    def self.url_encoded_headers
      headers = {}
      headers['Content-Type'] = 'application/x-www-form-urlencoded'
      headers['charset'] = 'utf-8'
      headers
    end

    def self.oauth_token_basic_auth
      {
        username: M2ySicred.configuration.client_id,
        password: M2ySicred.configuration.client_secret
      }
    end

    def self.oauth_body
      {
        grant_type: "password",
        username: M2ySicred.configuration.username,
        password: M2ySicred.configuration.password,
        scope: M2ySicred.configuration.scope
      }
    end

    def self.get_token
      headers = url_encoded_headers
      auth = oauth_token_basic_auth
      body = oauth_body
      url = M2ySicred.configuration.authorization_url + TOKEN_PATH

      HTTParty.post(url, headers: headers, body: URI.encode_www_form(body), basic_auth: auth).parsed_response['access_token']
    end

    def self.post_encoded(url, body, headers = {})
      headers = url_encoded_headers
      post(url, URI.encode_www_form(body), headers)
    end

    def self.post(url, body, headers = nil)
      headers = base_headers if headers.nil?
      puts "Sending POST request to URL: #{url}"
      response = HTTParty.post( url, headers: headers, body: body.to_json,
                                http_proxyaddr: fixie.host,
                                http_proxyport: fixie.port,
                                http_proxyuser: fixie.user,
                                http_proxypass: fixie.password)
      format_response(response)
    end

    def self.get(url, headers = nil)
      headers = base_headers if headers.nil?
      puts "Sending GET request to URL: #{url}"
      response = HTTParty.get(url, headers: headers,
                              http_proxyaddr: fixie.host,
                              http_proxyport: fixie.port,
                              http_proxyuser: fixie.user,
                              http_proxypass: fixie.password)
      format_response(response)
    end

    def self.put(url, body, headers = nil)
      headers = base_headers if headers.nil?
      puts "Sending PUT request to URL: #{url}"
      response = HTTParty.put(url, headers: headers, body: body.to_json,
                              http_proxyaddr: fixie.host,
                              http_proxyport: fixie.port,
                              http_proxyuser: fixie.user,
                              http_proxypass: fixie.password)
      format_response(response)
    end

    def self.format_response(original_response)
      response = original_response.parsed_response
      response = { body: response } if response.is_a?(Array)
      response = {} unless response.is_a?(Hash)
      response[:status_code] = original_response.code
      begin
        response[:original_request] = original_response.request.raw_body
        response[:url] = original_response.request.uri
      rescue StandardError
        response[:original_request] = nil
        response[:url] = nil
      end
      puts response
      response
    end
  end
end