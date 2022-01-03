class Employee
   attr_reader :name, :title

   def initialize(name, title)
      @name = name      # string
      @title = title    # string
      @earnings = 0     # num
   end

   def pay(amount)
      @earnings += amount
   end
end
