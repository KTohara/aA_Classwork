require "byebug"

def range(first, last)
    return [] if last <= first 
    # debugger
    range(first, last - 1) << last -1
    # debugger
end

# p range(1, 1) # []
# p range(1, 2) # [1]
# p range(1, 3) # [1,2] 
# p range(1, 4) # [1,2,3]
# p range(1, 5) # [1,2,3,4]

def sum_of_arr(arr)
   return 0 if arr.length == 0
   arr[0] + sum_of_arr(arr[1..-1])
end

# arr = []
# p sum_of_arr(arr) # => 0

# arr = [10]
# p sum_of_arr(arr) # => 10

# arr = [3, 4, 5]
# p sum_of_arr(arr) # => 12

# recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)

# exponent(base, power)
# exponent(100000000, 0) > 1
# exponent(base, power) = base * exponent(base, power - 1)
def exp(base, power)
   return 1 if power == 0
   base * exp(base, power - 1)
end

# p exp(4, 3)

def exp_v2(base, power)
   return 1 if power == 0
   return base if power == 1
   if power.even?
      exp(base, power / 2) ** 2 
   else
      base * (exp(base, (power - 1) / 2) ** 2)
   end
end

exp_v2(10, 3)

class Array
   def deep_dup
      output = []
      self.each do |sub|
         if sub.is_a?(Array)
            output << sub.deep_dup
         else
            output << sub
         end
      end
      output
   end
end

# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"] 
# ]

# p robot_parts.deep_dup
# p [1, [2], [3, [4]]].deep_dup

def fib(n)
   return [1, 1].take(n) if n <= 2
   prev_fib = fib(n - 1)
   prev_fib << prev_fib[-1] + prev_fib[-2]
end

# p fib(0)
# p fib(1)
# p fib(2) # [1, 1]
# p fib(3) # [1, 1, 2]
# p fib(4) # [1, 1, 2, 3]
# p fib(5) # [1, 1, 2, 3, 5]

# needs middle element arr.length / 2
# needs middle element arr.length /

# iterate through arr
   # if target < middle element
      # bsearch(arr.take(arr.length/2))
   # elsif target == middle element 
      # return arr.index(middle_ele) 
   # else
      # bsearch(arr[mid_el + 1..-1])


def bsearch(arr, target)
   mid = arr.length / 2
   return nil? if arr.empty?

   if target < arr[mid]
      bsearch(arr.take(mid), target)
   elsif target == arr[mid]
      mid
   elsif target > arr[mid]
      # bsearch(arr[mid_el + 1..-1])
      # ????
   end
end

   
   # arr.each.with_index do |num, i|
   #    if target < arr[mid]
   #       return arr[mid]
   #    else

   #    end
   # end

# p bsearch([1], 1) # 0
# p bsearch([1, 2, 3], 1) # => 0
# bsearch([2, 3, 4, 5], 3) # => 1
# bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
# bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# bsearch([1, 2, 3, 4, 5, 7], 6) # => nil