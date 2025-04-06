class Node 
  
  attr_accessor :value , :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = nil
  end
end

class Linked_list
  def initialize
    @head = nil  # Initialize @head when a new list is created
  end

  def append(value)
    new_node = Node.new(value)   # Step 1: make the new node

    if @head.nil?                # Step 2: if the list is empty
      @head = new_node           # Make the new node the head (and tail)
    else
      current = @head            # Step 3: start walking from the head

      while current.next_node != nil   # Keep going until you reach the tail
        current = current.next_node
      end
      current.next_node = new_node 
      ## adding a new node is just replacing the previous next_node value as the new one
      # thats the only way to link the two. 
    end
  end

  def prepend(value)
    new_node = Node.new(value)

    if @head.nil?
      @head = new_node
    else
      new_node.next_node = @head  # Link new node to the current head
      @head = new_node            # Now update head to be the new node
    end
  end

  def size
    counter = 0

    if @head.nil?                
      counter
    else
      current = @head
      
      while current.next_node != nil
        current = current.next_node
        counter += 1
      end 
      counter
    end
  end

  def head
    if @head.nil?
      puts 'no nodes'
      nil
    else
      @head
    end
  end

  def tail
    if @head.nil?
      puts 'no nodes'
      nil
    else
      current = @head
      while current.next_node != nil
        current = current.next_node
      end
      current
    end
  end

  def at(index)
    counter = 0
  
    if @head.nil?
      puts 'no nodes'
      return nil
    else
      current = @head
  
      while current != nil
        if counter == index
          return current  # Return the node at the right position
        end
  
        current = current.next_node
        counter += 1
      end
  
      return nil  # If index is out of bounds
    end
  end
  
  def pop
    return nil if @head.nil?  # If list is empty, nothing to pop
    
    if @head.next_node.nil?   # If only one node
      popped_value = @head.value
      @head = nil
      return popped_value
    end
    
    current = @head
    # Stop at the second-to-last node
    while current.next_node.next_node != nil
      current = current.next_node
    end
    
    # Save the value we're removing
    popped_value = current.next_node.value
    # Set the new last node's next_node to nil
    current.next_node = nil
    
    popped_value
  end

  def find(value)
    return nil if @head.nil?  # Empty list case
    
    index = 0
    current = @head
    while current != nil      # Check every node including the last one
      if current.value == value
        return index         # Return the index where value was found
      end
      current = current.next_node
      index += 1
    end
    
    nil  # Return nil if value wasn't found
  end

  def contains?(value)
    return false if @head.nil?
    
    current = @head
    while current != nil
      if current.value == value  # Need == for comparison, not = (assignment)
        return true
      end
      current = current.next_node
    end
    
    false  # Return false if we've checked all nodes and found nothing
  end

  def to_s
    return "List = ( nil )" if @head.nil?
    
    result = "List = "
    current = @head
    
    while current != nil
      result += "( #{current.value} )"
      result += " -> " if current.next_node  # Add arrow if there's a next node
      current = current.next_node
    end
    
    result += " -> nil"
    result
  end


end