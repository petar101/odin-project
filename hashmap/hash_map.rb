class HashMap

  attr_reader :capacity, :load_factor ## ive assigned two variables as readers do i give them the value also now ? 


  def initialize(capacity = 16, load_factor = 0.75)
    @capacity = capacity
    @load_factor = load_factor
    @buckets = Array.new(capacity)  # Creates an array with 'capacity' number of nil elements
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end

  def set(key, value) 
    result = hash(key)

    ## for result.each, put the set in buckets(#result)

       # write method to say for every hash value, take that set in the corresponding number for the bucket
    # end goal, set automaically makes a hash to it and sends it to the right bucket. 
    
  end
 


end






# in the bucket there will be 1 node (hask key + value), nil or a chained node. 
# hashes will have their own hash code which will redirect nodes to what bucket.
# each bucket should be measured which the capacity they can withhold and load factor(0.75) then expand 
# 

