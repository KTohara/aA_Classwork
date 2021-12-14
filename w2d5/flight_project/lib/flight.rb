require_relative "passenger.rb"
require 'byebug'

class Flight
   attr_reader :passengers

   def initialize(flight_number, capacity)
      @flight_number = flight_number   # string
      @capacity = capacity             # num
      @passengers = []
   end

   def full?
      if @passengers.length >= @capacity
         return true
      end
      false
   end

   def board_passenger(pass_name)   # passenger instance
      # debugger
      if pass_name.has_flight?(@flight_number) && !full?
         @passengers << pass_name
      end
   end
   
   def list_passengers
      @passengers.map { |person| person.name }
   end

   def [](index)     # number
      @passengers[index]
   end

   def <<(pass_name)    # passenger instance
      @passengers << board_passenger(pass_name)
   end
end

f = Flight.new("ASJDASD", 10)
p f.passengers