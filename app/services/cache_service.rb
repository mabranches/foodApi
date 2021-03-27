class Cache
  attr_reader :cache

  def initialize
    @cache = Redis.new(:host => 'redis')
  end
end
