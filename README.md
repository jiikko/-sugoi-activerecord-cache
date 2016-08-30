# SugoiActiverecordCache
* memcachdにレコードのcacheを入れておき、モデルコールバックでcacheのclearをすると古いキャッシュが残り続ける可能性がある
  * マルチAZ環境でmemcachedがzone毎に存在する場合、callbackでcacheをclearしていたらclearするのはリクエストを受けたzoneのmemcachedだけになり、古いキャッシュが残り続けてしまう
    * モデルコールバックでのcacheのclearは難しい
* モデル内からでもキャッシュから呼びたい
  * フラグメントキャッシュでは粒度が大きすぎる

のでモデルで期限付きのキャッシュを返します

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sugoi_activerecord_cache'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sugoi_activerecord_cache

## Usage
* cache type
  * key value
  * 1 recoed

### key value
```ruby
class SystemProperty < ActiveRecord::Base
  include SugoiActiveRecordCache::KeyValue

  def self.all_to_hash
    {}.tap do |h|
      self.all.each { |recoed| h[record.key] = record.value }
    end
  end

  sugoi_activerecord_cache(expire_in: 10.minutes) do |cache|
    cache.set_key_value = SystemProperty.all_to_hash
  end
end

SystemProperty.create!(key: :synced_at, value: Time.now)
SystemProperty.create!(key: :site_name, value: 'アンテナサイト')
SystemProperty.find_from_cache(key: :synced_at)
SystemProperty.find_from_cache(key: :synced_at)
```

### 1 recoed
```ruby
class Category < ActiveRecord::Base
  include SugoiActiveRecordCache::Record
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jiikko/sugoi_activerecord_cache.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
