class HashMap
  attr_reader :capacity

  def initialize
    @load_factor = 0.75
    @capacity = 16
    @store = Array.new(@capacity) { [] }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31
        
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
        
    hash_code
  end

  def set(key, value)
    index = hash(key) % @capacity
    bucket = @store[index]

    existing_pair = bucket.find { |k, _| k == key }
    if existing_pair
      existing_pair[1] = value
    else
      bucket << [key, value]
    end
  end

  def get(key)
    index = hash(key) % @capacity
    bucket = @store[index]
    return nil unless bucket


    pair = bucket.find { |k, _| k == key }
    pair ? pair[1] : nil
  end

  def has?(key)
    index = hash(key) % @capacity
    bucket = @store[index]
    return false unless bucket

    bucket.any? { |k, _| k == key }
  end

  def remove(key)
    index = hash(key) % @capacity
    bucket = @store[index]
    return nil unless bucket

    pair = bucket.find { |k, _| k == key}
    return nil unless pair

    bucket.reject! { |k, _| k == key }
  end

  def length
    @store.sum { |bucket| bucket.length }
  end

  def clear
    @store = Array.new(@capacity) { [] }
    @capacity = 16
  end

  def keys
    @store.flat_map { |bucket| bucket.map(&:first) }
  end

  def values
    @store.flat_map { |bucket| bucket.map(&:last) }
  end

  def entries
    @store.flat_map { |bucket| bucket }
  end
end

# example tests/usage
test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts test.length
puts test.capacity

puts "updating ice cream color..."
test.set('ice cream', 'brown')

puts test.length
puts test.capacity

puts test.get('apple')
puts test.get('banana')

puts test.has?('carrot')
puts test.has?('monkey')

puts 'removing dog...'
test.remove('dog')
puts test.has?('dog')

puts test.keys
puts test.values
puts test.entries

puts "clearing..."
test.clear

puts test.length
puts test.capacity