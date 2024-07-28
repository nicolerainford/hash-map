class HashMap
  def initialize
    @buckets = Array.new(INITIAL_CAPACITY)
   { LinkedList.new }
    @length = 0
    @collitions = 0
  end

  MAX_LOAD_FACTOR = 0.75
  INITIAL CAPACITY = 16

  def is_empty
    @size == 0
  end

  def insert(key, val)
    if @size == @capacity
      rehash
      insert(key, val)
    else
      index = bucket_index(key)
      @collitions += 1 if !@buckets[index].is_empty?
  end

  private

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def overwrite?(key)
    hash_code = hash(key)
  end

  def bucket_index(key)
    index = hash(key) % capacity
    raise ArgumentError if index.negative? || index >= capacity
    index
  end

  def capacity = @buckets.size
  def load_factor = lengeth / capacity
end
