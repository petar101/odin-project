class Node 
  
  attr_accessor :value , :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end



end

class Linked_list

  def initialize
  @new_node = Node.new
  end 

  def first_node
    if next_node == nil 
      new_node
    end
  end
  

def append(value)
  
end

end