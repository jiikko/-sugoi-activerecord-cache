require "sugoi_activerecord_cache/version"

module SugoiActiverecordCache
  module Base
    def cache_key
      self.table_name
    end

    def sugoi_activerecord_cache(method_name, options)
      @method_name = method_name
      @expire_in = options[:expire_in]
      @cache_key = options[:cache_key] || cache_key
    end
  end

  module KeyValue
    include Base

    def all_to_hash
      {}.tap do |h|
        all.each { |record| h[record.key] = record.value }
      end
    end

    def find_by_from_cache(key: )
      fetch.each do |cached_key, cached_value|
        if cached_key == key.to_s
          return cached_value
        end
      end
      return nil
    end

    def cached
      fetch
    end

    private

    def fetch
      Rails.cache.fetch(@cache_key, expire_in: @expire_in) do
        send(@method_name)
      end
    end
  end

  module Record
    include Base

    def find_by_from_cache(key: )
    end
  end
end
