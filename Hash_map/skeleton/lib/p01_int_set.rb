require "byebug"

class MaxIntSet
  attr_accessor :store

  def initialize(max)
    @max = (0..max)
    @store = Array.new(max, false)
  end

  def insert(num)
    validate!(num)
    store[num] = true 
  end

  def remove(num)
    validate!(num)
    store[num] = false
  end

  def include?(num)
    store[num]
  end

  private

  attr_reader :max

  def is_valid?(num)
    max.include?(num)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num 
  end

  def remove(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
     resize! if @count == num_buckets
    unless self.include?(num)
      self[num] << num
      @count += 1
    end
  end

  def remove(num)
    if self.include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end


  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    temp = @store.flatten    
    @store = Array.new(num_buckets * 2) { Array.new }
    @count = 0
    temp.each { |ele| self.insert(ele) }
  end
end
