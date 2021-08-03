module M2ySicred
  class Configuration
    attr_writer :server_url, :authorization_url, :username, :password, :scope, :client_secret, :client_id, :proxy, :env

    def initialize
      @server_url = nil
      @authorization_url = nil
      @username = nil
      @password = nil
      @scope = nil
      @client_id = nil
      @client_secret = nil
      @proxy = nil
      @env = nil
    end

    def server_url
      @server_url
    end

    def authorization_url
      @authorization_url
    end

    def username
      @username
    end

    def password
      @password
    end

    def scope
      @scope
    end

    def client_id
      @client_id
    end

    def client_secret
      @client_secret
    end

    def proxy
      @proxy
    end

    def env
      @env
    end

    def production?
      env.to_s.upcase == 'PRD'
    end
  end
end
