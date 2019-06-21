require "byebug"

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end
end

class LinkedList
  
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new

    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    unless self.empty?
      @head.next
    end
  end

  def last
    unless self.empty?
      @tail.prev
    end
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    result = self.select { |node| node.key == key }
    if result.empty?
      return nil
    else
      result.first.val
    end
  end

  def include?(key)
    result = self.select { |node| node.key == key }
    return !result.empty?
  end

  def append(key, val)
    node = Node.new(key, val)
    if empty?
      @head.next = node
      @tail.prev = node
      node.prev = @head
      node.next = @tail
    else
      node.prev = @tail.prev
      @tail.prev.next = node
      @tail.prev = node
      node.next = @tail
    end
  end

  def update(key, val)
    result = self.select { |node| node.key == key }
    if result.empty?
      return nil
    else
      result.first.val = val
    end
  end

  def remove(key)
    result = self.select { |node| node.key == key }
    if result.empty?
      return nil
    else
      result.first.next.prev = result.first.prev
      result.first.prev.next = result.first.next
      result.first.prev = nil
      result.first.next = nil
    end
  end

  def each
    node = @head.next
    until node.next == nil
      yield node
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
