require_relative "list.rb"
require_relative "item.rb"

class TodoBoard

   def initialize(label)
      @list = List.new(label)
   end

   def get_command
      print "\nEnter a command: "
      cmd, *args = gets.chomp.split(" ")
      
      case cmd
      when 'mktodo'
         @list.add_item(*args)
      when "up"
         @list.up(*args.map(&:to_i))
      when "down"
         @list.down(*args.map(&:to_i))
      when "swap"
         @list.swap(*args.map(&:to_i))
      when "sort"
         @list.sort_by_date!
      when "priority"
         @list.print_priority
      when "print"
         if args.empty? || args.nil?
            @list.print
         else
            args.each { |idx| @list.print_full_item(idx.to_i) }
         end
      when "quit"
         return false
      else
         print "Available Commands:
         -mktodo <title> <deadline> <optional description>
         -up <index> <optional amount>
         -down <index> <optional amount>
         -swap <index_1> <index_2>
         -sort
         -priority
         -print <optional index>
         -quit
         "
      end
      true
   end

   def run
      until false
         return if !self.get_command
      end
   end
end

# my_board = TodoBoard.new('groceries')
# my_board.run
# mktodo cheese 2019-10-25 foooooood
# mktodo toothpaste 2019-10-23
# mktodo candy 2019-10-31 sugar-free
# mktodo shampoo 2019-10-25
# print
# sort
# print
# swap 0 3
# print
# print 1
# priority
# down 0
# print
# up 3 2
# print