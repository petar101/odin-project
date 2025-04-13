# frozen_string_literal: true

class Node
  attr_accessor :key, :value, :next_node

  def initialize(key, value)
    @key = key
    @value = value
    @next_node = nil
  end
end

class HashMap
  attr_reader :capacity, :load_factor ## ive assigned two variables as readers do i give them the value also now ?

  def initialize(capacity = 16, load_factor = 0.75)
    @capacity = capacity
    @load_factor = load_factor
    @buckets = Array.new(capacity) # Creates an array with 'capacity' number of nil elements
    @next_node = nil
    @nodes = 0
  end

  def grow
    return unless needs_growing?

    old_buckets = @buckets
    @capacity *= 2
    @buckets = Array.new(@capacity)
    @nodes = 0

    # Rehash all existing entries
    old_buckets.each do |bucket|
      current = bucket
      while current
        set(current.key, current.value)
        current = current.next_node
      end
    end
  end

  def needs_growing?
    # Calculate current load factor
    current_load = @nodes.to_f / @capacity
    current_load >= @load_factor
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code % @capacity # This ensures the result is between 0 and 15
  end

  def set(key, value)
    hash = hash(key)

    if @buckets[hash].nil?
      # First node in this bucket
      @buckets[hash] = Node.new(key, value)
    else
      # Handle collision by chaining
      current = @buckets[hash]
      while current
        if current.key == key
          current.value = value # Update existing key
          return
        end
        break unless current.next_node

        current = current.next_node
      end
      # Add new node at the end of the chain
      current.next_node = Node.new(key, value)
    end
    @nodes += 1
    grow if needs_growing?
  end

  def collision?(hash, key)
    # Check if there's already an entry in the bucket
    return false if @buckets[hash].nil? || @buckets[hash].empty?

    # Check if the key already exists in the bucket
    @buckets[hash].each do |entry|
      return true if entry[0] != key # Collision if different key in same bucket
    end

    false  # No collision if we get here
  end

  def get(key)
    hash = hash(key)
    current = @buckets[hash]

    while current
      return current.value if current.key == key

      current = current.next_node
    end

    nil
  end

  def has?(key)
    hash = hash(key)
    current = @buckets[hash]

    while current
      return true if current.key == key

      current = current.next_node
    end

    false  # Return false if we reach the end without finding the key
  end

  def remove(key)
    return unless has?(key) # Return early if key doesn't exist

    hash = hash(key)
    current = @buckets[hash]

    # Handle case where there's only one node
    if @nodes == 1
      current.key = nil
      current.value = nil
      @nodes -= 1
      return
    end

    # Iterate through all nodes in the bucket
    while current
      # Check if current node matches the key
      if current.key == key
        current.key = nil
        current.value = nil
        @nodes -= 1
      end

      # Check if next node exists and matches the key
      if current.next_node == key
        current.next_node = current.next_node.next_node
        @nodes -= 1
      end

      current = current.next_node
    end
  end

  def length
    @nodes
  end

  def clear
    @buckets = Array.new(@capacity)
    @nodes = 0
  end

  def traverse_buckets
    result = []
    @buckets.each do |bucket|
      current = bucket
      while current
        yield(current, result)
        current = current.next_node
      end
    end
    result
  end

  def keys
    traverse_buckets { |node, array| array << node.key }
  end

  def values
    traverse_buckets { |node, array| array << node.value }
  end

  def entries
    traverse_buckets { |node, array| array << [node.key, node.value] }
  end
end
