class SystemProperty < ActiveRecord::Base
  extend SugoiActiverecordCache::Record

  sugoi_activerecord_cache :for_cache, expire_in: 10.minutes

  def self.for_cache
    all.select(:key, :value)
  end
end
