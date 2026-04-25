# method to return a hash with the quantity of appearances of certain sub-strings
def substrings(words, dictionary)
  result_hash = {}

  dictionary.each do |substring|
    count = words.scan(substring).length
    result_hash[substring] = count if count > 0
  end

  result_hash
end

# example:
words = "Howdy partner, sit down! How's it going?"
dictionary = ["below","down","go","going","horn","how","howdy","it","i","low","own","part","partner","sit"]

puts substrings(words, dictionary)
