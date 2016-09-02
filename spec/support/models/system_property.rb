class SystemProperty < ActiveRecord::Base
  extend SugoiActiverecordCache::KeyValue

  sugoi_activerecord_cache :all, expire_in: 10.minutes
end
