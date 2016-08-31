require 'spec_helper'

describe SugoiActiverecordCache do
  it 'has a version number' do
    expect(SugoiActiverecordCache::VERSION).not_to be nil
  end
end

describe SugoiActiverecordCache::KeyValue do
  before(:all) do
    SystemProperty.create!(key: :synced_on, value: '2011-01-01')
    SystemProperty.create!(key: :site_name, value: 'アンテナサイト')
  end

  describe '#find_by_from_cache' do
    it '値を返すこと' do
      real = SystemProperty.find_by_from_cache(key: :synced_on)
      expect(real).to eq '2011-01-01'
      real = SystemProperty.find_by_from_cache(key: :site_name)
      expect(real).to eq 'アンテナサイト'
      real = SystemProperty.find_by_from_cache(key: :not_found)
      expect(real).to be_nil
    end
  end

  describe '#cached' do
    it '' do
      real = SystemProperty.cached
      expect(real.keys.size).to eq 2
    end
  end
end

describe SugoiActiverecordCache::Record do
  before(:all) do
    ChildAge.create!(name: 9, description: 'ですです')
    ChildAge.create!(name: 8, description: 'ですです')
  end

  describe '#find_by_from_cache' do
    it '値を返すこと' do
      real = ChildAge.find_by_from_cache(key: :synced_on)
      binding.pry
    end
  end
ChildAge
end
