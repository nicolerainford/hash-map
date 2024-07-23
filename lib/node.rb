class Node
  attr_accessor :value, :key, :next_node

  def initialize(key = nil, value = nil)
    @value = value
    @key = key
    @next_node = nil
  end
end
