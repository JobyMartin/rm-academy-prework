# method to bubble sort the given array without using Array#sort
def bubble_sort(array)
  swapped = true

  until swapped == false
    swapped = false

    array.each_with_index do |num, i|
      next if i == array.length - 1

      if array[i] > array[i + 1]
        array[i], array[i + 1] = array[i + 1], array[i]
        swapped = true
      end
    end

    array
  end

  array
end

# Example usage:
p bubble_sort([97, 192, 178, 197, 107, 84, 50, 81, 33, 173, 188, 63, 49, 174, 75, 8, 166, 10, 155, 172])