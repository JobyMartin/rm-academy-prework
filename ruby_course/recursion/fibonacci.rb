
def fibs(num)
  return [] if num == 0
  return [0] if num == 1

  fib = [0, 1]
  (1..num - 2).to_a.each do |i|
   fib << fib[i] + fib[i - 1] 
  end
  fib
end

def fibs_rec(num)
  puts 'This was printed recursively'

  case num
  when 0
    return []
  when 1
    return [0]
  when 2
    return [0, 1]
  end

  array = fibs_rec(num - 1)
  array << array[-2] + array [-1]
end

p fibs(8)
p fibs_rec(8)
