require_relative 'keybucket'
class HashMap
  attr_accessor :key_bucket

  def initialize
    @key_bucket = KeyBucket.new
  end

  def set(key, value)
    @key_bucket.set(key, value)
  end

  def get(key)
    @key_bucket.get(key)
  end

  def has?(key)
    @key_bucket.has?(key)
  end

  def remove(key)
    @key_bucket.remove(key)
  end

end

hash_map = HashMap.new
hash_map.set("Game of thrones", "book")
p hash_map.get("Game of thrones")
p hash_map.remove("Game of thrones")
p hash_map.has?("Game of thrones")
