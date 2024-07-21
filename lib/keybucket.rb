class KeyBucket

  def initialize
    @buckets = {}
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code
  end

  def set(key, value)
    hash_code = hash(key)
    @buckets[hash_code] = value
  end

  def get(key)
    hash_code = hash(key)
    if @buckets[hash_code]
      @buckets[hash_code]
    else
      nil
    end
  end

  def has?(key)
    hash_code = hash(key)
    if @buckets[hash_code]
      true
    else
      false
    end
  end

end
