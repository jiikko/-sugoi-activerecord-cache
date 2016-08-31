$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'active_record'
require 'sqlite3'
require 'pry'

ActiveRecord::Base.establish_connection(
  adapter:   'sqlite3',
  database:  ':memory:'
)
ActiveRecord::Migrator.migrate(File.expand_path('../migrations', __FILE__))

require 'sugoi_activerecord_cache'
require 'support/models/rails_mock'
require 'support/models/system_property'
require 'support/models/child_age'
