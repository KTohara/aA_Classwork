require 'byebug'
require_relative 'item.rb'

class List
   attr_accessor :label
   
   LINE_WIDTH = 42
   INDEX_COL_WIDTH = 5
   ITEM_COL_WIDTH = 20
   DEADLINE_COL_WIDTH = 10

   def initialize(label)
      @label = label    # name of List.new - str
      @items = []       # list of Item.new
   end

   def add_item(title, deadline, description=nil)
      description ||= ""
      if !Item.valid_date?(deadline)
         return false
      else
         @items << Item.new(title, deadline, description)
         return true
      end
   end

   def size
      @items.length
   end

   def valid_index?(idx)
      if @items[idx].nil?
         return false
      end
      true
   end

   def swap(idx_1, idx_2)
      # debugger
      if valid_index?(idx_1) && valid_index?(idx_2)
         @items[idx_1], @items[idx_2] = @items[idx_2], @items[idx_1]
         return true
      end
      false
      # debugger
   end

   def [](index)
      return nil if !valid_index?(index)
      @items[index]
   end

   def priority
      self[0]
   end

   def print
      puts "-" * LINE_WIDTH
      puts " " * 16 + @label.upcase
      puts "-" * LINE_WIDTH
      puts "#{"Index".ljust(INDEX_COL_WIDTH)} | #{"Item".ljust(ITEM_COL_WIDTH)} | #{"Deaddline".ljust(DEADLINE_COL_WIDTH)}"
      puts "-" * LINE_WIDTH
      @items.each.with_index do |item, i|
         puts "#{i.to_s.ljust(INDEX_COL_WIDTH)} | #{item.title.ljust(ITEM_COL_WIDTH)} | #{item.deadline.ljust(DEADLINE_COL_WIDTH)}"
      end
      puts "-" * LINE_WIDTH
   end

   def print_full_item(index)
      if !valid_index?(index)
         # puts "Please Enter a Valid Index!"
         return
      end 
      
      puts "-" * LINE_WIDTH
      puts "#{self[index].title.ljust(LINE_WIDTH * 0.5)}#{@items[index].deadline.rjust(LINE_WIDTH * 0.5)}"
      puts self[index].description
      puts "-" * LINE_WIDTH
   end
   
   def print_priority
      print_full_item(0)
   end

   def up(index, amount=1)  
      return false if !valid_index?(index)
      while index > 0 && amount > 0
         swap(index, index - 1)
         index -= 1
         amount -= 1
      end
      true
   end

   def down(index, amount=1)
      return false if !valid_index?(index)
      while amount > 0 && index < self.size - 1
         swap(index, index + 1)
         index += 1
         amount -= 1
      end
   end
   true

   def sort_by_date!
      @items.sort_by! { |task| task.deadline }
   end
end


# p my_list = List.new('Groceries')
# p my_list.add_item('cheese', '2019-01-25', 'Get American and Feta for good measure.')
# p my_list.add_item('toothpaste', '2020-12-10')
# p my_list.add_item('shampoo', '10-24-2019')
# p my_list.add_item('shampoo', '2019-05-24')
# p my_list.add_item('candy', '2019-05-31', '4 bags should be enough')
# puts my_list.print_full_item(2)
# puts my_list.print_priority
# puts my_list.up(3, 5)
# puts my_list.print
# puts my_list.print
# puts my_list.down(1, 5)
# puts my_list.print
# puts my_list.sort_by_date