require_relative 'node'

class HashMap
  def initialize
    @length = 0
   #@buckets = Array.new(16)
    #@load_factor = 0.75
    @size = 0
    @head = nil
    @tail = nil
  end

  #add pair
  def append(key,value)
    new_node = Node.new(key, value)

    if !@head
      @head = new_node
      @tail = new_node
    else
      @tail.next_node = new_node
      @tail = new_node
    end
    @size += 1
  end

  #delete
  def delete(key)
    #case to remove key if its head
    p "head val #{@head.key}"
    if @head.key == key
     @head = @head.next_node
     return
    end
    key_to_del = key
    current = @head
    while current.next_node.key != key
      current = current.next_node
    end

    node_to_remove = current.next_node
    current.next_node = node_to_remove.next_node
    @tail = current if node_to_remove == @tail
    @size -= 1

  end

  def to_s
    #( value ) -> ( value ) -> ( value ) -> nil
    current = @head
    while current
      print "(#{current.key} #{current.value}) -> "
      current = current.next_node
    end

  end

  def is_empty?
    @head.nil
  end

  def contains?(key)
    #iterate thru and look at values. if current.value matches input param return true
    return false if @head == nil
    current = @head
    while current
      return true if current.key == key
      current = current.next_node
    end
    false
  end

















=begin
  def set(key, value)
   #1 check if key already exists in a hashmap
   current = overwrite?(key)
   if current
    current.value = value
    return current
   end

   #2 make new bucket if kv is over bucket limit
   if (@length + 1) > (@buckets.length * @load_factor).round



    hash_code = hash(key)
    @buckets[hash_code] = value
  end
=end

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

end

key = "john"
value = {"name" => "John", "age" => 33}
list = HashMap.new
list.append(key, value)

key2 = "Sam"
value2 = {"name" => "Sam", "age" => 20}
list.append(key2, value2)
list.to_s

key3 = "Dany"
value3 = {"name" => "Dany", "age" => 3}
list.append(key3, value3)

list.delete("john")
list.to_s
