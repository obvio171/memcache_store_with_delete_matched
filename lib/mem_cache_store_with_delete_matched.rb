class MemCacheStoreWithDeleteMatched < ActiveSupport::Cache::MemCacheStore

  module Common
    KEY = 'memcached_store_key_list'
  end
  
  def write(name, value, options = nil)
    without_key_list = options.delete(:without_key_list) if options
    unless without_key_list
    key_list = get_key_list
    unless key_list.include?(name)
      key_list << name 
        super(Common::KEY, key_list.to_yaml, options)
    end
    end
    super(name, value, options)
  end

  def delete_matched(matcher, options = nil)
    keys_to_remove = []
    key_list = get_key_list
    key_list.each do |name|
      if name.match(matcher)
        delete(name, options)
        keys_to_remove << name
      end
    end
    
    key_list -= keys_to_remove
    
    options = {} unless options
    options.merge(:without_key_list => true) #call original write method
    write(Common::KEY, key_list.to_yaml, options)
  end
  
  private 

  def get_key_list
    begin
      YAML.load(read(Common::KEY))
    rescue TypeError
      []
    end
  end
  
end
