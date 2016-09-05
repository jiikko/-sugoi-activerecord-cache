class Rails
  class Cache
    def fetch(key, expire_in: nil)
      yield
    end
  end

  class << self
    def cache
      Cache.new
    end
  end
end
