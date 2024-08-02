require_relative 'node'
require_relative 'linkedlist'
require_relative 'hashmap'

class HashSet
  attr_accessor :capacity

  def initialize
    @hashset = HashMap.new
  end

  MAX_LOAD_FACTOR = 0.75

  def is_empty
    @hashset.is_empty?
  end

  def set(key)
    @hashset.set(key,true)
  end

  def get(key)
    index = bucket_index(key)
    if @buckets[index]
      current = @buckets[index].head
      while current && current.key != key
        current = current.next_node
      end
      return current
    else
      return nil
    end
  end

  def has?(key)
    @hashset.has?(key)
  end

  def remove(key)
   index = bucket_index(key)
    if @buckets[index]
      current = @buckets[index].head
      if current.key == key
        node_to_remove = @buckets[index].head
        @buckets[index].head = current.next_node
        return node_to_remove
      end
     current = current.next_node while current.next_node.key != key
     node_to_remove = current.next_node
     current.next_node = node_to_remove.next_node
     @tail = current if node_to_remove == @tail
     @size -= 1
     return node_to_remove
    end
  end

  def length
    @hashset.length
  end

  def clear
    @hashset.clear
  end

  def keys
    @hashset.keys
  end

  def entries
  @hashset.entries
  end

  def print
    @hashset.print
  end

  def capacity
    @hashset.capacity
  end

  private

  def hash(key)
    @hashset.hash(key)
  end

  def overwrite?(key)
    hash_code = hash(key)
  end

  def bucket_index(key)
    @hashset.bucket_index(key)
  end

  def load_factor = length * MAX_LOAD_FACTOR

end

test = HashSet.new
test.set('apple')
test.set('banana')
test.set('carrot')
test.set('dog')
test.set('elephant')
test.set('frog')
test.set('grape')
test.set('hat')
test.set('ice cream')
test.set('jacket')
test.set('kite')
test.set('lion')
p test.capacity
test.set('moon')
p test.entries
