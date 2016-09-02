# SugoiActiverecordCache
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
  * list of activerecord instance

### key value
```ruby
class SystemProperty < ActiveRecord::Base
  include SugoiActiveRecordCache::KeyValue

  sugoi_activerecord_cache :all, expire_in: 10.minutes
end

SystemProperty.create!(key: :synced_on, value: '2011-01-01')
SystemProperty.create!(key: :site_name, value: 'アンテナサイト')

SystemProperty.find_by_from_cache(key: :synced_at) # => '2011-01-01'
SystemProperty.find_by_from_cache(key: :site_name) # => 'アンテナサイト'
SystemProperty.cached
```

### list of activerecord instance
```ruby
class ChildAge < ActiveRecord::Base
  include SugoiActiveRecordCache::Record

  sugoi_activerecord_cache :for_cache, expire_in: 10.minutes

  def self.for_cache
    all.select(:id, :name, :description)
  end
end

ChildAge.create!(name: 9, description: 'ますます')
ChildAge.create!(name: 8, description: 'ですです')

ChildAge.find_by_from_cache(name: 9)
ChildAge.find_by_from_cache(description: 'ですです')
ChildAge.cached
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jiikko/sugoi_activerecord_cache.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
