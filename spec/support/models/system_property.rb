class SystemProperty < ActiveRecord::Base
  extend SugoiActiverecordCache::KeyValue

  sugoi_activerecord_cache :all_to_hash, expire_in: 10.minutes
end
