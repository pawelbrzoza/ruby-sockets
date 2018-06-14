#!/usr/bin/ruby

class SimpleNumber

	 def initialize(num1, num2)
		  raise unless num1.is_a?(Numeric)
			@x = num1
      raise unless num2.is_a?(Numeric)
      @y = num2
  	end

    def start())
      add()
      multiply()
      return add(), multiply()
    end

  	def add()
    	return @x + @y
  	end

  	def multiply()
    	return @x * @y
  	end
  	
end