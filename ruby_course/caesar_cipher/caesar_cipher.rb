# method to perform a Caesar cipher on a given string with a specified shift
def caesar_cipher(str, shift)
  alphabet = %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

  decoded_message = str.chars.map do |letter|
    if alphabet.include?(letter.downcase)
      index = alphabet.index(letter.downcase)
      letter == letter.upcase ? alphabet[index - shift].upcase : alphabet[index - shift]
    else
      next(letter)
    end
  end

  decoded_message.join
end

# Example usage:
original_string = "Hello, World!"
shift_number = 3
encrypted_string = caesar_cipher(original_string, shift_number)
print encrypted_string
