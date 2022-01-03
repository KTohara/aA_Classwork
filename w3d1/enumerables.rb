require 'byebug'

class Array
    def my_each(&prc)
        i = 0
      # debugger
        while i < self.length
            prc.call(self[i])
            i += 1
        end
        self
    end

    def my_select(&prc)
        selected = []
        self.my_each do |el|
            selected << el if prc.call(el)
        end
        selected
    end

    def my_reject(&prc)
        selected = []
        self.my_each do |el|
            selected << el if !prc.call(el)
        end
        selected
    end

    def my_any?(&prc)
        self.my_each do |el|
            return true if prc.call(el)
        end
        false
    end

# a = [1, 2, 3]
# a.my_any? { |num| num > 1 } # => true
# a.my_any? { |num| num == 4 } # => false

    def my_all?(&prc)
        self.my_each do |el|
            return false unless prc.call(el)
        end
        true
    end

# a = [1, 2, 3]
# a.my_all? { |num| num > 1 } # => false
# a.my_all? { |num| num < 4 } # => true

    def my_flatten
        flattened = []

        self.my_each do |el|
            if el.is_a?(Array)
                flattened + el.my_flatten
            else
                flattened << el
            end
        end
        flattened
    end

[1, 2, 3, [4, [5, 6]], [[[7]], 8]].my_flatten # => [1, 2, 3, 4, 5, 6, 7, 8]

    def my_zip(*args)
        arr = Array.new(self.length) { Array.new([]) }
        total_arr = [self, *args]

        (0...self.length).each do |row|
            (0...total_arr.length).each do |col|
                arr[row] << total_arr[col][row]
            end
        end
        arr
    end


    def my_rotate(n=1)
        n *= -1 if n < 0
        rotated = []
        (0...self.length).each do |i|
            new_index = (i + n) % self.length
            rotated << self[new_index]
        end
        rotated
    end

# a = [ "a", "b", "c", "d" ]
# a.my_rotate         #=> ["b", "c", "d", "a"]
# a.my_rotate(2)      #=> ["c", "d", "a", "b"]
# a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
# a.my_rotate(15)     #=> ["d", "a", "b", "c"]    

    def my_join(arg="")
        joined_str = ""
        self.each do |el|
            joined_str += el + arg
        end
        joined_str
    end

end


