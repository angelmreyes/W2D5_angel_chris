class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    value = ""
    self.each_with_index do |el,i|
      value += el.to_s + i.to_s
    end
    return value.to_i.hash
  end
end

class String
  def hash
    alphabet = ("a".."z").to_a
    value = ""
    self.each_char.with_index do |char, i|
      value += alphabet.index(char).to_s + i.to_s
    end
    return value.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    array = []
    self.each { |k, v| array.push(k.to_s.hash, v.to_s.hash) }
    array.sort.hash
  end
end