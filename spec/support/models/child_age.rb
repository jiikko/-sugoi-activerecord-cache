class ChildAge < ActiveRecord::Base
  extend SugoiActiverecordCache::Record

  sugoi_activerecord_cache :all, expire_in: 10.minutes
end
