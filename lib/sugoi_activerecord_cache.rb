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

    def cached
      fetch
    end

    private

    def fetch
      Rails.cache.fetch(@cache_key, expire_in: @expire_in) do
        data = send(@method_name)
        if data.is_a?(Array) || data.is_a?(Hash)
          data
        else
          data.to_a
        end
      end
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
  end

  module Record
    include Base

    def find_by_from_cache(params)
      raise('dose\'t support multi keys') if params.keys.size != 1
      key = params.keys.first
      value = params.values.first
      fetch.each do |cached_record|
        if cached_record.public_send(key) == value
          return cached_record
        end
      end
      return nil
    end
  end
end
