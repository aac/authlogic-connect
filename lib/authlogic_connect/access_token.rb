class AccessToken < ActiveRecord::Base
  belongs_to :user
  
  def client
    self.class.client
  end
  
  def consumer
    self.class.consumer
  end
  
  def service_name
    self.class.service_name
  end
  
  def settings
    self.class.settings
  end
  
  def config
    self.class.config
  end
  
  def get(path)
    
  end

  def version_path(path)
    path.insert(0, "/#{self.class.api_version}") unless self.class.api_version.nil?
  end
  
  class << self
    def service_name
      @service_name ||= self.to_s.underscore.scan(/^(.*?)(_token)?$/)[0][0].to_sym
    end
    
    def client
      raise "implement client in subclass"
    end
    
    def consumer
      raise "implement consumer in subclass"
    end
    
    def settings(site, hash = {})
      @settings = hash.merge(:site => site)
    end
    
    def config
      @settings ||= {}
      @settings.dup
    end
    
    def api_version(value = nil)
      config[:api_versions].try(:fetch, value || config[:api_version], nil)
    end
    
    protected
    
    def credentials
      @credentials ||= AuthlogicConnect.credentials(service_name)
    end
  end
  
end
