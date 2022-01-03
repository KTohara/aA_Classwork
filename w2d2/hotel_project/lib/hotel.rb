require_relative "room"
require 'byebug'

class Hotel
   def initialize(name, capacities)
      @name = name
      @rooms = {}

      capacities.each { |room_name, capacity| @rooms[room_name] = Room.new(capacity) }
   end

   def name
      @name
         .split
         .map(&:capitalize)
         .join(" ")
   end

   def rooms
      @rooms
   end

   def room_exists?(room_name)
      return true if rooms.include?(room_name)
      false
   end

   def check_in(person, room_name)
      if !room_exists?(room_name)
         p 'sorry, room does not exist' 
      else
         if @rooms[room_name].add_occupant(person)
            p 'check in successful'
         else
            p 'sorry, room is full'
         end
      end
   end

   def has_vacancy?
      if rooms.all? { |room_name, instance| instance.full? }
         return false
      else
         return true
      end
   end

   def list_rooms
      rooms.each { |room, instance| puts "#{room}.*#{instance.available_space}" }
   end
end