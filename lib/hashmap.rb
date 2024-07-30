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
      current = @buckets[index].head
      while current && current.key != key
        current = current.next_node
      end
      return current.value
    else
      return nil
    end
  end

  def has?(key)
    get(key) != nil
  end

  def remove(key)
   index = bucket_index(key)
    if @buckets[index]
      current = @buckets[index].head
      if current.key == key
        node_to_remove = @buckets[index].head
        @buckets[index].head = current.next_node
        return node_to_remove.value
      end
     current = current.next_node while current.next_node.key != key
     node_to_remove = current.next_node
     current.next_node = node_to_remove.next_node
     @tail = current if node_to_remove == @tail
     @size -= 1
     return node_to_remove.value
    end
  end

  def length
    count = 0
    @buckets.each do |bucket|
      current = bucket.head
      while current
        count += 1
        current = current.next_node
      end
    end
    return count
  end

  def clear
    @buckets = Array.new(16){ LinkedList.new }
  end

=begin
  @buckets.each do |bucket|
    current = bucket.head
    while current
      index = bucket_index(current.key)
      @collisions += 1 if !rehash_buckets[index].is_empty?
      rehash_insert.call(index, current)
      current = current.next_node
    end
  end
=end

def keys
  keyArr = []
  @buckets.each do |bucket|
    current = bucket.head
    while current
      keyArr.push(current.key)
      current = current.next_node
    end
  end
  #return keyArr
  keyArr.empty? ? nil : keyArr
end

def values
  valueArr = []
  @buckets.each do |bucket|
    current = bucket.head
    while current
      valueArr.push(current.value)
      current = current.next_node
    end
  end
  valueArr.empty? ? nil : valueArr
end

def entries
  entryArr = []
  @buckets.each do |bucket|
    current = bucket.head
    while current
      entryArr.push([current.key, current.value])
      current = current.next_node
    end
  end
  entryArr.empty? ? nil : entryArr
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

   def capacity = @buckets.size

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

  #def capacity = @buckets.size
  def load_factor = @size / capacity

end


test = HashMap.new
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
p test.capacity
test.set('moon', 'silver')
p test.capacity









=begin

key = 'John'
value = { 'name' => 'John', 'age' => 33 }
list = HashMap.new
list.set(key, value)


key2 = 'Sam'
value2 = { 'name' => 'Sam', 'age' => 20 }
list.set(key2, value2)


key3 = 'Dany'
value3 = { 'name' => 'Dany', 'age' => 30 }
list.set(key3, value3)


key4 = 'Sansa'
value4 = { 'name' => 'Sansa', 'age' => 19 }
list.set(key4, value4)



p list.length

p list.entries
=end
