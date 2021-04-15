require 'm2y_sicred/version'
require 'm2y_sicred/configuration/configuration'
require 'm2y_sicred/constants/constants'
require 'm2y_sicred/modules/base'
require 'm2y_sicred/modules/contract'

module M2ySicred
  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    config = configuration
    yield(config)
  end
end
