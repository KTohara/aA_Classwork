require 'byebug'

# Write a method, least_common_multiple, that takes in two numbers and returns 
# the smallest number that is a mutiple of both of the given numbers
def least_common_multiple(num_1, num_2)
    i = 1
    until i == num_1 * num_2
        return i if i % num_1 == 0 && i % num_2 == 0
        i += 1
    end
end


# Write a method, most_frequent_bigram, that takes in a string and 
#returns the two adjacent letters that appear the most in the string.
def most_frequent_bigram(str)
    bigrams = Hash.new(0)
    i = 0
    while i < str.length - 1
        bigrams[str[i..i + 1]] += 1
        i += 1
    end
    sorted = bigrams.sort_by { |k, v| v }
    sorted[-1][0]
end


class Hash
    # Write a method, Hash#inverse, that returns a new hash where the key-value pairs are swapped
    def inverse
        inverse = {}
        self.each { |k, v| inverse[v] = k }
        inverse
    end
end


class Array
    # Write a method, Array#pair_sum_count, that takes in a target number 
    # returns the number of pairs of elements that sum to the given target
    def pair_sum_count(num)
        count = 0
        (0...self.length).count do |i|              # "count" ups by 1 if...
            (i + 1...self.length).any? do |j|
                self[i] + self[j] == num            # ..."any" of these iterations are true...
            end
        end
    end

    # Write a method, Array#bubble_sort, that takes in an optional proc argument.
    # When given a proc, the method should sort the array according to the proc.
    # When no proc is given, the method should sort the array in increasing order.
    #
    # Sorting algorithms like bubble_sort, commonly accept a block. That block accepts
    # two parameters, which represents the two elements in the array being compared.
    # If the block returns 1, it means that the second element passed to the block
    # should go before the first (i.e. switch the elements). If the block returns -1,
    # it means the first element passed to the block should go before the second
    # (i.e. do not switch them). If the block returns 0 it implies that
    # it does not matter which element goes first (i.e. do nothing).
    #
    # This should remind you of the spaceship operator! Convenient :)
    def bubble_sort(&prc)
        prc ||= Proc.new { |a, b| a <=> b }
        not_sorted = true
        while not_sorted
            not_sorted = false
            (0...self.length - 1).each do |i|
                if prc.call(self[i], self[i + 1]) == 1
                    self[i], self[i + 1] = self[i + 1], self[i]
                    not_sorted = true
                end
            end
        end
        self
    end

end

# bubble_sort([4, 12, 2, 8, 1, 14, 9, 25, 24, 81], { |a, b| a.to_s <=> b.to_s })
#          => [1, 12, 14, 2, 24, 25, 4, 8, 81, 9]
# bubble_sort([4, 12, 2, 8, 1, 14, 9, 25, 24, 81])
#          => [1, 2, 4, 8, 9, 12, 14, 24, 25, 81]   # regular bubble sort