require_relative "employee" # was error here - no relative
require 'byebug'

class Startup
   attr_reader :name, :funding, :salaries, :employees

   def initialize(name, funding, salaries)
      @name = name         # string
      @funding = funding   # num
      @salaries = salaries # salaries[title] = salary
      @employees = []      # [empty]
   end

   def valid_title?(title)
      if salaries.key?(title)
         return true
      end
      false
   end

   def >(other_startup)
      self.funding > other_startup.funding ? true : false
   end

   def hire(name, title)
      if !valid_title?(title)
         raise "this job does not take in #{title}"
      end
      employees << Employee.new(name, title)
   end

   def size
      employees.length
   end

   def pay_employee(emp_instance)

      title = emp_instance.title
      salary = salaries[title]
      if @funding > salary
         emp_instance.pay(salary)
         @funding -= salary
      else
         raise "#{salary} was not able to be paid to #{emp_instance.name}"
      end
   end

   def payday
      @employees.each { |person| pay_employee(person) }
   end

   def average_salary
      sum = 0
      @employees.each do |person|
         person_salary = @salaries[person.title]
         sum += person_salary
      end
      sum / @employees.length
   end

   def close
      @employees = []
      @funding = 0
   end

   def acquire(other_startup)
      @funding += other_startup.funding
      other_startup.salaries.each do |title, salary|
         @salaries[title] = salary if !@salaries.key?(title)
      end  
      other_startup.employees.each { |person| @employees << person }
      other_startup.close
   end
end

