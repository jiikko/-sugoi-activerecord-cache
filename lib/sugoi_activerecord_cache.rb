require "sugoi_activerecord_cache/version"

module SugoiActiverecordCache
  module Record
    def cache_key
      "sugoi_activerecord_cache/#{self.table_name}"
    end

    def sugoi_activerecord_cache(method_name, options)
      @method_name = method_name
      @expire_in = options[:expire_in]
      @cache_key = options[:cache_key] || cache_key
    end

    def fetch
      Rails.cache.fetch(@cache_key, expire_in: @expire_in) do
        data = send(@method_name)
        if data.is_a?(Array)
          data
        else
          data.to_a
        end
      end
    end

    def find_by_from_cache(params)
      key, value = get_key_value(params)
      find_from_cache(key, value) || self.find_by(key => value)
    end

    def find_by_from_cache!(params)
      key, value = get_key_value(params)
      find_from_cache(key, value) || self.find_by!(key => value)
    end

    def cached
      fetch
    end

    private

    def get_key_value(params)
      raise('don\'t support multi keys arg') if params.keys.size != 1
      [params.keys.first, params.values.first]
    end

    def find_from_cache(key, value)
      fetch.each do |cached_record|
        if cached_record.public_send(key) == value
          return cached_record
        end
      end
      return nil
    end
  end
end
