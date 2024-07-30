require_relative 'node'
require_relative 'linkedlist'

class HashMap
  def initialize
    @buckets = Array.new(16){ LinkedList.new }
    @size = 0
    @collisions = 0
    @capacity = 16
  end

  MAX_LOAD_FACTOR = 0.75

  def is_empty
    @size == 0
  end

  def set(key, value)
    index = bucket_index(key)
    #find way to get the size of each linkedlist as its not an array
    #if @buckets[index].size >= @buckets.length() * MAX_LOAD_FACTOR
    if @collisions >= @buckets.length() * MAX_LOAD_FACTOR
      rehash
      set(key, value)
    else
      @collisions += 1 if !@buckets[index].is_empty?
      @buckets[index].append(key, value)
      @size += 1
    end
  end

  def get(key)
    index = bucket_index(key)
    if @buckets[index]
      return @buckets[index]
  end

  def print
    @buckets.each do |bucket|
      current = bucket.head
      while current
        puts "key: #{current.key}, value: #{current.value}"
        current = current.next_node
      end
    end
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

  def rehash
    @capacity *= 2
    @collisions = 0
    rehash_buckets = Array.new(@capacity) {LinkedList.new}
    #lambda function
    rehash_insert = -> (index, current) {
      rehash_buckets[index].set(current.key, current.value)
    }

    @buckets.each do |bucket|
      #can i do bucket.head??
      current = bucket.head
      while current
        index = bucket_index(current.key)
        @collisions += 1 if !rehash_buckets[index].is_empty?
        rehash_insert.call(index, current)
        current = current.next_node
      end
    end
    @buckets = rehash_buckets
  end

  def capacity = @buckets.size
  def load_factor = @size / capacity

end

key = 'john'
value = { 'name' => 'John', 'age' => 33 }
list = HashMap.new
list.set(key, value)


key2 = 'Sam'
value2 = { 'name' => 'Sam', 'age' => 20 }
list.set(key2, value2)


key3 = 'Dany'
value3 = { 'name' => 'Dany', 'age' => 30 }
list.set(key3, value3)



=begin
key4 = 'Sansa'
value4 = { 'name' => 'Sansa', 'age' => 19 }
list.insert_at(key4, value4, 1)
p list.each
=end

list.print
