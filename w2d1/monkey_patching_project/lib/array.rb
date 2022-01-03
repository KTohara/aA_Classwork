# Monkey-Patch Ruby's existing Array class to add your own custom methods
require 'byebug'

class Array
   def span
      return nil if self.empty?
      sorted = self.sort
      sorted.max - sorted.min
   end

   def average
      return nil if self.empty?
      self.inject(&:+).to_f / self.length
   end

   def median
      return nil if self.empty?
      sorted = self.sort
      left = (self.length / 2) - 1
      right = self.length / 2
      if sorted.length.odd?
         return sorted[self.length / 2]
      else
         return (sorted[left] + sorted[right]) / 2.0
      end
   end

   def counts
      count = Hash.new(0)
      self.each { |key| count[key] += 1 }
      count
   end

   def my_count(val)
      # self.counts[val]
      count = 0
      self.each { |n| count += 1 if n == val }
      count
   end

   def my_index(val)
      self.each.with_index { |n, i| return i if n == val }
      nil
   end

   def my_uniq
      uniques = []
      self.each { |e| uniques << e if !uniques.include?(e) }
      uniques
   end

   def my_transpose
      length = self.length
      height = self[0].length
      grid = Array.new(self.length) {[]}

      (0...height).each do |i|
         (0...length).each do |j|
            grid[i] << self[j][i]
         end
      end
      grid
   end

end

# disp sorted[left]
# disp sorted[right]