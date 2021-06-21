require_relative "room"

class Hotel
    def initialize(name, rooms)
        @name = name
        @rooms = {}
        rooms.each do |k,v|
            @rooms[k] = Room.new(v)
        end
    end

    def name
        name = @name.split
        name.map! do |word|
            word.capitalize
        end
        name.join(" ")
    end

    def rooms
        @rooms
    end

    def room_exists?(room)
        if @rooms.has_key?(room)
            return true
        end
        false
    end

    def check_in(person, room)
        if !self.room_exists?(room)
            puts "sorry, room does not exist"
        else
            if @rooms[room].add_occupant(person)
                puts "check in successful"
            else
                puts "sorry, room is full"
            end
        end
    end
    
    def has_vacancy?
        return false if @rooms.values.all? {|room| room.full?}
        true
    end

    def list_rooms
        @rooms.each do |key, room|
            puts key + ": " + room.available_space.to_s
        end
    end



end
