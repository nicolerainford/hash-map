require_relative 'node'

class LinkedList
attr_accessor :head, :tail, :size

  def initialize
    @length = 0
    # @buckets = Array.new(16)
    # @load_factor = 0.75
    @size = 0
    @head = nil
    @tail = nil
  end

  # add pair
  def append(key, value)
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

  # add prepend
  def prepend(key, value)
    new_node = Node.new(key, value)
    if !@head
      @head = new_node
      @tail = new_node
    else
      temp = @head
      @head = new_node
      @head.next_node = temp
    end
    @size += 1
  end

  def at(index)
    count = 0
    current = @head
    while index > count
      current = current.next_node
      # puts current
      count += 1
    end
    current.value
  end

  # remove
  def pop
    # handle case where list is empty or has 1 one node
    return nil if @size == 0

    if @size == 1
      popped_val = @tail.value
      @head = nil
      @tail = nil
    else
      current = @head
      current = current.next_node while current.next_node != @tail
      p "current before tail #{current.value} "
      popped_val = @tail.value
      current.next_node = nil
      @tail = current
    end

    @size -= 1
  end

  # delete
  def delete(key)
    # case to remove key if its head
    if @head.key == key
      @head = @head.next_node
      return
    end
    current = @head
    current = current.next_node while current.next_node.key != key

    node_to_remove = current.next_node
    current.next_node = node_to_remove.next_node
    @tail = current if node_to_remove == @tail
    @size -= 1
  end

  def find(key)
    # return index of given value or nil if not found
    return nil if @head.nil?

    current = @head
    index = 0
    while current
      return index if current.key == key

      current = current.next_node
      index += 1
    end
  end

  def insert_at(key, value, index)
    new_node = Node.new(key, value)
    raise Index, 'Index out of bounds' if index < 0 || index > @size

    return append(key, value) unless @head

    return prepend(key, value) if index == 0

    return append(key, value) if index == @size

    current = @head
    count = 0
    while count < index - 1
      current = current.next_node
      count += 1
    end

    temp = current.next_node
    current.next_node = new_node
    new_node.next_node = temp
    @size += 1
  end

  def remove_at(index)
    # need to stop at 1 before index skip one then go to one after index so i can do prev.next_node = after_index
    raise IndexError, 'Index out of bounds' if index < 0 || index >= @size

    if index == 0
      @head = @head.next_node
      @size -= 1
      @tail = nil if @size == 0
      return
    end

    current = @head
    count = 0
    while count < index - 1
      current = current.next_node
      count += 1
    end

    node_to_remove = current.next_node
    current.next_node = node_to_remove.next_node
    @tail = current if node_to_remove == @tail
    @size -= 1
  end

  def to_s
    # ( value ) -> ( value ) -> ( value ) -> nil
    current = @head
    while current
      print "(#{current.key} #{current.value}) -> "
      current = current.next_node
    end
  end

  def is_empty?
    @head.nil?
  end

  def contains?(key)
    # iterate thru and look at values. if current.value matches input param return true
    return false if @head.nil?

    current = @head
    while current
      return true if current.key == key

      current = current.next_node
    end
    false
  end

  def size
    current = @head
    count = 0
    while current
      current = current.next_node
      count += 1
    end
    count
  end

  def each
    return unless block_given?
    current = @head
    while current
      yield(current.key, current.value)
      current = current.next_node
    end
  end

  #   def set(key, value)
  #    #1 check if key already exists in a hashmap
  #    current = overwrite?(key)
  #    if current
  #     current.value = value
  #     return current
  #    end
  #
  #    #2 make new bucket if kv is over bucket limit
  #    if (@length + 1) > (@buckets.length * @load_factor).round
  #
  #
  #
  #     hash_code = hash(key)
  #     @buckets[hash_code] = value
  #   end

  private


end
