class Item
   attr_accessor :description, :title
   attr_reader :deadline

   def self.valid_date?(date_str)   # boolean
      date = date_str.split("-")
      year = date[0]
      month = date[1].to_i
      day = date[2].to_i

      if year.length == 4 && month <= 12 && day <= 31
         return true
      end
      false
   end

   def initialize(title, deadline, description)
      if !Item.valid_date?(@deadline)
         raise "Invalid Date: Use format YYYY-MM-DD"
      end
      @title = title                # str
      @deadline = deadline          # str
      @description = description    # str     
   end

   def deadline=(new_deadline)
      if !Item.valid_date?(new_deadline)
         raise "Invalid Date: Use format YYYY-MM-DD"
      else
         @deadline = new_deadline
      end
   end
end

# YYYY-MM-DD
# p Item.valid_date?('2019-10-25') # true
# p Item.valid_date?('1912-06-23') # true
# p Item.valid_date?('2018-13-20') # false
# p Item.valid_date?('2018-12-32') # false
# p Item.valid_date?('10-25-2019') # false 

# i2 = Item.new('Fix login page', '2019-10-25', 'The page loads too slow.')

# i1 = Item.new(
#     'Buy Cheese',
#     '2019-10-21',
#     'We require American, Swiss, Feta, and Mozzarella cheese for the Happy hour!')

# puts my_item = Item.new('Fix login page', '2019-10-22', 'It loads slow.')
   #  => #<Item:0x
   #  @deadline="2019-10-22",
   #  @description="It loads slow.",
   #  @title="Fix login page">
# p my_item.title # => "Fix login page"
# p my_item.description = 'It loads waaaaaay too slow!' # => "It loads waaaaaay too slow!"
# p my_item
# p my_item.deadline = "10-23-2019" # RuntimeError: deadline is not valid
# p my_item.deadline # => "2019-10-22"
# p my_item.deadline = "2019-10-23" # => "2019-10-23"
# p my_item.deadline # => "2019-10-23"
# puts my_item
# => #<Item:0x
#     @deadline="2019-10-23",
#     @description="It loads waaaaaay too slow!",
#     @title="Fix login page">

